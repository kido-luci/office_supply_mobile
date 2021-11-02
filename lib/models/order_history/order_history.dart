import 'package:json_annotation/json_annotation.dart';
part 'order_history.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderHistory {
  final int id;
  final DateTime createTime;
  DateTime? approveTime;
  final int userOrderID;
  int? userApproveID;
  int orderStatusID;
  final String? userOrder;
  String? userApprove;

  OrderHistory(
      {required this.id,
      required this.createTime,
      required this.approveTime,
      required this.userOrderID,
      required this.userApproveID,
      required this.orderStatusID,
      required this.userApprove,
      required this.userOrder});

  factory OrderHistory.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryFromJson(json);

  Map toJson() => _$OrderHistoryToJson(this);
}
