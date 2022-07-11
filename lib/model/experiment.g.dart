// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experiment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Experiment _$ExperimentFromJson(Map<String, dynamic> json) => Experiment(
      id: json['id'] as String,
      size: (json['size'] as num).toDouble(),
      variants: (json['variants'] as List<dynamic>)
          .map((e) => Variant.fromJson(e))
          .toList(),
      enabled: json['enabled'] as bool? ?? true,
      exclusive: json['exclusive'] as bool? ?? true,
    );

Map<String, dynamic> _$ExperimentToJson(Experiment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'enabled': instance.enabled,
      'exclusive': instance.exclusive,
      'variants': instance.variants,
      'size': instance.size,
    };
