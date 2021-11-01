// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistory _$OrderHistoryFromJson(Map<String, dynamic> json) => OrderHistory(
      id: json['id'] as int,
      createTime: DateTime.parse(json['createTime'] as String),
      approveTime: json['approveTime'] == null
          ? null
          : DateTime.parse(json['approveTime'] as String),
      userOrderID: json['userOrderID'] as int,
      userApproveID: json['userApproveID'] as int?,
      orderStatusID: json['orderStatusID'] as int,
      userApprove: json['userApprove'] as String?,
      userOrder: json['userOrder'] as String?,
    );

Map<String, dynamic> _$OrderHistoryToJson(OrderHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createTime': instance.createTime.toIso8601String(),
      'approveTime': instance.approveTime?.toIso8601String(),
      'userOrderID': instance.userOrderID,
      'userApproveID': instance.userApproveID,
      'orderStatusID': instance.orderStatusID,
      'userOrder': instance.userOrder,
      'userApprove': instance.userApprove,
    };
