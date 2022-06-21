// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteConfig _$RemoteConfigFromJson(Map<String, dynamic> json) => RemoteConfig(
      appVersion: _versionConstraintFromJson(json['appVersion'] as String),
      promoCodes: (json['promoCodes'] as List<dynamic>?)
              ?.map((e) => PromoCode.fromJson(e))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteConfigToJson(RemoteConfig instance) =>
    <String, dynamic>{
      'appVersion': _versionConstraintToJson(instance.appVersion),
      'promoCodes': instance.promoCodes,
    };

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
