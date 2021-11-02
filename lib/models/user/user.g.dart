// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      isMale: json['isMale'] as bool?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String,
      address: json['address'] as String?,
      avatarUrl: json['avatarUrl'] as String,
      departmentID: json['departmentID'] as int?,
      companyID: json['companyID'] as int?,
      menuID: json['menuID'] as int?,
      roleID: json['roleID'] as int,
      isDelete: json['isDelete'] as bool,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'isMale': instance.isMale,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'address': instance.address,
      'avatarUrl': instance.avatarUrl,
      'departmentID': instance.departmentID,
      'companyID': instance.companyID,
      'menuID': instance.menuID,
      'roleID': instance.roleID,
      'isDelete': instance.isDelete,
    };
