import 'package:dart_remote_config/dart_remote_config.dart';
import 'package:dart_remote_config/model/exceptions/remote_config_parser_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

part 'filter.g.dart';

String _versionConstraintToJson(VersionConstraint? constraint) =>
    constraint.toString();

VersionConstraint? _versionConstraintFromJson(String constraint) =>
    VersionConstraint.parse(constraint);

@JsonSerializable()
class Filter extends Equatable {
  @JsonKey(
    fromJson: _versionConstraintFromJson,
    toJson: _versionConstraintToJson,
  )
  final VersionConstraint? appVersion;

  const Filter({
    this.appVersion,
  });

  factory Filter.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return _$FilterFromJson(json);
    } else if (json is YamlMap) {
      return _$FilterFromJson(json.cast());
    }
    throw RemoteConfigParserException(
      "Variant: Unknown type in fromJson: $json",
    );
  }

  Map<String, dynamic> toJson() => _$FilterToJson(this);

  @override
  List<Object?> get props => [appVersion];

  bool isActive(Version version) {
    return appVersion?.allows(version) ?? true;
  }
}
