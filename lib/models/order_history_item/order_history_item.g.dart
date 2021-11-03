// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryItem _$OrderHistoryItemFromJson(Map<String, dynamic> json) =>
    OrderHistoryItem(
      id: json['id'] as int,
      createTime: DateTime.parse(json['createTime'] as String),
      approveTime: json['approveTime'] == null
          ? null
          : DateTime.parse(json['approveTime'] as String),
      userOrderID: json['userOrderID'] as int,
      userApproveID: json['userApproveID'] as int?,
      orderStatusID: json['orderStatusID'] as int,
      userOrder: json['userOrder'] as Map<String, dynamic>,
      userApprove: json['userApprove'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$OrderHistoryItemToJson(OrderHistoryItem instance) =>
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
