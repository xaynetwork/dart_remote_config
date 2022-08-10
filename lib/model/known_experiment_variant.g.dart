// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'known_experiment_variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnownVariantId _$KnownVariantIdFromJson(Map<String, dynamic> json) =>
    KnownVariantId(
      json['experimentId'] as String,
      json['variantId'] as String?,
      (json['size'] as num).toDouble(),
    );

Map<String, dynamic> _$KnownVariantIdToJson(KnownVariantId instance) =>
    <String, dynamic>{
      'experimentId': instance.experimentId,
      'variantId': instance.variantId,
      'size': instance.size,
    };
