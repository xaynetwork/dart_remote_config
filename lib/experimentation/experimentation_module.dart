import 'package:dart_remote_config/experimentation/experimentation_engine.dart';
import 'package:dart_remote_config/model/experimentation_engine_result.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:dart_remote_config/repository/remote_config_repository.dart';
import 'package:dart_remote_config/utils/extensions.dart';

abstract class ExperimentationModule {
  Future<ExperimentationEngineResult> fetch(RemoteConfig config);
}

class ExperimentsFetcherImpl implements ExperimentationModule {
  final ExperimentationEngine _engine = ExperimentationEngineImpl();
  final RemoteConfigRepository _repository = RemoteConfigRepositoryImpl();

  @override
  Future<ExperimentationEngineResult> fetch(RemoteConfig config) async {
    final subscribedVariantIds = await _repository.readSubscribedVariantIds();
    final newResult = _engine.computeResult(config, subscribedVariantIds);
    await _repository.saveSubscribedVariantsIds(newResult.subscribedVariantIds);
    return newResult;
  }
}
