// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'periodPayload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeriodPayload _$PeriodPayloadFromJson(Map<String, dynamic> json) =>
    PeriodPayload(
      name: json['name'] as String,
      departmentID: json['departmentID'] as int,
      fromTime: DateTime.parse(json['fromTime'] as String),
      toTime: DateTime.parse(json['toTime'] as String),
      quota: (json['quota'] as num).toDouble(),
    );

Map<String, dynamic> _$PeriodPayloadToJson(PeriodPayload instance) =>
    <String, dynamic>{
      'name': instance.name,
      'departmentID': instance.departmentID,
      'fromTime': instance.fromTime.toIso8601String(),
      'toTime': instance.toTime.toIso8601String(),
      'quota': instance.quota,
    };
