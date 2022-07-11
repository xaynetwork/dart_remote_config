import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

import 'exceptions/remote_config_parser_exception.dart';

part 'feature.g.dart';

@JsonSerializable()
class Feature {
  final String id;
  final String? value;

  bool get hasValue => value != null;

  Feature({
    required this.id,
    this.value,
  });

  factory Feature.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return _$FeatureFromJson(json);
    } else if (json is YamlMap) {
      return _$FeatureFromJson(json.cast());
    }
    throw RemoteConfigParserException(
        "Feature: Unknown type in fromJson: $json");
  }

  Map<String, dynamic> toJson() => _$FeatureToJson(this);
}
