import 'package:dart_remote_config/model/experiment.dart';
import 'package:dart_remote_config/model/feature.dart';
import 'package:dart_remote_config/model/variant.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'experimentation_engine_result.freezed.dart';
part 'experimentation_engine_result.g.dart';

enum ExperimentationEngineResultError {
  errorWhileParsing,
  errorNoData,
}

@freezed
class ExperimentResult with _$ExperimentResult {
  const factory ExperimentResult({
    required Experiment experiment,
    required Variant initialSelectedVariant,
  }) = _ExperimentInstance;

  factory ExperimentResult.fromJson(Map<String, Object?> json) =>
      _$ExperimentResultFromJson(json);
}

extension ExperimentInstanceExtension on ExperimentResult {
  bool get isConcluded => experiment.isConcluded;

  Variant get selectedVariant => experiment.isConcluded
      ? experiment.variants.single
      : initialSelectedVariant;
}

@freezed
class ExperimentationEngineResult with _$ExperimentationEngineResult {
  const factory ExperimentationEngineResult.success(
    final Set<ExperimentResult> subscribedExperiments,
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
      subscribedExperiments.where((e) => !e.isConcluded).toSet();

  Set<Feature> get enabledFeatures => subscribedExperiments
      .map((it) => it.selectedVariant.featureIds)
      .expand((it) => it)
      .map(
        (it) => featuresDefinedInConfig.firstWhere(
          (feature) => feature.id == it,
          orElse: () => Feature(id: it),
        ),
      )
      .toSet();
}
