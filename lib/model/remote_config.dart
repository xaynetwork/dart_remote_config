import 'package:dart_remote_config/utils/extensions.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

part 'remote_config.g.dart';

class RemoteConfigParserException implements Exception {
  final String message;

  const RemoteConfigParserException(this.message);

  @override
  String toString() => "RemoteConfigParserException: $message";
}

class RemoteConfigs {
  final List<RemoteConfig> configs;

  RemoteConfig? findConfig(String versionString) {
    final version = Version.parse(versionString);
    return configs.firstWhereOrNull(
      (element) => element.appVersion.allows(version),
    );
  }

  RemoteConfigs({required this.configs});

  factory RemoteConfigs.fromJson(dynamic json) {
    if (json is List<dynamic> || json is YamlList) {
      final list =
          // ignore: avoid_dynamic_calls
          json.map((e) => RemoteConfig.fromJson(e)).toList() as List<dynamic>;

      return RemoteConfigs(
        configs: list.cast<RemoteConfig>(),
      );
    }
    throw RemoteConfigParserException("Unknown type in fromJson: $json");
  }
}

String _versionConstraintToJson(VersionConstraint constraint) =>
    constraint.toString();

VersionConstraint _versionConstraintFromJson(String constraint) =>
    VersionConstraint.parse(constraint);

@JsonSerializable()
class RemoteConfig {
  @JsonKey(
    fromJson: _versionConstraintFromJson,
    toJson: _versionConstraintToJson,
  )
  final VersionConstraint appVersion;
  final List<PromoCode> promoCodes;

  RemoteConfig({required this.appVersion, this.promoCodes = const []});

  factory RemoteConfig.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return _$RemoteConfigFromJson(json);
    } else if (json is YamlMap) {
      return _$RemoteConfigFromJson(json.cast());
    }
    throw RemoteConfigParserException("Unknown type in fromJson: $json");
  }

  Map<String, dynamic> toJson() => _$RemoteConfigToJson(this);

  PromoCode? findValidPromoCode(String promoCode) {
    return promoCodes.firstWhereOrNull((element) {
      return element.isValid && element.code == promoCode;
    });
  }
}

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
