import 'package:json_annotation/json_annotation.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';

part 'order_history_item.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderHistoryItem {
  final int id;
  final DateTime createTime;
  DateTime? approveTime;
  final int userOrderID;
  int? userApproveID;
  int orderStatusID;
  final Map<String, dynamic> userOrder;
  final Map<String, dynamic>? userApprove;

  @JsonKey(ignore: true)
  late User userOrdrerObject;

  @JsonKey(ignore: true)
  late User? userApproveObject;

  OrderHistoryItem({
    required this.id,
    required this.createTime,
    required this.approveTime,
    required this.userOrderID,
    required this.userApproveID,
    required this.orderStatusID,
    required this.userOrder,
    required this.userApprove,
  }) {
    userOrdrerObject = User.fromJson(userOrder);
    if (userApprove != null) {
      userApproveObject = User.fromJson(userApprove!);
    }
  }

  factory OrderHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderHistoryItemToJson(this);
}
