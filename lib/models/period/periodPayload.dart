// ignore_for_file: file_names
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'periodPayload.g.dart';

@JsonSerializable(explicitToJson: true)
class PeriodPayload {
  late String name;
  late int departmentID;
  late DateTime fromTime;
  late DateTime toTime;
  late double quota;

  PeriodPayload({
    required this.name,
    required this.departmentID,
    required this.fromTime,
    required this.toTime,
    required this.quota,
  });

  String toJson() {
    Map<String, dynamic> periodMap = _$PeriodPayloadToJson(this);
    var periodJson = jsonEncode(periodMap);
    return periodJson;
  }

  factory PeriodPayload.fromJson(Map<String, dynamic> periodMap) {
    return _$PeriodPayloadFromJson(periodMap);
  }
}
