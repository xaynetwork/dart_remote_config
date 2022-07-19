import 'package:dart_remote_config/model/experimentation_engine_result.dart';

extension CollectionExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension ExperimentResultSetExtestion on Set<ExperimentResult> {
  bool get hasExclusive => any((it) => it.experiment.exclusive);
}

extension StringExtestion on String {
  String getSubstring(String matcher) {
    final startIndex = indexOf(matcher);
    final endIndex = indexOf(matcher, startIndex + matcher.length);
    return substring(startIndex + matcher.length, endIndex);
  }
}
