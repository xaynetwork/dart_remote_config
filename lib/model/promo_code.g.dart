// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoCode _$PromoCodeFromJson(Map<String, dynamic> json) => PromoCode(
      code: json['code'] as String,
      grantedDuration: _durationFromJson(json['grantedDuration'] as int?),
      grantedSku: json['grantedSku'] as String?,
      enabled: json['enabled'] as bool? ?? true,
      expiresOn: json['expiresOn'] == null
          ? null
          : DateTime.parse(json['expiresOn'] as String),
    );

Map<String, dynamic> _$PromoCodeToJson(PromoCode instance) => <String, dynamic>{
      'code': instance.code,
      'grantedSku': instance.grantedSku,
      'grantedDuration': _durationToJson(instance.grantedDuration),
      'enabled': instance.enabled,
      'expiresOn': instance.expiresOn?.toIso8601String(),
    };
