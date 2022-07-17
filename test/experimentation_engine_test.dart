import 'package:dart_remote_config/experimentation/experimentation_engine.dart';
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

  group('concluded experiments with single variant and size = 1', () {
    test(
        'When a single variable concluded experiment with size=1, then subscribe',
        () async {
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

      expect(fakeUniVariantExperiment.type, ExperimentType.concluded);

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

    test(
        'When multiple inclusive single variable concluded experiments with size=1, then subscribe to them',
        () async {
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

      expect(fakeUniVariantExperiment1.type, ExperimentType.concluded);
      expect(fakeUniVariantExperiment2.type, ExperimentType.concluded);

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

    test(
        'When multiple exclusive single variable concluded experiments with size=1, then subscribe to the first',
        () async {
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

      expect(fakeUniVariantExperiment1.type, ExperimentType.concluded);
      expect(fakeUniVariantExperiment2.type, ExperimentType.concluded);

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

    test(
        'When single exclusive and multiple inclusive concluded experiments, then subscribe to all',
        () async {
      const featureId1 = 'feature_1';
      const featureId2 = 'feature_2';
      const featureId3 = 'feature_3';
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
        exclusive: false,
        variants: [
          Variant(
            id: 'variant_2',
            featureIds: [featureId2],
          ),
        ],
      );

      final fakeUniVariantExperiment3 = Experiment(
        id: 'experiment_3',
        size: 1,
        exclusive: false,
        variants: [
          Variant(
            id: 'variant_3',
            featureIds: [featureId3],
          ),
        ],
      );

      final RemoteConfig fakeConfig = RemoteConfig(
        appVersion: VersionConstraint.any,
        experiments: [
          fakeUniVariantExperiment1,
          fakeUniVariantExperiment2,
          fakeUniVariantExperiment3,
        ],
      );

      expect(fakeUniVariantExperiment1.type, ExperimentType.concluded);
      expect(fakeUniVariantExperiment2.type, ExperimentType.concluded);
      expect(fakeUniVariantExperiment3.type, ExperimentType.concluded);

      final result = ExperimentationEngineImpl().getResult(fakeConfig);
      expect(result, isA<ExperimentationEngineResultSuccess>());
      final successfulResult = result as ExperimentationEngineResultSuccess;
      expect(successfulResult.activeExperiments.length, 0);
      expect(successfulResult.subscribedExperiments.length, 3);
      expect(successfulResult.featuresDefinedInConfig.length, 0);
      expect(successfulResult.enabledFeatures.length, 3);
      expect(
        successfulResult.enabledFeatures.map((it) => it.id),
        [featureId1, featureId2, featureId3],
      );
      expect(
        successfulResult.enabledFeatures.map((it) => it.value),
        const [
          FeatureValue.nothing(),
          FeatureValue.nothing(),
          FeatureValue.nothing(),
        ],
      );
    });
  });
}
