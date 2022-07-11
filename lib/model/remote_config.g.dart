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
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => Feature.fromJson(e))
              .toList() ??
          const [],
      experiments: (json['experiments'] as List<dynamic>?)
              ?.map((e) => Experiment.fromJson(e))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteConfigToJson(RemoteConfig instance) =>
    <String, dynamic>{
      'appVersion': _versionConstraintToJson(instance.appVersion),
      'promoCodes': instance.promoCodes,
      'features': instance.features,
      'experiments': instance.experiments,
    };
