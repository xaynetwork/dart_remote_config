import 'package:dart_remote_config/experimentation/experimentation_engine.dart';
import 'package:dart_remote_config/model/experimentation_engine_result.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:hive/hive.dart';

const _kExperimentationBoxKey = 'ExperimentationBox';
const _kExperimentationResultKey = 'ExperimentationResult';

abstract class ExperimentationModule {
  Future<ExperimentationEngineResult> fetch(RemoteConfig config);
}

class ExperimentsFetcherImpl implements ExperimentationModule {
  final ExperimentationEngine _engine = ExperimentationEngineImpl();

  @override
  Future<ExperimentationEngineResult> fetch(RemoteConfig config) async {
    final previousResult = await readPreviousResult();
    final newResult = _engine.getResult(config, previousResult);
    await writeResult(newResult);
    return newResult;
  }

  Future<void> writeResult(ExperimentationEngineResult result) async {
    final box = await Hive.openLazyBox(_kExperimentationBoxKey);
    await box.put(_kExperimentationResultKey, result.toJson());
  }

  Future<ExperimentationEngineResult?> readPreviousResult() async {
    final box = await Hive.openLazyBox(_kExperimentationBoxKey);
    final jsonMap =
        await box.get(_kExperimentationResultKey) as Map<String, dynamic>?;
    if (jsonMap == null) return null;
    return ExperimentationEngineResult.fromJson(jsonMap);
  }
}
