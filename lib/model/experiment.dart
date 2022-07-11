import 'package:dart_remote_config/model/exceptions/remote_config_parser_exception.dart';
import 'package:dart_remote_config/model/variant.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

part 'experiment.g.dart';

@JsonSerializable()
class Experiment {
  final String id;
  final bool enabled;
  final bool exclusive;
  final List<Variant> variants;

  /// TODO: Add validation that size is between 0 and 1
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
        "Experiment: Unknown type in fromJson: $json");
  }

  Map<String, dynamic> toJson() => _$ExperimentToJson(this);
}
