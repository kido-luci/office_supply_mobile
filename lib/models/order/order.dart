import 'package:json_annotation/json_annotation.dart';
import 'package:office_supply_mobile_master/models/order_detail/order_detail.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  final int userOrderID;
  @JsonKey(ignore: true)
  late List<OrderDetail> orderDetails;

  Order({required this.userOrderID}) {
    orderDetails = List.empty(growable: true);
  }

  factory Order.fromJson(Map<String, String> json) => _$OrderFromJson(json);

  Map toJson() {
    List<Map> orderDetailsJson = List.empty(growable: true);
    for (var e in orderDetails) {
      orderDetailsJson.add(e.toJson());
    }

    Map<String, dynamic> jsonMap = _$OrderToJson(this);
    jsonMap['orderDetail'] = orderDetailsJson;

    return jsonMap;
  }
}
