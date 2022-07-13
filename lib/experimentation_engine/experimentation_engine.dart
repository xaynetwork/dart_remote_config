import 'package:dart_remote_config/model/experimentation_engine_result.dart';

abstract class ExperimentationEngine {
  Future<ExperimentationEngineResult> getInstance();
}
