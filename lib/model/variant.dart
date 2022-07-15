import 'package:dart_remote_config/model/exceptions/remote_config_parser_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yaml/yaml.dart';

part 'variant.g.dart';

@JsonSerializable()
class Variant {
  final String id;
  final int ratio;

  final List<String> featureIds;

  Variant({
    required this.id,
    this.featureIds = const [],
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
