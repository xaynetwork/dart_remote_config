import 'package:dart_remote_config/experimentation/experimentation_engine.dart';
import 'package:dart_remote_config/model/experimentation_engine_result.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:dart_remote_config/remote_config_fetcher.dart';
import 'package:dart_remote_config/repository/remote_config_repository.dart';
import 'package:dart_remote_config/utils/extensions.dart';

abstract class ExperimentationModule {
  Future<ExperimentationEngineResult> compute(RemoteConfig config);

  Future<ExperimentationEngineResult> fetchThenCompute({
    required S3Factory s3Factory,
    required RConfigFileNameBuilder nameBuilder,
    required String bucketName,
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
  Future<ExperimentationEngineResult> fetchThenCompute({
    required S3Factory s3Factory,
    required RConfigFileNameBuilder nameBuilder,
    required String bucketName,
    required String versionString,
  }) async {
    final _fetcher = S3RemoteConfigFetcher(
      s3Factory: s3Factory,
      nameBuilder: nameBuilder,
      bucketName: bucketName,
    );

    final response = await _fetcher.fetch();

    final config = response.whenOrNull(
      success: (success) => success.findConfig(versionString),
    );

    if (config != null) {
      await _repository.saveRemoteConfig(config);
      return compute(config);
    }

    final previousRemoteConfig = await _repository.readRemoteConfig();
    return compute(previousRemoteConfig);
  }
}
