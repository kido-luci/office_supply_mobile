
// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';

part 'orderDTO.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDTO {
  late int id;
  late DateTime createTime;
  late DateTime? approveTime;
  late int? userOrderID;
  late int? userApproveID;
  late int orderStatusID;
  late User userOrder;
  late User userApprove;

  OrderDTO({
    required this.id,
    required this.createTime,
    required this.approveTime,
    required this.userOrderID,
    required this.userApproveID,
    required this.orderStatusID,
    required this.userOrder,
    required this.userApprove,
  });

  String toJson() => jsonEncode(_$OrderDTOToJson(this));
  factory OrderDTO.fromJson(Map<String, dynamic> json) => _$OrderDTOFromJson(json);
}