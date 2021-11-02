import 'package:json_annotation/json_annotation.dart';
import 'package:office_supply_mobile_master/models/product_in_menu_history/product_in_menu_history.dart';
part 'order_detail_history.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDetailHistory {
  final int orderID;
  final int productID;
  final int menuID;
  int quantity;
  double price;
  final Map<String, dynamic> productInMenu;
  @JsonKey(ignore: true)
  late ProductInMenuHistory productInMenuObject;

  OrderDetailHistory(
      {required this.orderID,
      required this.productID,
      required this.menuID,
      required this.quantity,
      required this.price,
      required this.productInMenu}) {
    productInMenuObject = ProductInMenuHistory.fromJson(productInMenu);
  }

  factory OrderDetailHistory.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailHistoryFromJson(json);

  Map toJson() => _$OrderDetailHistoryToJson(this);
}
