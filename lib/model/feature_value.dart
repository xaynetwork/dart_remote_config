import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_value.freezed.dart';

@freezed
class FeatureValue with _$FeatureValue {
  const factory FeatureValue.nothing() = FeatureValueNothing;

  const factory FeatureValue.string(
    final String stringValue,
  ) = FeatureValueString;

  const factory FeatureValue.boolean(
    // ignore: avoid_positional_boolean_parameters
    final bool boolValue,
  ) = FeatureValueBool;
}
