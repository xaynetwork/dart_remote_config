import 'package:dart_remote_config/fetcher/remote_config_fetcher.dart';
import 'package:dart_remote_config/model/remote_config_response.dart';
import 'package:dart_remote_config/repository/remote_config_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

typedef LoadFallbackRemoteConfig = Future<String> Function();

class CacheOnlyUpdateUnawaited extends CacheStrategy {
  final RemoteConfigRepository _repository;
  final LoadFallbackRemoteConfig _fallbackRemoteConfig;
  Future? _fetchFuture;

  @visibleForTesting
  Future? get fetchFuture => _fetchFuture;

  CacheOnlyUpdateUnawaited(this._repository, this._fallbackRemoteConfig);

  @override
  Future<String> fetch(Future<String> Function() request) async {
    // unawaited fetch and store the remote config for the next startup
    _fetchFuture = request().then((value) async {
      final updatedRemoteConfig =
          await StringRemoteConfigFetcher(value).fetch();
      if (updatedRemoteConfig is RemoteConfigResponseSuccess) {
        await _repository.saveRemoteConfig(value);
      }
    });

    final config = await _repository.readRemoteConfig();
    if (config == null || config.isEmpty) {
      return _fallbackRemoteConfig();
    } else {
      return config;
    }
  }
}

class NoCachingStrategy extends CacheStrategy {
  const NoCachingStrategy();

  @override
  Future<String> fetch(Future<String> Function() request) => request();
}

abstract class CacheStrategy {
  const CacheStrategy();

  Future<String> fetch(Future<String> Function() request);
}
