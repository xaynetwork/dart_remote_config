import 'dart:convert';

import 'package:dart_remote_config/experimentation/experimentation_engine.dart';
import 'package:dart_remote_config/model/experimentation_engine_result.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<bool> writeResult(ExperimentationEngineResult result) async {
    final jsonString = jsonEncode(result.toJson());
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kExperimentationResultKey, jsonString);
  }

  Future<ExperimentationEngineResult?> readPreviousResult() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_kExperimentationResultKey);
    if (jsonString == null) return null;
    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    return ExperimentationEngineResult.fromJson(jsonMap);
  }
}
