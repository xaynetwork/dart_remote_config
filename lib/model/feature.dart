import 'package:dart_remote_config/model/exceptions/remote_config_parser_exception.dart';
import 'package:dart_remote_config/model/feature_value.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

part 'feature.g.dart';

FeatureValue _valueToJson(dynamic value) {
  if (value is String) return FeatureValue.string(value);
  if (value is bool) return FeatureValue.boolean(value);
  return const FeatureValue.nothing();
}

dynamic _valueFromJson(FeatureValue? value) => value?.mapOrNull(
      string: (stringValue) => stringValue,
      boolean: (boolValue) => boolValue,
    );

@JsonSerializable()
class Feature extends Equatable {
  final String id;

  @JsonKey(
    fromJson: _valueToJson,
    toJson: _valueFromJson,
  )
  final FeatureValue value;

  bool get hasValue => value.map(
        nothing: (_) => false,
        string: (_) => true,
        boolean: (_) => true,
      );

  const Feature({
    required this.id,
    FeatureValue? value,
  }) : value = value ?? const FeatureValue.nothing();

  factory Feature.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return _$FeatureFromJson(json);
    } else if (json is YamlMap) {
      return _$FeatureFromJson(json.cast());
    }
    throw RemoteConfigParserException(
      "Feature: Unknown type in fromJson: $json",
    );
  }

  Map<String, dynamic> toJson() => _$FeatureToJson(this);

  @override
  List<Object?> get props => [id, value];
}
