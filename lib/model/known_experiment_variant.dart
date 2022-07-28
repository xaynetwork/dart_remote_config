import 'package:dart_remote_config/model/exceptions/remote_config_parser_exception.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

part 'known_experiment_variant.g.dart';

@JsonSerializable()
class KnownVariantId {
  final String experimentId;
  final String? variantId;

  const KnownVariantId(this.experimentId, this.variantId);

  bool get isSubscribed => variantId != null;

  factory KnownVariantId.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return _$KnownVariantIdFromJson(json);
    } else if (json is YamlMap) {
      return _$KnownVariantIdFromJson(json.cast());
    }
    throw RemoteConfigParserException(
      "KnownVariantId: Unknown type in fromJson: $json",
    );
  }

  Map<String, dynamic> toJson() => _$KnownVariantIdToJson(this);
}
