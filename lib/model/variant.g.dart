// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Variant _$VariantFromJson(Map<String, dynamic> json) => Variant(
      id: json['id'] as String,
      features: (_readValue(json, 'features') as List<dynamic>)
          .map((e) => Feature.fromJson(e))
          .toList(),
      ratio: json['ratio'] as int? ?? 1,
    );

Map<String, dynamic> _$VariantToJson(Variant instance) => <String, dynamic>{
      'id': instance.id,
      'ratio': instance.ratio,
      'features': instance.features,
    };
