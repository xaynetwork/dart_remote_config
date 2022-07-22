import 'dart:math' show Random;

T randomChoice<T>(Iterable<T> choices, [Iterable<double> weights = const []]) {
  if (choices.isEmpty) {
    throw ArgumentError.value(
      choices.toString(),
      'options',
      'must be non-empty',
    );
  }

  if (weights.isNotEmpty && choices.length != weights.length) {
    throw ArgumentError.value(
      weights.toString(),
      'weights',
      'must be empty or match length of options',
    );
  }

  if (weights.isEmpty) {
    return choices.elementAt(Random().nextInt(choices.length));
  }

  final double sum = weights.reduce((val, curr) => val + curr);
  double randomWeight = Random().nextDouble() * sum;

  int i = 0;
  for (final int len = choices.length; i < len; i++) {
    randomWeight -= weights.elementAt(i);
    if (randomWeight <= 0) {
      break;
    }
  }

  return choices.elementAt(i);
}

bool isHit(double percentage) {
  if (percentage > 1 || percentage < 0) {
    throw ArgumentError.value(
      percentage.toString(),
      'percentage',
      'must be between 0 and 1',
    );
  }
  return Random.secure().nextDouble() <= percentage;
}
