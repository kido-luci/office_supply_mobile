import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {
  final int id;
  final String name;
  final int quantity;
  final double price;
  final String imageUrl;
  final int categoryID;
  final int supplierID;
  final String? category;
  final bool isDelete;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
    required this.categoryID,
    required this.supplierID,
    required this.category,
    required this.isDelete,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
