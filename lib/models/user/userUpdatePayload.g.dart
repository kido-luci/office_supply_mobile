// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userUpdatePayload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUpdatePayload _$UserUpdatePayloadFromJson(Map<String, dynamic> json) =>
    UserUpdatePayload(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      isMale: json['isMale'] as bool?,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$UserUpdatePayloadToJson(UserUpdatePayload instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'isMale': instance.isMale,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
    };
