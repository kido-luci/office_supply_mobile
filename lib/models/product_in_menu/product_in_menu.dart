import 'package:office_supply_mobile_master/models/product/product.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_in_menu.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductInMenu {
  final int menuID;
  final int productID;
  final int quantity;
  final double price;
  final Map<String, dynamic>? product;
  @JsonKey(ignore: true)
  Product? productObject;

  ProductInMenu({
    required this.menuID,
    required this.productID,
    required this.quantity,
    required this.price,
    required this.product,
  }) {
    if (product != null) {
      productObject = Product.fromJson(product!);
    }
  }

  factory ProductInMenu.fromJson(Map<String, dynamic> json) =>
      _$ProductInMenuFromJson(json);
  Map<String, dynamic> toJson() => _$ProductInMenuToJson(this);
}
