import 'package:dart_remote_config/model/remote_config.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_config_response.freezed.dart';

enum RemoteConfigResponseError {
  errorNoDataFetched,
  errorWhileParsing,
  errorNoData,
}

@freezed
class RemoteConfigResponse with _$RemoteConfigResponse {
  const factory RemoteConfigResponse.success(
    final RemoteConfigs remoteConfigs,
  ) = RemoteConfigResponseSuccess;

  const factory RemoteConfigResponse.failure({
    required RemoteConfigResponseError error,
    String? message,
  }) = RemoteConfigResponseFailure;
}
