// ignore_for_file: file_names
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'userUpdatePayload.g.dart';

@JsonSerializable(explicitToJson: true)
class UserUpdatePayload {
  late String firstname;
  late String lastname;
  late DateTime? dateOfBirth;
  late bool? isMale;
  late String phoneNumber;
  late String address;

  UserUpdatePayload({
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.isMale,
    required this.phoneNumber,
    required this.address,
  });

  String toJson() {
    Map<String, dynamic> periodMap = _$UserUpdatePayloadToJson(this);
    var periodJson = jsonEncode(periodMap);
    return periodJson;
  }

  factory UserUpdatePayload.fromJson(Map<String, dynamic> periodMap) {
    return _$UserUpdatePayloadFromJson(periodMap);
  }
}
