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

_$ExperimentationEngineResultSuccess
    _$$ExperimentationEngineResultSuccessFromJson(Map<String, dynamic> json) =>
        _$ExperimentationEngineResultSuccess(
          (json['subscribedExperiments'] as List<dynamic>)
              .map((e) => ExperimentResult.fromJson(e as Map<String, dynamic>))
              .toSet(),
          (json['featuresDefinedInConfig'] as List<dynamic>)
              .map((e) => Feature.fromJson(e))
              .toList(),
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$ExperimentationEngineResultSuccessToJson(
        _$ExperimentationEngineResultSuccess instance) =>
    <String, dynamic>{
      'subscribedExperiments': instance.subscribedExperiments.toList(),
      'featuresDefinedInConfig': instance.featuresDefinedInConfig,
      'runtimeType': instance.$type,
    };

_$ExperimentationEngineResultFailure
    _$$ExperimentationEngineResultFailureFromJson(Map<String, dynamic> json) =>
        _$ExperimentationEngineResultFailure(
          error: $enumDecode(
              _$ExperimentationEngineResultErrorEnumMap, json['error']),
          message: json['message'] as String?,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$ExperimentationEngineResultFailureToJson(
        _$ExperimentationEngineResultFailure instance) =>
    <String, dynamic>{
      'error': _$ExperimentationEngineResultErrorEnumMap[instance.error],
      'message': instance.message,
      'runtimeType': instance.$type,
    };

const _$ExperimentationEngineResultErrorEnumMap = {
  ExperimentationEngineResultError.errorWhileParsing: 'errorWhileParsing',
  ExperimentationEngineResultError.errorNoData: 'errorNoData',
};
