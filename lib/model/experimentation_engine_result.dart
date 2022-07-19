import 'package:dart_remote_config/model/experiment.dart';
import 'package:dart_remote_config/model/feature.dart';
import 'package:dart_remote_config/model/variant.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'experimentation_engine_result.freezed.dart';

part 'experimentation_engine_result.g.dart';

const experimentIdMatcher = '%%';
const variantIdMatcher = '%%';

enum ExperimentationEngineResultError {
  errorWhileParsing,
  errorNoData,
}

@freezed
class ExperimentResult with _$ExperimentResult {
  const factory ExperimentResult.subscribed({
    required Experiment experiment,
    required Variant initialSelectedVariant,
  }) = ExperimentResultSubscribed;

  const factory ExperimentResult.notSubscribed({
    required Experiment experiment,
  }) = ExperimentResultNotSubscribed;

  factory ExperimentResult.fromJson(Map<String, Object?> json) =>
      _$ExperimentResultFromJson(json);
}

extension ExperimentResultExtension on ExperimentResult {
  bool get isConcluded => experiment.isConcluded;

  Variant? get selectedVariant => mapOrNull(
        subscribed: (subscribed) => experiment.isConcluded
            ? experiment.variants.single
            : subscribed.initialSelectedVariant,
      );

  String get variantId =>
      experimentIdMatcher +
      experiment.id +
      experimentIdMatcher +
      variantIdMatcher +
      map(
          subscribed: (s) => s.initialSelectedVariant.id,
          notSubscribed: (ns) => '') +
      variantIdMatcher;
}

@freezed
class ExperimentationEngineResult with _$ExperimentationEngineResult {
  const factory ExperimentationEngineResult.success(
    final Set<ExperimentResult> computedExperiments,
    final List<Feature> featuresDefinedInConfig,
  ) = ExperimentationEngineResultSuccess;

  const factory ExperimentationEngineResult.failure({
    required ExperimentationEngineResultError error,
    String? message,
  }) = ExperimentationEngineResultFailure;

  factory ExperimentationEngineResult.fromJson(Map<String, dynamic> json) =>
      _$ExperimentationEngineResultFromJson(json);
}

extension ExperimentationEngineResultSuccessExtension
    on ExperimentationEngineResultSuccess {
  Set<ExperimentResult> get activeExperiments =>
      computedExperiments.where((e) => !e.isConcluded).toSet();

  Set<Feature> get enabledFeatures => computedExperiments
      .whereType<ExperimentResultSubscribed>()
      .map((it) => it.selectedVariant?.featureIds ?? [])
      .expand((it) => it)
      .map(
        (it) => featuresDefinedInConfig.firstWhere(
          (feature) => feature.id == it,
          orElse: () => Feature(id: it),
        ),
      )
      .toSet();

  Set<String> get subscribedIds =>
      activeExperiments.map((it) => it.variantId).toSet();
}

extension ExperimentationEngineResultExtension on ExperimentationEngineResult {
  Set<String>? get subscribedIds =>
      mapOrNull(success: (success) => success.subscribedIds);
}
