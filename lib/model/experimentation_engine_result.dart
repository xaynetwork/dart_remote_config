import 'package:dart_remote_config/model/experiment.dart';
import 'package:dart_remote_config/model/feature.dart';
import 'package:dart_remote_config/model/variant.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'experimentation_engine_result.freezed.dart';

part 'experimentation_engine_result.g.dart';

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

@freezed
class ExperimentationEngineResult with _$ExperimentationEngineResult {
  const factory ExperimentationEngineResult(
    final Set<ExperimentResult> computedExperiments,
    final List<Feature> featuresDefinedInConfig,
  ) = _ExperimentationEngineResult;

  factory ExperimentationEngineResult.fromJson(Map<String, dynamic> json) =>
      _$ExperimentationEngineResultFromJson(json);
}
