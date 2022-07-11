import 'package:dart_remote_config/model/exceptions/remote_config_parser_exception.dart';
import 'package:dart_remote_config/model/feature.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

part 'variant.g.dart';

@JsonSerializable()
class Variant {
  final String id;
  final int ratio;
  final List<Feature> features;

  Variant({
    required this.id,
    required this.features,
    this.ratio = 1,
  });

  factory Variant.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return _$VariantFromJson(json);
    } else if (json is YamlMap) {
      return _$VariantFromJson(json.cast());
    }
    throw RemoteConfigParserException(
        "Variant: Unknown type in fromJson: $json");
  }

  Map<String, dynamic> toJson() => _$VariantToJson(this);
}
