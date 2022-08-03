import 'package:dart_remote_config/experimentation/experimentation_engine.dart';
import 'package:dart_remote_config/model/experimentation_engine_result.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:dart_remote_config/repository/remote_config_repository.dart';
import 'package:dart_remote_config/utils/extensions.dart';

class ExperimentationModule {
  final ExperimentationEngine _engine;
  final RemoteConfigRepository _repository;

  ExperimentationModule(this._engine, this._repository);

  Future<ExperimentationEngineResult> compute(RemoteConfig config) async {
    final subscribedVariantIds = await _repository.readSubscribedVariantIds();
    final newResult = _engine.computeResult(config, subscribedVariantIds);
    await _repository.saveSubscribedVariantsIds(newResult.subscribedVariantIds);
    return newResult;
  }
}
