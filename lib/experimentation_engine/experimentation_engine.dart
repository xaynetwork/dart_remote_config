import 'package:dart_remote_config/model/experiment.dart';
import 'package:dart_remote_config/model/experimentation_engine_result.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:dart_remote_config/utils/extensions.dart';
import 'package:dart_remote_config/utils/random_choice.dart';

abstract class ExperimentationEngine {
  ExperimentationEngineResult getResult(
    RemoteConfig config, [
    ExperimentationEngineResult? previousResult,
  ]);
}

class ExperimentationEngineImpl implements ExperimentationEngine {
  @override
  ExperimentationEngineResult getResult(
    RemoteConfig config, [
    ExperimentationEngineResult? previousResult,
  ]) {
    final newExperiments = config.experiments.where((it) => it.enabled).toSet();

    final results = <ExperimentResult>{};

    if (previousResult != null &&
        previousResult is ExperimentationEngineResultSuccess) {
      final previousExperiments = previousResult.activeExperiments;
      final experimentsToSkip =
          _getResultsToSkip(previousExperiments, newExperiments);
      final resultsToSkip = previousExperiments.where(
        (it) => experimentsToSkip.contains(it),
      );
      newExperiments.removeAll(experimentsToSkip);
      results.addAll(resultsToSkip);
    }

    results.addAll(_maybeSubscribe(newExperiments, results.hasExclusive));

    return ExperimentationEngineResult.success(results, config.features);
  }

  Set<ExperimentResult> _maybeSubscribe(
    Iterable<Experiment> experiments,
    bool hadExclusive,
  ) {
    final results = <ExperimentResult>{};

    for (final experiment in experiments) {
      final hasExclusive = hadExclusive || results.hasExclusive;

      if (hasExclusive && experiment.exclusive) continue;

      if (isHit(experiment.size)) {
        results.add(_subscribeToSingleExperiment(experiment));
      }
    }

    return results;
  }

  ExperimentResult _subscribeToSingleExperiment(Experiment experiment) {
    final variants = experiment.variants;
    final ratios = variants.map((it) => it.ratio.toDouble());
    final selectedVariant = randomChoice(variants, ratios);

    return ExperimentResult(
      experiment: experiment,
      initialSelectedVariant: selectedVariant,
    );
  }

  Set<ExperimentResult> _getResultsToSkip(
    Set<ExperimentResult> previousResults,
    Set<Experiment> nextExperiments,
  ) {
    final Set<ExperimentResult> resultsToSkip = <ExperimentResult>{};
    for (final result in previousResults) {
      final prevExperiment = result.experiment;
      if (nextExperiments.contains(prevExperiment)) {
        final nextExperiment =
            nextExperiments.firstWhere((it) => it == prevExperiment);
        final variantExists = nextExperiment.variants.contains(result.variant);
        if (variantExists) {
          resultsToSkip.add(result);
        }
      }
    }
    return resultsToSkip;
  }
}
