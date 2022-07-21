import 'dart:math';

import 'package:dart_remote_config/utils/random_choice.dart';
import 'package:test/test.dart';

void main() {
  const countTries = 10000;
  const error = 0.05;

  test('Not passing weights, choose according to uniform distribution.', () {
    const numOptions = 10;

    final choices = List.generate(numOptions, (i) => i);
    final results = List.generate(numOptions, (_) => 0);

    for (int i = 0; i < countTries; i++) {
      results[randomChoice(choices)]++;
    }

    expect(
      results,
      everyElement(closeTo(countTries / choices.length, error * countTries)),
    );
  });

  test('Including weights generates according to weighted distribution.', () {
    const numOptions = 10;

    final choices = List.generate(numOptions, (i) => i);
    final weights = List.generate(numOptions, (_) => Random().nextDouble());
    final results = List.generate(numOptions, (_) => 0);

    for (int i = 0; i < countTries; i++) {
      results[randomChoice(choices, weights)]++;
    }

    final totalWeight = weights.reduce((val, curr) => val + curr);
    final expected = List.generate(
      numOptions,
      (i) => ((weights[i] / totalWeight) * countTries).floor(),
    );

    expect(
      results,
      pairwiseCompare<num, num>(
        expected,
        (num e, num a) => (e - a).abs() <= (error * countTries),
        'within $error error.',
      ),
    );
  });

  test('Empty choices list throws ArgumentError.', () {
    expect(() => randomChoice([]), throwsArgumentError);
  });

  test('Different length weights throws ArgumentError.', () {
    expect(() => randomChoice([5, 3], [0.4]), throwsArgumentError);
  });

  test('Invalid percentage throws ArgumentError.', () {
    expect(() => isHit(1.4), throwsArgumentError);
  });

  test('passing percentage will uniformly be true for the percentage of tries ',
      () {
    final percentage = Random().nextDouble();
    int countHit = 0;

    for (int i = 0; i < countTries; i++) {
      if (isHit(percentage)) countHit++;
    }

    expect(
      countHit,
      closeTo(countTries * percentage, error * countTries),
    );
  });
}
