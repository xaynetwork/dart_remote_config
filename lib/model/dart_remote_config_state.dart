import 'package:dart_remote_config/model/experimentation_engine_result.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:dart_remote_config/model/remote_config_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dart_remote_config_state.freezed.dart';

enum DartRemoteConfigStatus {
  failedFetching,
  noSuitableVersion,
}

@freezed
class DartRemoteConfigState with _$DartRemoteConfigState {
  const factory DartRemoteConfigState.success({
    required RemoteConfig config,
    required ExperimentationEngineResult experiments,
  }) = _Success;

  const factory DartRemoteConfigState.failed({
    required DartRemoteConfigStatus status,
    RemoteConfigResponseFailure? fetcherError,
  }) = _Failure;
}
