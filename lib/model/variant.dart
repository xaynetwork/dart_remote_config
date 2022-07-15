import 'package:dart_remote_config/model/exceptions/remote_config_parser_exception.dart';
import 'package:dart_remote_config/model/feature.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yaml/yaml.dart';

part 'variant.g.dart';

Object? _readValue(Map<dynamic, dynamic> map, String key) {
  return map[key];
}

@JsonSerializable()
class Variant {
  final String id;
  final int ratio;

  @JsonKey(readValue: _readValue)
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
      "Variant: Unknown type in fromJson: $json",
    );
  }

  Map<String, dynamic> toJson() => _$VariantToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Variant &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(id));
}
