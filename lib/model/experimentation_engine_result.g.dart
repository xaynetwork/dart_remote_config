// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experimentation_engine_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExperimentInstance _$$_ExperimentInstanceFromJson(
        Map<String, dynamic> json) =>
    _$_ExperimentInstance(
      experiment: Experiment.fromJson(json['experiment']),
      initialSelectedVariant: Variant.fromJson(json['initialSelectedVariant']),
    );

Map<String, dynamic> _$$_ExperimentInstanceToJson(
        _$_ExperimentInstance instance) =>
    <String, dynamic>{
      'experiment': instance.experiment,
      'initialSelectedVariant': instance.initialSelectedVariant,
    };
