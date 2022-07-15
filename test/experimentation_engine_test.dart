import 'package:dart_remote_config/experimentation_engine/experimentation_engine.dart';
import 'package:dart_remote_config/model/experimentation_engine_result.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:dart_remote_config/model/remote_config_response.dart';
import 'package:dart_remote_config/remote_config_fetcher.dart';
import 'package:test/test.dart';

void main() {
  Future<RemoteConfig> getRemoteConfig() async {
    final config =
        await FileRemoteConfigFetcher('test/valid_rconfig.yaml').fetch();
    expect(config, isA<RemoteConfigResponseSuccess>());
    final fetchedConfig =
        (config as RemoteConfigResponseSuccess).remoteConfigs.configs.first;
    expect(fetchedConfig, isNotNull);
    return fetchedConfig;
  }

  test('Getting a successful experiment', () async {
    final config = await getRemoteConfig();
    final result = ExperimentationEngine().getResult(config);
    expect(result, isA<ExperimentationEngineResultSuccess>());
  });
}
