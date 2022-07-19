import 'package:dart_remote_config/model/experiment.dart';
import 'package:dart_remote_config/model/experimentation_engine_result.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:dart_remote_config/utils/extensions.dart';
import 'package:dart_remote_config/utils/random_choice.dart';

abstract class ExperimentationEngine {
  ExperimentationEngineResult computeResult(
    RemoteConfig config, [
    ExperimentationEngineResult? previousResult,
  ]);
}

class ExperimentationEngineImpl implements ExperimentationEngine {
  @override
  ExperimentationEngineResult computeResult(
    RemoteConfig config, [
    ExperimentationEngineResult? previousResult,
  ]) {
    late Set<ExperimentResult> previousResults;
    late Set<ExperimentResult> newResults;

    final newExperiments = config.experiments.where((it) => it.enabled);

    final notConcludedExperiments =
        newExperiments.where((it) => !it.isConcluded).toSet();

    final concludedResults = newExperiments
        .where((it) => it.isConcluded)
        .map(
          (it) => ExperimentResult.subscribed(
            experiment: it,
            initialSelectedVariant: it.variants.single,
          ),
        )
        .toSet();

    if (previousResult != null &&
        previousResult is ExperimentationEngineResultSuccess) {
      final previousExperiments = previousResult.activeExperiments;
      final experimentsToSkip =
          _getResultsToSkip(previousExperiments, notConcludedExperiments);
      notConcludedExperiments
          .removeAll(experimentsToSkip.map((it) => it.experiment));
      previousResults = experimentsToSkip;
    }

    newResults = _maybeSubscribe(
      notConcludedExperiments,
      previousResults.hasExclusive,
    );

    final results = <ExperimentResult>{
      ...concludedResults,
      ...previousResults,
      ...newResults
    };

    return ExperimentationEngineResult.success(results, config.features);
  }

  Set<ExperimentResult> _maybeSubscribe(
    Set<Experiment> experiments,
    bool hadExclusive,
  ) {
    final results = <ExperimentResult>{};

    final shuffledExperiments = List<Experiment>.from(experiments)..shuffle();

    for (final experiment in shuffledExperiments.toSet()) {
      final hasExclusive = hadExclusive || results.hasExclusive;

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

  Set<ExperimentResult> _getResultsToSkip(
    Set<ExperimentResult> previousResults,
    Set<Experiment> nextExperiments,
  ) {
    final notSubscribedToSkip = previousResults
        .whereType<ExperimentResultNotSubscribed>()
        .toSet()
        .intersection(nextExperiments);

    final subscribedToSkip = previousResults
        .whereType<ExperimentResultSubscribed>()
        .toSet()
        .intersection(nextExperiments);

    subscribedToSkip.retainWhere(
      (it) =>
          nextExperiments.expand((it) => it.variantIds).contains(it.variantId),
    );

    return {
      ...notSubscribedToSkip,
      ...subscribedToSkip,
    };
  }
}
