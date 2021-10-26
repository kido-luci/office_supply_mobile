import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'period.g.dart';

@JsonSerializable(explicitToJson: true)
class Period {
  late int id;
  late String name;
  late int departmentID;
  late DateTime fromTime;
  late DateTime toTime;
  late double quota;
  late double remainingQuota;
  late bool isExpired;

  Period(
      {required this.id,
      required this.name,
      required this.departmentID,
      required this.fromTime,
      required this.toTime,
      required this.quota,
      required this.remainingQuota,
      required this.isExpired});

  String toJson() {
    Map<String, dynamic> periodMap = _$PeriodToJson(this);
    var periodJson = jsonEncode(periodMap);
    return periodJson;
  }

  factory Period.fromJson(Map<String, dynamic> periodMap) {
    return _$PeriodFromJson(periodMap);
  }
}
