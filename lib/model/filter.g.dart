// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filter _$FilterFromJson(Map<String, dynamic> json) => Filter(
      appVersion: _versionConstraintFromJson(json['appVersion'] as String),
    );

Map<String, dynamic> _$FilterToJson(Filter instance) => <String, dynamic>{
      'appVersion': _versionConstraintToJson(instance.appVersion),
    };
