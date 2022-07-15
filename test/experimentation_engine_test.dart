import 'package:dart_remote_config/experimentation_engine/experimentation_engine.dart';
import 'package:dart_remote_config/model/experiment.dart';
import 'package:dart_remote_config/model/experimentation_engine_result.dart';
import 'package:dart_remote_config/model/feature_value.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:dart_remote_config/model/remote_config_response.dart';
import 'package:dart_remote_config/model/variant.dart';
import 'package:dart_remote_config/remote_config_fetcher.dart';
import 'package:pub_semver/pub_semver.dart';
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

  test('Fetching a config and running a successful experiment', () async {
    final config = await getRemoteConfig();
    final result = ExperimentationEngineImpl().getResult(config);
    expect(result, isA<ExperimentationEngineResultSuccess>());
  });

  test('A single variable concluded experiment', () async {
    const featureId = 'feature_1';
    final fakeUniVariantExperiment = Experiment(
      id: 'experiment_1',
      size: 1,
      variants: [
        Variant(
          id: 'variant_1',
          featureIds: [featureId],
        ),
      ],
    );

    final RemoteConfig fakeConfig = RemoteConfig(
      appVersion: VersionConstraint.any,
      experiments: [fakeUniVariantExperiment],
    );

    final result = ExperimentationEngineImpl().getResult(fakeConfig);
    expect(result, isA<ExperimentationEngineResultSuccess>());
    final successfulResult = result as ExperimentationEngineResultSuccess;
    expect(successfulResult.activeExperiments.length, 0);
    expect(successfulResult.subscribedExperiments.length, 1);
    expect(successfulResult.featuresDefinedInConfig.length, 0);
    expect(successfulResult.enabledFeatures.length, 1);
    expect(successfulResult.enabledFeatures.first.id, featureId);
    expect(
      successfulResult.enabledFeatures.first.value,
      const FeatureValue.nothing(),
    );
  });

  test('Multi single variable inclusive concluded experiments', () async {
    const featureId1 = 'feature_1';
    const featureId2 = 'feature_2';
    final fakeUniVariantExperiment1 = Experiment(
      id: 'experiment_1',
      size: 1,
      exclusive: false,
      variants: [
        Variant(
          id: 'variant_1',
          featureIds: [featureId1],
        ),
      ],
    );
    final fakeUniVariantExperiment2 = Experiment(
      id: 'experiment_2',
      size: 1,
      exclusive: false,
      variants: [
        Variant(
          id: 'variant_2',
          featureIds: [featureId2],
        ),
      ],
    );

    final RemoteConfig fakeConfig = RemoteConfig(
      appVersion: VersionConstraint.any,
      experiments: [fakeUniVariantExperiment1, fakeUniVariantExperiment2],
    );

    final result = ExperimentationEngineImpl().getResult(fakeConfig);
    expect(result, isA<ExperimentationEngineResultSuccess>());
    final successfulResult = result as ExperimentationEngineResultSuccess;
    expect(successfulResult.activeExperiments.length, 0);
    expect(successfulResult.subscribedExperiments.length, 2);
    expect(successfulResult.featuresDefinedInConfig.length, 0);
    expect(successfulResult.enabledFeatures.length, 2);
    expect(
      successfulResult.enabledFeatures.map((it) => it.id),
      [featureId1, featureId2],
    );
    expect(
      successfulResult.enabledFeatures.map((it) => it.value),
      const [FeatureValue.nothing(), FeatureValue.nothing()],
    );
  });

  test('Multi single variable exclusive concluded experiments', () async {
    const featureId1 = 'feature_1';
    const featureId2 = 'feature_2';
    final fakeUniVariantExperiment1 = Experiment(
      id: 'experiment_1',
      size: 1,
      variants: [
        Variant(
          id: 'variant_1',
          featureIds: [featureId1],
        ),
      ],
    );
    final fakeUniVariantExperiment2 = Experiment(
      id: 'experiment_2',
      size: 1,
      variants: [
        Variant(
          id: 'variant_2',
          featureIds: [featureId2],
        ),
      ],
    );

    final RemoteConfig fakeConfig = RemoteConfig(
      appVersion: VersionConstraint.any,
      experiments: [fakeUniVariantExperiment1, fakeUniVariantExperiment2],
    );

    final result = ExperimentationEngineImpl().getResult(fakeConfig);
    expect(result, isA<ExperimentationEngineResultSuccess>());
    final successfulResult = result as ExperimentationEngineResultSuccess;
    expect(successfulResult.activeExperiments.length, 0);
    expect(successfulResult.subscribedExperiments.length, 1);
    expect(successfulResult.featuresDefinedInConfig.length, 0);
    expect(successfulResult.enabledFeatures.length, 1);
    expect(
      successfulResult.enabledFeatures.map((it) => it.id),
      [featureId1],
    );
    expect(
      successfulResult.enabledFeatures.map((it) => it.value),
      const [FeatureValue.nothing()],
    );
  });
}
