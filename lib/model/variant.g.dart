// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Variant _$VariantFromJson(Map<String, dynamic> json) => Variant(
      id: json['id'] as String,
      featureIds: (json['featureIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      ratio: json['ratio'] as int? ?? 1,
    );

Map<String, dynamic> _$VariantToJson(Variant instance) => <String, dynamic>{
      'id': instance.id,
      'ratio': instance.ratio,
      'featureIds': instance.featureIds,
    };
