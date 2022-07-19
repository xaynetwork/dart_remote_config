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

_$ExperimentationEngineResultSuccess
    _$$ExperimentationEngineResultSuccessFromJson(Map<String, dynamic> json) =>
        _$ExperimentationEngineResultSuccess(
          (json['computedExperiments'] as List<dynamic>)
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
      'computedExperiments': instance.computedExperiments.toList(),
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
