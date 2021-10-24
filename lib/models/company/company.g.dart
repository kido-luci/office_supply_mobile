// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      id: json['id'] as int,
      name: json['name'] as String,
      wallet: (json['wallet'] as num).toDouble(),
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      areaID: json['areaID'] as int,
      managerID: json['managerID'] as int,
      isDelete: json['isDelete'] as bool?,
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'wallet': instance.wallet,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'areaID': instance.areaID,
      'managerID': instance.managerID,
      'isDelete': instance.isDelete,
    };
