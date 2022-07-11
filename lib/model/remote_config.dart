import 'package:dart_remote_config/model/exceptions/remote_config_parser_exception.dart';
import 'package:dart_remote_config/model/experiment.dart';
import 'package:dart_remote_config/model/feature.dart';
import 'package:dart_remote_config/model/promo_code.dart';
import 'package:dart_remote_config/utils/extensions.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

part 'remote_config.g.dart';

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
  final List<Feature> features;
  final List<Experiment> experiments;

  RemoteConfig({
    required this.appVersion,
    this.promoCodes = const [],
    this.features = const [],
    this.experiments = const [],
  });

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
