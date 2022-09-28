// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experiment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Experiment _$ExperimentFromJson(Map<String, dynamic> json) => Experiment(
      id: json['id'] as String,
      size: _validRatio(json['size'] as double),
      variants: (json['variants'] as List<dynamic>?)
              ?.map((e) => Variant.fromJson(e))
              .toList() ??
          const [],
      enabled: json['enabled'] as bool? ?? true,
      exclusive: json['exclusive'] as bool? ?? true,
      filter: json['filter'] == null
          ? const Filter()
          : Filter.fromJson(json['filter']),
    );

Map<String, dynamic> _$ExperimentToJson(Experiment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'enabled': instance.enabled,
      'exclusive': instance.exclusive,
      'variants': instance.variants,
      'size': _validRatio(instance.size),
      'filter': instance.filter,
    };
