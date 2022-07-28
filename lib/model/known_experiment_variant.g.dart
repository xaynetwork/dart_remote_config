// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'known_experiment_variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnownVariantId _$KnownExperimentVariantFromJson(Map<String, dynamic> json) =>
    KnownVariantId(
      json['experimentId'] as String,
      json['variantId'] as String?,
    );

Map<String, dynamic> _$KnownExperimentVariantToJson(KnownVariantId instance) =>
    <String, dynamic>{
      'experimentId': instance.experimentId,
      'variantId': instance.variantId,
    };
