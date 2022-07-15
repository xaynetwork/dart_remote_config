import 'package:dart_remote_config/model/exceptions/remote_config_parser_exception.dart';
import 'package:dart_remote_config/model/variant.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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

enum ExperimentType {
  concluded,
  rollout,
  aBExperiment;

  static ExperimentType fromExperimentSpecs({
    required double size,
    required int variantLength,
  }) {
    if (size == 1 && variantLength == 1) return ExperimentType.concluded;
    if (size < 1 && variantLength == 1) return ExperimentType.rollout;
    return ExperimentType.aBExperiment;
  }
}

@immutable
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

  ExperimentType get type => ExperimentType.fromExperimentSpecs(
        size: size,
        variantLength: variants.length,
      );

  bool get isConcluded => type == ExperimentType.concluded;

  const Experiment({
    required this.id,
    required this.size,
    this.variants = const [],
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

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Experiment &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(id));
}