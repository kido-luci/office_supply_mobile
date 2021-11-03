// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderUpdatePayload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderUpdatePayload _$OrderUpdatePayloadFromJson(Map<String, dynamic> json) =>
    OrderUpdatePayload(
      userApproveID: json['userApproveID'] as int,
      orderID: json['orderID'] as int,
      isApprove: json['isApprove'] as bool,
      description: json['description'] as String,
    );

Map<String, dynamic> _$OrderUpdatePayloadToJson(OrderUpdatePayload instance) =>
    <String, dynamic>{
      'userApproveID': instance.userApproveID,
      'orderID': instance.orderID,
      'isApprove': instance.isApprove,
      'description': instance.description,
    };
