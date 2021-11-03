import 'package:json_annotation/json_annotation.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';
part 'order_history.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderHistory {
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

  OrderHistory({
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

  factory OrderHistory.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryFromJson(json);

  Map toJson() => _$OrderHistoryToJson(this);
}
