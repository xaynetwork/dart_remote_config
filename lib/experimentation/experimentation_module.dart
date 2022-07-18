import 'package:dart_remote_config/experimentation/experimentation_engine.dart';
import 'package:dart_remote_config/model/experimentation_engine_result.dart';
import 'package:dart_remote_config/model/remote_config.dart';

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

  Future<bool> writeResult(ExperimentationEngineResult result) async {
    //TODO: write to local database
    return true;
  }

  Future<ExperimentationEngineResult?> readPreviousResult() async {
    //TODO: read previous result from local database
    return null;
  }
}
