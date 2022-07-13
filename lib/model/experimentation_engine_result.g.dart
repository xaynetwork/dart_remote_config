// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experimentation_engine_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExperimentInstance _$$_ExperimentInstanceFromJson(
        Map<String, dynamic> json) =>
    _$_ExperimentInstance(
      experiment: Experiment.fromJson(json['experiment']),
      selectedVariant: Variant.fromJson(json['selectedVariant']),
    );

Map<String, dynamic> _$$_ExperimentInstanceToJson(
        _$_ExperimentInstance instance) =>
    <String, dynamic>{
      'experiment': instance.experiment,
      'selectedVariant': instance.selectedVariant,
    };
