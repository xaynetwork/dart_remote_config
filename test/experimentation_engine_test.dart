import 'dart:math';

import 'package:dart_remote_config/experimentation/experimentation_engine.dart';
import 'package:dart_remote_config/model/experiment.dart';
import 'package:dart_remote_config/model/experimentation_engine_result.dart';
import 'package:dart_remote_config/model/feature_value.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:dart_remote_config/model/remote_config_response.dart';
import 'package:dart_remote_config/model/variant.dart';
import 'package:dart_remote_config/remote_config_fetcher.dart';
import 'package:dart_remote_config/utils/extensions.dart';
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
    final result = ExperimentationEngineImpl().computeResult(config);
    expect(result.computedExperiments.length, greaterThan(0));
  });

  group('concluded experiments with single variant and size = 1', () {
    test(
        'When a single variable concluded experiment with size=1, then subscribe',
        () async {
      const featureId = 'feature_1';
      const fakeUniVariantExperiment = Experiment(
        id: 'experiment1',
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

      final result = ExperimentationEngineImpl().computeResult(fakeConfig);
      expect(result.activeExperiments.length, 0);
      expect(result.computedExperiments.length, 1);
      expect(result.featuresDefinedInConfig.length, 0);
      expect(result.enabledFeatures.length, 1);
      expect(result.enabledFeatures.first.id, featureId);
      expect(
        result.enabledFeatures.first.value,
        const FeatureValue.nothing(),
      );
    });

    test(
        'When multiple inclusive single variable concluded experiments with size=1, then subscribe to them',
        () async {
      const featureId1 = 'feature_1';
      const featureId2 = 'feature_2';
      const fakeUniVariantExperiment1 = Experiment(
        id: 'experiment1',
        size: 1,
        exclusive: false,
        variants: [
          Variant(
            id: 'variant_1',
            featureIds: [featureId1],
          ),
        ],
      );
      const fakeUniVariantExperiment2 = Experiment(
        id: 'experiment2',
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

      final result = ExperimentationEngineImpl().computeResult(fakeConfig);
      expect(result.activeExperiments.length, 0);
      expect(result.computedExperiments.length, 2);
      expect(result.featuresDefinedInConfig.length, 0);
      expect(result.enabledFeatures.length, 2);
      expect(
        result.enabledFeatures.map((it) => it.id).toSet().difference(
          {featureId1, featureId2},
        ).isEmpty,
        true,
      );
      expect(
        result.enabledFeatures.map((it) => it.value).toSet().difference(
          {const FeatureValue.nothing()},
        ).isEmpty,
        true,
      );
    });

    test(
        'When multiple exclusive single variable concluded experiments with size=1, then treat them as inclusive and subscribe to all',
        () async {
      const featureId1 = 'feature_1';
      const featureId2 = 'feature_2';
      const fakeUniVariantExperiment1 = Experiment(
        id: 'experiment1',
        size: 1,
        variants: [
          Variant(
            id: 'variant_1',
            featureIds: [featureId1],
          ),
        ],
      );
      const fakeUniVariantExperiment2 = Experiment(
        id: 'experiment2',
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

      final result = ExperimentationEngineImpl().computeResult(fakeConfig);
      expect(result.activeExperiments.length, 0);
      expect(result.computedExperiments.length, 2);
      expect(result.featuresDefinedInConfig.length, 0);
      expect(result.enabledFeatures.length, 2);
    });

    test(
        'When single exclusive and multiple inclusive concluded experiments, then subscribe to all',
        () async {
      const featureId1 = 'feature_1';
      const featureId2 = 'feature_2';
      const featureId3 = 'feature_3';
      const fakeUniVariantExperiment1 = Experiment(
        id: 'experiment1',
        size: 1,
        variants: [
          Variant(
            id: 'variant_1',
            featureIds: [featureId1],
          ),
        ],
      );
      const fakeUniVariantExperiment2 = Experiment(
        id: 'experiment2',
        size: 1,
        exclusive: false,
        variants: [
          Variant(
            id: 'variant_2',
            featureIds: [featureId2],
          ),
        ],
      );

      const fakeUniVariantExperiment3 = Experiment(
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

      final result = ExperimentationEngineImpl().computeResult(
        fakeConfig,
      );
      expect(result.activeExperiments.length, 0);
      expect(result.computedExperiments.length, 3);
      expect(result.featuresDefinedInConfig.length, 0);
      expect(result.enabledFeatures.length, 3);
      expect(
        result.enabledFeatures.map((it) => it.id).toSet().difference(
          {featureId1, featureId2, featureId3},
        ).isEmpty,
        true,
      );
      expect(
        result.enabledFeatures.map((it) => it.value).toSet().difference(
          {const FeatureValue.nothing()},
        ).isEmpty,
        true,
      );
    });
  });

  group('rollout experiments with single variant and size < 1', () {
    test(
        'when a single rollout with size 0.5, then half the user base subscribe',
        () async {
      const size = 0.5;
      const userCount = 1000;
      const expectedSubscribersCount = userCount * size;
      final sigma = sqrt(pow(userCount, 2) / 12);

      const featureId = 'feature_1';
      const fakeUniVariantExperiment = Experiment(
        id: 'experiment1',
        size: size,
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

      expect(fakeUniVariantExperiment.type, ExperimentType.rollout);

      var countUsersSubscribed = 0;

      for (int i = 0; i < userCount; i++) {
        final result = ExperimentationEngineImpl().computeResult(fakeConfig);
        if (result.computedExperiments
            .whereType<ExperimentResultSubscribed>()
            .map((it) => it.experiment)
            .contains(fakeUniVariantExperiment)) {
          countUsersSubscribed++;
        }
      }

      expect(
        countUsersSubscribed,
        greaterThanOrEqualTo(expectedSubscribersCount - sigma),
      );

      expect(
        countUsersSubscribed,
        greaterThanOrEqualTo(expectedSubscribersCount - sigma),
      );
      expect(
        countUsersSubscribed,
        lessThanOrEqualTo(expectedSubscribersCount + sigma),
      );
    });

    test(
        'when multiple exclusive rollouts with size 0.5, then half the user base subscribe to either one of them',
        () async {
      const size1 = 0.2;
      const size2 = 0.7;
      const userCount = 1000;
      const expectedSubscribersCount1 = userCount * size1;
      const expectedSubscribersCount2 = userCount * size2;
      final sigma = sqrt(pow(userCount, 2) / 12);

      const experiment1 = Experiment(
        id: 'experiment1',
        size: size1,
        variants: [
          Variant(
            id: 'variant_1',
            featureIds: ['feature_1'],
          ),
        ],
      );
      const experiment2 = Experiment(
        id: 'experiment2',
        size: size2,
        variants: [
          Variant(
            id: 'variant_2',
            featureIds: ['feature_2'],
          ),
        ],
      );

      final RemoteConfig fakeConfig = RemoteConfig(
        appVersion: VersionConstraint.any,
        experiments: [experiment1, experiment2],
      );

      expect(experiment1.type, ExperimentType.rollout);
      expect(experiment2.type, ExperimentType.rollout);

      var subscribedUsersExperiment1 = 0;
      var subscribedUsersExperiment2 = 0;

      for (int i = 0; i < userCount; i++) {
        final result = ExperimentationEngineImpl().computeResult(fakeConfig);
        final experiments = result.computedExperiments
            .whereType<ExperimentResultSubscribed>()
            .map((it) => it.experiment);

        if (experiments.contains(experiment1)) {
          subscribedUsersExperiment1++;
        }
        if (experiments.contains(experiment2)) {
          subscribedUsersExperiment2++;
        }
      }

      expect(
        subscribedUsersExperiment1,
        greaterThanOrEqualTo(expectedSubscribersCount1 - sigma),
      );
      expect(
        subscribedUsersExperiment1,
        lessThanOrEqualTo(expectedSubscribersCount1 + sigma),
      );
      expect(
        subscribedUsersExperiment2,
        greaterThanOrEqualTo(expectedSubscribersCount2 - sigma),
      );
      expect(
        subscribedUsersExperiment2,
        lessThanOrEqualTo(expectedSubscribersCount2 + sigma),
      );
    });

    test(
        'when multiple inclusive rollouts with size 0.5, then half the user base subscribe to any one of them',
        () async {
      const size1 = 0.2;
      const size2 = 0.7;
      const userCount = 1000;
      const expectedSubscribersCount1 = userCount * size1;
      const expectedSubscribersCount2 = userCount * size2;
      final sigma = sqrt(pow(userCount, 2) / 12);

      const experiment1 = Experiment(
        id: 'experiment1',
        exclusive: false,
        size: size1,
        variants: [
          Variant(
            id: 'variant_1',
            featureIds: ['feature_1'],
          ),
        ],
      );
      const experiment2 = Experiment(
        id: 'experiment2',
        exclusive: false,
        size: size2,
        variants: [
          Variant(
            id: 'variant_2',
            featureIds: ['feature_2'],
          ),
        ],
      );

      final RemoteConfig fakeConfig = RemoteConfig(
        appVersion: VersionConstraint.any,
        experiments: [experiment1, experiment2],
      );

      expect(experiment1.type, ExperimentType.rollout);
      expect(experiment2.type, ExperimentType.rollout);

      var subscribedUsersExperiment1 = 0;
      var subscribedUsersExperiment2 = 0;

      for (int i = 0; i < userCount; i++) {
        final result = ExperimentationEngineImpl().computeResult(fakeConfig);
        final experiments = result.computedExperiments
            .whereType<ExperimentResultSubscribed>()
            .map((it) => it.experiment);
        if (experiments.contains(experiment1)) {
          subscribedUsersExperiment1++;
        }
        if (experiments.contains(experiment2)) {
          subscribedUsersExperiment2++;
        }
      }

      expect(
        subscribedUsersExperiment1,
        greaterThanOrEqualTo(expectedSubscribersCount1 - sigma),
      );
      expect(
        subscribedUsersExperiment1,
        lessThanOrEqualTo(expectedSubscribersCount1 + sigma),
      );
      expect(
        subscribedUsersExperiment2,
        greaterThanOrEqualTo(expectedSubscribersCount2 - sigma),
      );
      expect(
        subscribedUsersExperiment2,
        lessThanOrEqualTo(expectedSubscribersCount2 + sigma),
      );
    });
  });

  group('experiments with multiple variants and size < 1', () {
    test(
        'when a single experiment with size < 1, and more than one variant then a portion of the user base will subscribe to different variants',
        () async {
      const size = 0.3;
      const userCount = 1000;
      const expectedSubscribersCount = userCount * size;
      final sigma = sqrt(pow(userCount, 2) / 12);

      const variant1 = Variant(
        id: 'variant_1',
        ratio: 2,
        featureIds: ['feature_1'],
      );

      const variant2 = Variant(
        id: 'variant_2',
        ratio: 5,
        featureIds: ['feature_2'],
      );

      const fakeUniVariantExperiment = Experiment(
        id: 'experiment1',
        size: size,
        variants: [
          variant1,
          variant2,
        ],
      );

      final RemoteConfig fakeConfig = RemoteConfig(
        appVersion: VersionConstraint.any,
        experiments: [fakeUniVariantExperiment],
      );

      expect(fakeUniVariantExperiment.type, ExperimentType.aBExperiment);

      var countUsersComputed = 0;
      var countVariant1Subscribers = 0;
      var countVariant2Subscribers = 0;

      for (int i = 0; i < userCount; i++) {
        final result = ExperimentationEngineImpl().computeResult(fakeConfig);
        final experiments = result.computedExperiments
            .whereType<ExperimentResultSubscribed>()
            .map((it) => it.experiment);
        if (experiments.contains(fakeUniVariantExperiment)) {
          countUsersComputed++;
          final subscribedVariant =
              result.computedExperiments.first.selectedVariant;
          if (subscribedVariant == variant1) countVariant1Subscribers++;
          if (subscribedVariant == variant2) countVariant2Subscribers++;
        }
      }

      expect(
        countUsersComputed,
        greaterThanOrEqualTo(expectedSubscribersCount - sigma),
      );
      expect(
        countUsersComputed,
        lessThanOrEqualTo(expectedSubscribersCount + sigma),
      );

      final sigmaActualSubscribers =
          sqrt(pow(countVariant1Subscribers, 2) / 12);
      final error = 1 - (sigmaActualSubscribers / expectedSubscribersCount);

      expect(
        countVariant1Subscribers / countVariant2Subscribers,
        lessThanOrEqualTo(
          (variant1.ratio / variant2.ratio) + error,
        ),
      );

      expect(
        countVariant1Subscribers / countVariant2Subscribers,
        greaterThanOrEqualTo(
          (variant1.ratio / variant2.ratio) - error,
        ),
      );
    });
  });
}
