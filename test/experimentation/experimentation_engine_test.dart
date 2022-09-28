import 'dart:math';

import 'package:dart_remote_config/dart_remote_config.dart';
import 'package:dart_remote_config/experimentation/experimentation_engine.dart';
import 'package:dart_remote_config/experimentation/experimentation_module.dart';
import 'package:dart_remote_config/fetcher/remote_config_fetcher.dart';
import 'package:dart_remote_config/model/dart_remote_config_state.dart';
import 'package:dart_remote_config/model/experiment.dart';
import 'package:dart_remote_config/model/experimentation_engine_result.dart';
import 'package:dart_remote_config/model/feature.dart';
import 'package:dart_remote_config/model/feature_value.dart';
import 'package:dart_remote_config/model/known_experiment_variant.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:dart_remote_config/model/remote_config_response.dart';
import 'package:dart_remote_config/model/variant.dart';
import 'package:dart_remote_config/utils/extensions.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

import '../remote_config_test.dart';

void main() {
  const numTries = 1000;
  const error = numTries * 0.09;
  final version = Version(3, 47, 0);

  group('Fetching remote config and passing it to experimentation engine', () {
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
      final result = ExperimentationEngineImpl(version).computeResult(config);
      expect(result.computedExperiments.length, greaterThan(0));
    });

    test('Parsing the config and running a successful experiment', () async {
      const configString = """
  - appVersion: ">3.46.0 <4.0.0"
    features:
      - feature:
        id: feature
    experiments:
      - experiment:
        id: experiment
        size: 0.4
        filter:
          appVersion: ">3.46.0"
        variants:
         - id: a
           featureIds:
             - feature
  """;

      final parsedConfig =
          await StringRemoteConfigFetcher(configString).fetch();

      expect(parsedConfig, isA<RemoteConfigResponseSuccess>());

      final config = parsedConfig.mapOrNull(
        success: (success) => success.remoteConfigs.configs.first,
      );

      final result = ExperimentationEngineImpl(version).computeResult(config!);
      expect(result.computedExperiments.length, greaterThan(0));
    });

    test(
        'Experiment that is filtered but 100% rollout should not be subscribed',
        () async {
      const configString = """
  - appVersion: ">3.46.0 <4.0.0"
    features:
      - feature:
        id: feature
    experiments:
      - experiment:
        id: experiment
        filter:
          appVersion: ">3.47.0"
        size: 1.0
        variants:
         - id: a
           featureIds:
             - feature
  """;

      final parsedConfig =
          await StringRemoteConfigFetcher(configString).fetch();

      expect(parsedConfig, isA<RemoteConfigResponseSuccess>());

      final config = parsedConfig.mapOrNull(
        success: (success) => success.remoteConfigs.configs.first,
      );

      final result = ExperimentationEngineImpl(version).computeResult(config!);
      expect(result.subscribedVariantIds, isEmpty);
    });

    test('Stay subscribed when the size does not change in a new fetch.',
        () async {
      final repository = InMemoryRepository();
      await repository.saveSubscribedVariantsIds(
        {const KnownVariantId('experiment', 'a', 0.4)},
      );
      final state = await DartRemoteConfig(
        fetcher: StringRemoteConfigFetcher(
          """
  - appVersion: ">3.46.0 <4.0.0"
    features:
      - feature:
        id: feature
    experiments:
      - experiment:
        id: experiment
        size: 0.4
        variants:
         - id: a
           featureIds:
             - feature
  """,
        ),
        versionProvider: () => '3.50.0',
        experimentationModuleFactory: (v) {
          return ExperimentationModule(
              ExperimentationEngineImpl(v), repository);
        },
      ).create();

      expect(state, isA<DartRemoteConfigStateSuccess>());
      expect(
          (state as DartRemoteConfigStateSuccess).experiments.activeExperiments,
          {
            const ExperimentResult.subscribed(
              experiment: Experiment(
                id: 'experiment',
                size: 0.4,
              ),
              initialSelectedVariant: Variant(id: 'a'),
            )
          });
    });

    test('Stay subscribed when the size increases in a new fetch.', () async {
      final repository = InMemoryRepository();
      await repository.saveSubscribedVariantsIds(
        {const KnownVariantId('experiment', 'a', 0.4)},
      );
      final state = await DartRemoteConfig(
        fetcher: StringRemoteConfigFetcher(
          """
  - appVersion: ">3.46.0 <4.0.0"
    features:
      - feature:
        id: feature
    experiments:
      - experiment:
        id: experiment
        size: 0.5
        variants:
         - id: a
           featureIds:
             - feature
  """,
        ),
        versionProvider: () => '3.50.0',
        experimentationModuleFactory: (v) {
          return ExperimentationModule(
              ExperimentationEngineImpl(v), repository);
        },
      ).create();

      expect(state, isA<DartRemoteConfigStateSuccess>());
      expect(
          (state as DartRemoteConfigStateSuccess).experiments.activeExperiments,
          {
            const ExperimentResult.subscribed(
              experiment: Experiment(
                id: 'experiment',
                size: 0.5,
              ),
              initialSelectedVariant: Variant(id: 'a'),
            )
          });
    });

    test('Stay subscribed when the size decrease in a new fetch.', () async {
      final repository = InMemoryRepository();
      await repository.saveSubscribedVariantsIds(
        {const KnownVariantId('experiment', 'a', 0.4)},
      );
      final state = await DartRemoteConfig(
        fetcher: StringRemoteConfigFetcher(
          """
  - appVersion: ">3.46.0 <4.0.0"
    features:
      - feature:
        id: feature
    experiments:
      - experiment:
        id: experiment
        size: 0.3
        variants:
         - id: a
           featureIds:
             - feature
  """,
        ),
        versionProvider: () => '3.50.0',
        experimentationModuleFactory: (v) {
          return ExperimentationModule(
              ExperimentationEngineImpl(v), repository);
        },
      ).create();

      expect(state, isA<DartRemoteConfigStateSuccess>());
      expect(
          (state as DartRemoteConfigStateSuccess).experiments.activeExperiments,
          {
            const ExperimentResult.subscribed(
              experiment: Experiment(
                id: 'experiment',
                size: 0.3,
              ),
              initialSelectedVariant: Variant(id: 'a'),
            )
          });
    });

    test('Stay unsubscribed when you have seen the same rollout before.',
        () async {
      final repository = InMemoryRepository();
      await repository.saveSubscribedVariantsIds(
        {const KnownVariantId('experiment', null, 0.4)},
      );
      final state = await DartRemoteConfig(
        fetcher: StringRemoteConfigFetcher(
          """
  - appVersion: ">3.46.0 <4.0.0"
    features:
      - feature:
        id: feature
    experiments:
      - experiment:
        id: experiment
        size: 0.4
        variants:
         - id: a
           featureIds:
             - feature
  """,
        ),
        versionProvider: () => '3.50.0',
        experimentationModuleFactory: (v) {
          return ExperimentationModule(
              ExperimentationEngineImpl(v), repository);
        },
      ).create();

      expect(state, isA<DartRemoteConfigStateSuccess>());
      expect(
        (state as DartRemoteConfigStateSuccess).experiments.activeExperiments,
        {
          const ExperimentResult.notSubscribed(
            experiment: Experiment(id: 'experiment', size: 0.4),
          )
        },
      );
      expect(
        state.experiments.enabledFeatures,
        isEmpty,
      );
    });

    test('Switch to be subscribed when the rollout almost reaches 100%.',
        () async {
      final repository = InMemoryRepository();
      await repository.saveSubscribedVariantsIds(
        {const KnownVariantId('experiment', null, 0.4)},
      );
      final state = await DartRemoteConfig(
        fetcher: StringRemoteConfigFetcher(
          """
  - appVersion: ">3.46.0 <4.0.0"
    features:
      - feature:
        id: feature
    experiments:
      - experiment:
        id: experiment
        size: 0.99999
        variants:
         - id: a
           featureIds:
             - feature
  """,
        ),
        versionProvider: () => '3.50.0',
        experimentationModuleFactory: (v) {
          return ExperimentationModule(
              ExperimentationEngineImpl(v), repository);
        },
      ).create();

      expect(state, isA<DartRemoteConfigStateSuccess>());
      expect(
        (state as DartRemoteConfigStateSuccess).experiments.activeExperiments,
        {
          const ExperimentResult.subscribed(
            experiment: Experiment(
              id: 'experiment',
              size: 0.4,
            ),
            initialSelectedVariant: Variant(id: 'a'),
          )
        },
      );
      expect(
        state.experiments.enabledFeatures,
        {const Feature(id: 'feature')},
      );
    });

    test(
        'Users that were not subscribed but saw the experiment before will subscribe when changing to 100% rollout',
        () async {
      final repository = InMemoryRepository();
      await repository.saveSubscribedVariantsIds(
        {const KnownVariantId('experiment', null, 0.4)},
      );
      final state = await DartRemoteConfig(
        fetcher: StringRemoteConfigFetcher(
          """
  - appVersion: ">3.46.0 <4.0.0"
    features:
      - feature:
        id: feature
    experiments:
      - experiment:
        id: experiment
        size: 1.0
        variants:
         - id: a
           featureIds:
             - feature
  """,
        ),
        versionProvider: () => '3.50.0',
        experimentationModuleFactory: (version) {
          return ExperimentationModule(
              ExperimentationEngineImpl(version), repository);
        },
      ).create();

      expect(state, isA<DartRemoteConfigStateSuccess>());
      expect(
        (state as DartRemoteConfigStateSuccess).experiments.enabledFeatures,
        {const Feature(id: 'feature')},
      );
    });

    test(
        'An experiment that is concluded but has two variants is selects one of those variants',
        () async {
      final repository = InMemoryRepository();
      final state = await DartRemoteConfig(
        fetcher: StringRemoteConfigFetcher(
          """
  - appVersion: ">3.46.0 <4.0.0"
    features:
      - feature:
        id: feature
    experiments:
      - experiment:
        id: experiment
        size: 1.0
        variants:
         - id: a
         - id: b
  """,
        ),
        versionProvider: () => '3.50.0',
        experimentationModuleFactory: (v) {
          return ExperimentationModule(
              ExperimentationEngineImpl(v), repository);
        },
      ).create();

      expect(state, isA<DartRemoteConfigStateSuccess>());
      expect(
        (state as DartRemoteConfigStateSuccess).experiments.enabledFeatures,
        isEmpty,
      );
      expect(
        state.experiments.subscribedVariantIds,
        anyOf(
          {const KnownVariantId('experiment', 'a', 1.0)},
          {const KnownVariantId('experiment', 'b', 1.0)},
        ),
      );
    });

    ///
  });

  group('concluded experiments with single variant and size = 1', () {
    test(
        'When a single variable concluded experiment with size=1, then subscribe',
        () async {
      const featureId = 'feature_1';
      const fakeUniVariantExperiment = Experiment(
        id: 'alreadySubscribedExperiment',
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

      final result =
          ExperimentationEngineImpl(version).computeResult(fakeConfig);
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
        id: 'alreadySubscribedExperiment',
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
        id: 'newExperiment',
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

      final result =
          ExperimentationEngineImpl(version).computeResult(fakeConfig);
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
        id: 'alreadySubscribedExperiment',
        size: 1,
        variants: [
          Variant(
            id: 'variant_1',
            featureIds: [featureId1],
          ),
        ],
      );
      const fakeUniVariantExperiment2 = Experiment(
        id: 'newExperiment',
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

      final result =
          ExperimentationEngineImpl(version).computeResult(fakeConfig);
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
        id: 'alreadySubscribedExperiment',
        size: 1,
        variants: [
          Variant(
            id: 'variant_1',
            featureIds: [featureId1],
          ),
        ],
      );
      const fakeUniVariantExperiment2 = Experiment(
        id: 'newExperiment',
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

      final result = ExperimentationEngineImpl(version).computeResult(
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
      const expectedSubscribersCount = numTries * size;

      const featureId = 'feature_1';
      const fakeUniVariantExperiment = Experiment(
        id: 'alreadySubscribedExperiment',
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

      for (int i = 0; i < numTries; i++) {
        final result =
            ExperimentationEngineImpl(version).computeResult(fakeConfig);
        if (result.computedExperiments
            .whereType<ExperimentResultSubscribed>()
            .map((it) => it.experiment)
            .contains(fakeUniVariantExperiment)) {
          countUsersSubscribed++;
        }
      }

      expect(
        countUsersSubscribed,
        closeTo(expectedSubscribersCount, error),
      );
    });

    test(
        'when multiple exclusive rollouts with size 0.5, then half the user base subscribe to either one of them',
        () async {
      const size1 = 0.2;
      const size2 = 0.7;
      const expectedSubscribersCount1 = numTries * size1;
      const expectedSubscribersCount2 = numTries * size2;

      const experiment1 = Experiment(
        id: 'alreadySubscribedExperiment',
        size: size1,
        variants: [
          Variant(
            id: 'variant_1',
            featureIds: ['feature_1'],
          ),
        ],
      );
      const experiment2 = Experiment(
        id: 'newExperiment',
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

      for (int i = 0; i < numTries; i++) {
        final result =
            ExperimentationEngineImpl(version).computeResult(fakeConfig);
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
        closeTo(expectedSubscribersCount1, error),
      );
      expect(
        subscribedUsersExperiment2,
        closeTo(expectedSubscribersCount2, error),
      );
    });

    test(
        'when multiple inclusive rollouts with size 0.5, then half the user base subscribe to any one of them',
        () async {
      const size1 = 0.2;
      const size2 = 0.7;
      const expectedSubscribersCount1 = numTries * size1;
      const expectedSubscribersCount2 = numTries * size2;

      const experiment1 = Experiment(
        id: 'alreadySubscribedExperiment',
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
        id: 'newExperiment',
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

      for (int i = 0; i < numTries; i++) {
        final result =
            ExperimentationEngineImpl(version).computeResult(fakeConfig);
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
        closeTo(expectedSubscribersCount1, error),
      );

      expect(
        subscribedUsersExperiment2,
        closeTo(expectedSubscribersCount2, error),
      );
    });
  });

  group('experiments with multiple variants and size < 1', () {
    test(
        'when a single experiment with size < 1, and more than one variant then a portion of the user base will subscribe to different variants',
        () async {
      const size = 0.3;
      const expectedSubscribersCount = numTries * size;

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

      const fakeMultiVariantExperiment = Experiment(
        id: 'alreadySubscribedExperiment',
        size: size,
        variants: [
          variant1,
          variant2,
        ],
      );

      final RemoteConfig fakeConfig = RemoteConfig(
        appVersion: VersionConstraint.any,
        experiments: [fakeMultiVariantExperiment],
      );

      expect(fakeMultiVariantExperiment.type, ExperimentType.aBExperiment);

      var countUsersComputed = 0;
      var countVariant1Subscribers = 0;
      var countVariant2Subscribers = 0;

      for (int i = 0; i < numTries; i++) {
        final result =
            ExperimentationEngineImpl(version).computeResult(fakeConfig);
        final experiments = result.computedExperiments
            .whereType<ExperimentResultSubscribed>()
            .map((it) => it.experiment);
        if (experiments.contains(fakeMultiVariantExperiment)) {
          countUsersComputed++;
          final subscribedVariant =
              result.computedExperiments.first.selectedVariant;
          if (subscribedVariant == variant1) countVariant1Subscribers++;
          if (subscribedVariant == variant2) countVariant2Subscribers++;
        }
      }

      expect(
        countUsersComputed,
        closeTo(expectedSubscribersCount, error),
      );

      final sigmaActualSubscribers =
          sqrt(pow(countVariant1Subscribers / 2, 2) / 12);
      final variantError =
          1 - (sigmaActualSubscribers / expectedSubscribersCount);

      expect(
        countVariant1Subscribers / countVariant2Subscribers,
        closeTo(
          variant1.ratio / variant2.ratio,
          variantError,
        ),
      );
    });
  });

  group('passing previous subscribedVariantIds to experimentation engine', () {
    test(
        'When passing previous subscribedVariantIds, user will subscribe to it again',
        () async {
      const size = 0.3;
      const expectedSubscribersCount = numTries * size;

      Variant _getVariant(int index) => Variant(
            id: 'variant_$index',
            ratio: index + 2,
            featureIds: ['feature_$index'],
          );

      /// Already subscribed
      final alreadySubscribedExperiment = Experiment(
        id: 'alreadySubscribedExperiment',
        size: size,
        variants: [
          _getVariant(1),
          _getVariant(2),
        ],
      );

      /// Won't subscribe since it's exclusive
      final exclusiveExperiment = Experiment(
        id: 'newExperiment',
        size: size,
        variants: [
          _getVariant(3),
          _getVariant(4),
        ],
      );

      /// May subscribe since it's inclusive
      final inclusiveExperiment = Experiment(
        id: 'inclusiveExperiment',
        exclusive: false,
        size: size,
        variants: [
          _getVariant(5),
          _getVariant(6),
        ],
      );

      /// Will always subscribe since it's concluded
      const concludedExperiment = Experiment(
        id: 'concludedExperiment',
        exclusive: false,
        size: 1,
        variants: [
          Variant(
            id: 'variant_concluded',
            featureIds: ['feature_concluded'],
          )
        ],
      );

      final RemoteConfig fakeConfig = RemoteConfig(
        appVersion: VersionConstraint.any,
        experiments: [
          alreadySubscribedExperiment,
          exclusiveExperiment,
          inclusiveExperiment,
          concludedExperiment,
        ],
      );

      final subscribedVariantId = alreadySubscribedExperiment.variants.first.id;
      final subscribedVariantIds = <KnownVariantId>{
        KnownVariantId(
          alreadySubscribedExperiment.id,
          subscribedVariantId,
          alreadySubscribedExperiment.size,
        ),
      };

      expect(alreadySubscribedExperiment.type, ExperimentType.aBExperiment);
      expect(exclusiveExperiment.type, ExperimentType.aBExperiment);
      expect(inclusiveExperiment.type, ExperimentType.aBExperiment);
      expect(concludedExperiment.type, ExperimentType.concluded);

      var countAlreadySubscribedExperimentComputed = 0;
      var countInclusiveExperimentComputed = 0;
      var countExclusiveExperimentComputed = 0;
      var countConcludedExperimentComputed = 0;
      var countAlreadySubscribedExperimentVariant1Subscribers = 0;
      var countInclusiveVariant1Subscribers = 0;
      var countInclusiveVariant2Subscribers = 0;

      for (int i = 0; i < numTries; i++) {
        final result = ExperimentationEngineImpl(version).computeResult(
          fakeConfig,
          subscribedVariantIds,
        );
        final experiments = result.computedExperiments
            .whereType<ExperimentResultSubscribed>()
            .map((it) => it.experiment);
        if (experiments.contains(alreadySubscribedExperiment)) {
          countAlreadySubscribedExperimentComputed++;
          final actualSubscribedVariant = result.computedExperiments
              .firstWhere(
                (it) => it.experiment == alreadySubscribedExperiment,
              )
              .selectedVariant!
              .id;
          if (actualSubscribedVariant == subscribedVariantId) {
            countAlreadySubscribedExperimentVariant1Subscribers++;
          }
        }

        if (experiments.contains(exclusiveExperiment)) {
          countExclusiveExperimentComputed++;
        }

        if (experiments.contains(inclusiveExperiment)) {
          countInclusiveExperimentComputed++;
          final subscribedVariant = result.computedExperiments
              .firstWhere(
                (it) => it.experiment == inclusiveExperiment,
              )
              .selectedVariant;
          if (subscribedVariant == inclusiveExperiment.variants.first) {
            countInclusiveVariant1Subscribers++;
          } else {
            countInclusiveVariant2Subscribers++;
          }
        }

        if (experiments.contains(concludedExperiment)) {
          countConcludedExperimentComputed++;
        }
      }

      /// User remains subscribed to their variant
      expect(
        countAlreadySubscribedExperimentComputed,
        numTries,
      );

      expect(
        countAlreadySubscribedExperimentVariant1Subscribers,
        numTries,
      );

      /// User won't subscribe to another exclusive experiment
      expect(
        countExclusiveExperimentComputed,
        0,
      );

      /// User will subscribe to concluded experiments
      expect(
        countConcludedExperimentComputed,
        numTries,
      );

      /// User may subscribe to the inclusive experiment
      expect(
        countInclusiveExperimentComputed,
        closeTo(expectedSubscribersCount, error),
      );

      final sigmaActualSubscribers =
          sqrt(pow(countInclusiveVariant1Subscribers, 2) / 12);
      final variantError =
          1 - (sigmaActualSubscribers / expectedSubscribersCount);

      expect(
        countInclusiveVariant1Subscribers / countInclusiveVariant2Subscribers,
        closeTo(
          inclusiveExperiment.variants.first.ratio /
              inclusiveExperiment.variants.last.ratio,
          variantError,
        ),
      );
    });

    test(
        'When passing previous subscribedVariantIds that do not exist in new remote config, user will unsubscribe from it',
        () async {
      const size = 0.3;
      const expectedSubscribersCount = numTries * size;

      Variant _getVariant(int index) => Variant(
            id: 'variant_$index',
            ratio: index + 2,
            featureIds: ['feature_$index'],
          );

      /// Already subscribed
      final alreadySubscribedExperiment = Experiment(
        id: 'alreadySubscribedExperiment',
        size: size,
        variants: [
          _getVariant(1),
          _getVariant(2),
        ],
      );

      /// Won't subscribe since it's exclusive
      final newExperiment = Experiment(
        id: 'newExperiment',
        size: size,
        variants: [
          _getVariant(3),
          _getVariant(4),
        ],
      );

      final RemoteConfig fakeConfig = RemoteConfig(
        appVersion: VersionConstraint.any,
        experiments: [
          newExperiment,
        ],
      );

      final subscribedVariantId = alreadySubscribedExperiment.variants.first.id;
      final subscribedVariantIds = <KnownVariantId>{
        KnownVariantId(
          alreadySubscribedExperiment.id,
          subscribedVariantId,
          alreadySubscribedExperiment.size,
        ),
      };

      expect(alreadySubscribedExperiment.type, ExperimentType.aBExperiment);
      expect(newExperiment.type, ExperimentType.aBExperiment);

      var countAlreadySubscribedExperimentComputed = 0;
      var countInclusiveExperimentComputed = 0;

      for (int i = 0; i < numTries; i++) {
        final result = ExperimentationEngineImpl(version).computeResult(
          fakeConfig,
          subscribedVariantIds,
        );

        final experiments = result.computedExperiments
            .whereType<ExperimentResultSubscribed>()
            .map((it) => it.experiment);

        if (experiments.contains(alreadySubscribedExperiment)) {
          countAlreadySubscribedExperimentComputed++;
        }

        if (experiments.contains(newExperiment)) {
          countInclusiveExperimentComputed++;
        }
      }

      /// User unsubscribed to their variant when experiment not found
      expect(
        countAlreadySubscribedExperimentComputed,
        0,
      );

      /// User may subscribe to the inclusive experiment
      expect(
        countInclusiveExperimentComputed,
        closeTo(expectedSubscribersCount, error),
      );
    });
  });
}
