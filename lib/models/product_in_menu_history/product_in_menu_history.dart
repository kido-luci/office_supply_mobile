import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:office_supply_mobile_master/models/product_history/product_history.dart';
part 'product_in_menu_history.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductInMenuHistory {
  final int menuID;
  final int productID;
  int quantity;
  final double price;
  final Map<String, dynamic>? product;
  @JsonKey(ignore: true)
  ProductHistory? productObject;

  ProductInMenuHistory({
    required this.menuID,
    required this.productID,
    required this.quantity,
    required this.price,
    required this.product,
    this.productObject,
  }) {
    if (product != null && productObject == null) {
      productObject = ProductHistory.fromJson(product!);
    }
  }

  factory ProductInMenuHistory.fromJson(Map<String, dynamic> json) =>
      _$ProductInMenuHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$ProductInMenuHistoryToJson(this);

  static String format({required double price}) =>
      NumberFormat.currency(locale: 'vi', symbol: '₫', decimalDigits: 0)
          .format(price);
}
