// ignore_for_file: unnecessary_this

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

  // String toJson() {
  //   Map<String, dynamic> periodMap = {
  //     'id': this.id,
  //     'name': this.name,
  //     'departmentID': this.departmentID,
  //     'fromTime': this.fromTime,
  //     'toTime': this.toTime,
  //     'quota': this.quota,
  //     'remainingQuota': this.remainingQuota,
  //     'isExpired': this.isExpired
  //   };

  //   var jsonData = jsonEncode(periodMap);
  //   return jsonData;
  // }

  // factory Period.fromJson(String jsonData) {
  //   var periodMap = jsonDecode(jsonData);

  //   return Period(
  //       id: periodMap['id'],
  //       name: periodMap['name'],
  //       departmentID: periodMap['departmentID'],
  //       fromTime: periodMap['fromTime'],
  //       toTime: periodMap['toTime'],
  //       quota: periodMap['quota'],
  //       remainingQuota: periodMap['remainingQuota'],
  //       isExpired: periodMap['isExpired']);
  // }

  String toJson(){
    Map<String, dynamic> periodMap = _$PeriodToJson(this);
    var periodJson = jsonEncode(periodMap);
    return periodJson;
  }

  factory Period.fromJson(Map<String, dynamic> periodMap){
    return _$PeriodFromJson(periodMap);
  }
}
