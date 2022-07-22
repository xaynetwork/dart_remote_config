// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experimentation_engine_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExperimentResultSubscribed _$$ExperimentResultSubscribedFromJson(
        Map<String, dynamic> json) =>
    _$ExperimentResultSubscribed(
      experiment: Experiment.fromJson(json['experiment']),
      initialSelectedVariant: Variant.fromJson(json['initialSelectedVariant']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ExperimentResultSubscribedToJson(
        _$ExperimentResultSubscribed instance) =>
    <String, dynamic>{
      'experiment': instance.experiment,
      'initialSelectedVariant': instance.initialSelectedVariant,
      'runtimeType': instance.$type,
    };

_$ExperimentResultNotSubscribed _$$ExperimentResultNotSubscribedFromJson(
        Map<String, dynamic> json) =>
    _$ExperimentResultNotSubscribed(
      experiment: Experiment.fromJson(json['experiment']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ExperimentResultNotSubscribedToJson(
        _$ExperimentResultNotSubscribed instance) =>
    <String, dynamic>{
      'experiment': instance.experiment,
      'runtimeType': instance.$type,
    };

_$_ExperimentationEngineResult _$$_ExperimentationEngineResultFromJson(
        Map<String, dynamic> json) =>
    _$_ExperimentationEngineResult(
      (json['computedExperiments'] as List<dynamic>)
          .map((e) => ExperimentResult.fromJson(e as Map<String, dynamic>))
          .toSet(),
      (json['featuresDefinedInConfig'] as List<dynamic>)
          .map((e) => Feature.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$$_ExperimentationEngineResultToJson(
        _$_ExperimentationEngineResult instance) =>
    <String, dynamic>{
      'computedExperiments': instance.computedExperiments.toList(),
      'featuresDefinedInConfig': instance.featuresDefinedInConfig,
    };
