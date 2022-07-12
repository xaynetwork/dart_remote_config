import 'package:dart_remote_config/model/exceptions/remote_config_parser_exception.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

part 'promo_code.g.dart';

int? _durationToJson(Duration? duration) => duration?.inSeconds;

Duration? _durationFromJson(int? seconds) =>
    seconds == null ? null : Duration(seconds: seconds);

@JsonSerializable()
class PromoCode {
  final String code;
  final String? grantedSku;

  /// in seconds
  @JsonKey(fromJson: _durationFromJson, toJson: _durationToJson)
  final Duration? grantedDuration;

  final bool enabled;
  final DateTime? expiresOn;

  bool get isValid =>
      enabled &&
      (expiresOn == null || expiresOn!.isAfter(DateTime.now()) == true);

  PromoCode({
    required this.code,
    this.grantedDuration,
    this.grantedSku,
    this.enabled = true,
    this.expiresOn,
  });

  factory PromoCode.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return _$PromoCodeFromJson(json);
    } else if (json is YamlMap) {
      return _$PromoCodeFromJson(json.cast());
    }
    throw RemoteConfigParserException("Unknown type in fromJson: $json");
  }

  Map<String, dynamic> toJson() => _$PromoCodeToJson(this);
}
