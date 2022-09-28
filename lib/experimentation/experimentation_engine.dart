import 'package:dart_remote_config/dart_remote_config.dart';
import 'package:dart_remote_config/model/experiment.dart';
import 'package:dart_remote_config/model/experimentation_engine_result.dart';
import 'package:dart_remote_config/model/known_experiment_variant.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:dart_remote_config/model/variant.dart';
import 'package:dart_remote_config/utils/extensions.dart';
import 'package:dart_remote_config/utils/random_choice.dart';
import 'package:pub_semver/pub_semver.dart';

abstract class ExperimentationEngine {
  ExperimentationEngineResult computeResult(
    RemoteConfig config, [
    Set<KnownVariantId> knownVariantIds,
  ]);
}

class ExperimentationEngineImpl implements ExperimentationEngine {
  final Version _version;
  ExperimentationEngineImpl(this._version) : super();

  @override
  ExperimentationEngineResult computeResult(
    RemoteConfig config, [
    Set<KnownVariantId> subscribedVariantIds = const {},
  ]) {
    final experiments = config.experiments
        .where((it) => it.enabled && it.filter.isActive(_version))
        .toSet();

    final concludedResults = _getConcludedResults(experiments);

    final previousResults = _getPreviousResults(
      experiments,
      subscribedVariantIds,
    );

    final resultsToSkipComputing = <ExperimentResult>{
      ...concludedResults,
      ...previousResults,
    };

    final newResults = _maybeSubscribe(
      experiments,
      resultsToSkipComputing,
    );

    final results = {...resultsToSkipComputing, ...newResults};

    return ExperimentationEngineResult(results, config.features);
  }

  Set<ExperimentResult> _getConcludedResults(Set<Experiment> experiments) =>
      experiments
          .where((it) => it.isConcluded)
          .map(
            (it) => ExperimentResult.subscribed(
              experiment: it,
              initialSelectedVariant: it.variants.single,
            ),
          )
          .toSet();

  Set<ExperimentResult> _getPreviousResults(
    Set<Experiment> experiments,
    Set<KnownVariantId> subscribedVariantIds,
  ) {
    bool experimentIsComputed(Experiment experiment) => subscribedVariantIds
        .where((it) => it.isSubscribed || it.size == experiment.size)
        .map((it) => it.experimentId)
        .contains(experiment.id);

    bool variantIsSubscribed(Experiment experiment, Variant variant) =>
        subscribedVariantIds
            .where((it) => it.isSubscribed)
            .where((it) => it.experimentId == experiment.id)
            .map((variantId) => variantId.variantId)
            .contains(variant.id);

    ExperimentResult experimentToResult(Experiment experiment) {
      final selectedVariant = experiment.variants.firstWhereOrNull(
        (variant) => variantIsSubscribed(experiment, variant),
      );

      return selectedVariant != null
          ? ExperimentResult.subscribed(
              experiment: experiment,
              initialSelectedVariant: selectedVariant,
            )
          : ExperimentResult.notSubscribed(experiment: experiment);
    }

    return experiments
        .where((it) => !it.isConcluded)
        .where(experimentIsComputed)
        .map(experimentToResult)
        .toSet();
  }

  Set<ExperimentResult> _maybeSubscribe(
    Set<Experiment> experiments,
    Set<ExperimentResult> resultsToSkipComputing,
  ) {
    final experimentsToCompute = experiments
        .difference(resultsToSkipComputing.map((it) => it.experiment).toSet())
        .toSet();

    final hasExclusiveToSkipComputing = resultsToSkipComputing.hasExclusive;

    final shuffledExperiments = List<Experiment>.from(experimentsToCompute)
      ..shuffle();

    final results = <ExperimentResult>{};

    for (final experiment in shuffledExperiments.toSet()) {
      final hasExclusive = hasExclusiveToSkipComputing || results.hasExclusive;

      if (hasExclusive && experiment.exclusive) continue;

      if (isHit(experiment.size)) {
        results.add(_subscribeToSingleExperiment(experiment));
      } else {
        results.add(ExperimentResult.notSubscribed(experiment: experiment));
      }
    }

    return results;
  }

  ExperimentResult _subscribeToSingleExperiment(Experiment experiment) {
    final variants = experiment.variants;
    final ratios = variants.map((it) => it.ratio.toDouble());
    final selectedVariant = randomChoice(variants, ratios);

    return ExperimentResult.subscribed(
      experiment: experiment,
      initialSelectedVariant: selectedVariant,
    );
  }
}
