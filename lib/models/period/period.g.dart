// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Period _$PeriodFromJson(Map<String, dynamic> json) => Period(
      id: json['id'] as int,
      name: json['name'] as String,
      departmentID: json['departmentID'] as int,
      fromTime: DateTime.parse(json['fromTime'] as String),
      toTime: DateTime.parse(json['toTime'] as String),
      quota: (json['quota'] as num).toDouble(),
      remainingQuota: (json['remainingQuota'] as num).toDouble(),
      isExpired: json['isExpired'] as bool,
    );

Map<String, dynamic> _$PeriodToJson(Period instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'departmentID': instance.departmentID,
      'fromTime': instance.fromTime.toIso8601String(),
      'toTime': instance.toTime.toIso8601String(),
      'quota': instance.quota,
      'remainingQuota': instance.remainingQuota,
      'isExpired': instance.isExpired,
    };
