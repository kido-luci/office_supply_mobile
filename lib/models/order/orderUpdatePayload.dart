// ignore_for_file: file_names

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'orderUpdatePayload.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderUpdatePayload {
  late int userApproveID;
  late int orderID;
  late bool isApprove;
  late String description;

  OrderUpdatePayload({
    required this.userApproveID,
    required this.orderID,
    required this.isApprove,
    required this.description,
  });

  String toJson() => jsonEncode(_$OrderUpdatePayloadToJson(this));
  factory OrderUpdatePayload.fromJson(Map<String, dynamic> json) =>
      _$OrderUpdatePayloadFromJson(json);
}
