import 'package:dart_remote_config/experimentation/experimentation_engine.dart';
import 'package:dart_remote_config/model/experimentation_engine_result.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:dart_remote_config/remote_config_fetcher.dart';
import 'package:dart_remote_config/repository/remote_config_repository.dart';
import 'package:dart_remote_config/utils/extensions.dart';

abstract class ExperimentationModule {
  Future<ExperimentationEngineResult> compute(RemoteConfig config);

  /// TODO: refactor to a remote config manager
  Future<ExperimentationEngineResult?> fetchThenCompute({
    required S3RemoteConfigFetcher fetcher,
    required String versionString,
  });
}

class ExperimentsFetcherImpl implements ExperimentationModule {
  final ExperimentationEngine _engine = ExperimentationEngineImpl();
  final RemoteConfigRepository _repository = RemoteConfigRepositoryImpl();

  @override
  Future<ExperimentationEngineResult> compute(RemoteConfig config) async {
    final subscribedVariantIds = await _repository.readSubscribedVariantIds();
    final newResult = _engine.computeResult(config, subscribedVariantIds);
    await _repository.saveSubscribedVariantsIds(newResult.subscribedVariantIds);
    return newResult;
  }

  @override
  Future<ExperimentationEngineResult?> fetchThenCompute({
    required S3RemoteConfigFetcher fetcher,
    required String versionString,
  }) async {
    final response = await fetcher.fetch();

    final config = response.whenOrNull(
      success: (success) => success.findConfig(versionString),
    );

    if (config != null) {
      await _repository.saveRemoteConfig(config);
      return compute(config);
    }

    final previousRemoteConfig = await _repository.readRemoteConfig();
    return previousRemoteConfig == null ? null : compute(previousRemoteConfig);
  }
}
