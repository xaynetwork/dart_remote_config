import 'package:dart_remote_config/model/experiment.dart';
import 'package:dart_remote_config/model/variant.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'experimentation_engine_result.freezed.dart';
part 'experimentation_engine_result.g.dart';

enum ExperimentationEngineResultError {
  errorWhileParsing,
  errorNoData,
}

@freezed
class ExperimentInstance with _$ExperimentInstance {
  const factory ExperimentInstance({
    required Experiment experiment,
    required Variant selectedVariant,
  }) = _ExperimentInstance;

  factory ExperimentInstance.fromJson(Map<String, Object?> json) =>
      _$ExperimentInstanceFromJson(json);
}

@freezed
class ExperimentationEngineResult with _$ExperimentationEngineResult {
  const factory ExperimentationEngineResult.success(
    final List<ExperimentInstance> subscribedExperiments,
  ) = ExperimentationEngineResultSuccess;

  const factory ExperimentationEngineResult.failure({
    required ExperimentationEngineResultError error,
    String? message,
  }) = ExperimentationEngineResultFailure;
}
