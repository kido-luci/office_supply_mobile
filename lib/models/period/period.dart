import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'period.g.dart';

@JsonSerializable(explicitToJson: true)
class Period {
  final int id;
  final String name;
  final int departmentID;
  final DateTime fromTime;
  final DateTime toTime;
  final double quota;
  final double remainingQuota;
  final bool isExpired;

  Period(
      {required this.id,
      required this.name,
      required this.departmentID,
      required this.fromTime,
      required this.toTime,
      required this.quota,
      required this.remainingQuota,
      required this.isExpired});

  String toJson() => jsonEncode(_$PeriodToJson(this));
  factory Period.fromJson(Map<String, dynamic> json) => _$PeriodFromJson(json);
}
