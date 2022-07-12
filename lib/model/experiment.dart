import 'package:dart_remote_config/model/exceptions/remote_config_parser_exception.dart';
import 'package:dart_remote_config/model/variant.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

part 'experiment.g.dart';

double _validRatio(double size) {
  if (size < 0) {
    return 0;
  } else if (size > 1) {
    return 1;
  } else {
    return size;
  }
}

@JsonSerializable()
class Experiment {
  final String id;

  @JsonKey(defaultValue: true)
  final bool enabled;

  @JsonKey(defaultValue: true)
  final bool exclusive;

  final List<Variant> variants;

  @JsonKey(toJson: _validRatio, fromJson: _validRatio)
  final double size;

  Experiment({
    required this.id,
    required this.size,
    required this.variants,
    this.enabled = true,
    this.exclusive = true,
  });

  factory Experiment.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return _$ExperimentFromJson(json);
    } else if (json is YamlMap) {
      return _$ExperimentFromJson(json.cast());
    }
    throw RemoteConfigParserException(
      "Experiment: Unknown type in fromJson: $json",
    );
  }

  Map<String, dynamic> toJson() => _$ExperimentToJson(this);
}
