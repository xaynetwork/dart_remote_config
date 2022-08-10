import 'package:dart_remote_config/model/experimentation_engine_result.dart';
import 'package:dart_remote_config/model/feature.dart';
import 'package:dart_remote_config/model/known_experiment_variant.dart';
import 'package:dart_remote_config/model/variant.dart';

extension CollectionExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension ExperimentResultSetExtestion on Set<ExperimentResult> {
  bool get hasExclusive =>
      any((it) => it is ExperimentResultSubscribed && it.experiment.exclusive);
}

extension StringExtestion on String {
  String getSubstring(String matcher) {
    final startIndex = indexOf(matcher);
    final endIndex = indexOf(matcher, startIndex + matcher.length);
    return substring(startIndex + matcher.length, endIndex);
  }
}

extension ExperimentationEngineResultSuccessExtension
    on ExperimentationEngineResult {
  Set<ExperimentResult> get activeExperiments =>
      computedExperiments.where((e) => !e.isConcluded).toSet();

  Set<Feature> get enabledFeatures => computedExperiments
      .whereType<ExperimentResultSubscribed>()
      .map((it) => it.selectedVariant?.featureIds ?? [])
      .expand((it) => it)
      .map(
        (it) => featuresDefinedInConfig.firstWhere(
          (feature) => feature.id == it,
          orElse: () => Feature(id: it),
        ),
      )
      .toSet();

  Set<KnownVariantId> get subscribedVariantIds =>
      activeExperiments.map((it) => it.selectedVariantId).toSet();
}

extension ExperimentResultExtension on ExperimentResult {
  bool get isConcluded => experiment.isConcluded;

  Variant? get selectedVariant => mapOrNull(
        subscribed: (subscribed) => experiment.isConcluded
            ? experiment.variants.single
            : subscribed.initialSelectedVariant,
      );

  KnownVariantId get selectedVariantId => KnownVariantId(
        experiment.id,
        selectedVariant?.id,
        experiment.size,
      );
}
