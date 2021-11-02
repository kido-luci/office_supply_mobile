import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:office_supply_mobile_master/models/category/category.dart';
part 'product_history.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductHistory {
  final int id;
  final String name;
  final int quantity;
  final double price;
  final String imageUrl;
  final int categoryID;
  final int supplierID;
  final Map<String, dynamic> category;
  @JsonKey(ignore: true)
  late Category categoryObject;
  final bool isDelete;

  ProductHistory({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
    required this.categoryID,
    required this.supplierID,
    required this.category,
    required this.isDelete,
  }) {
    categoryObject = Category.fromJson(category);
  }

  factory ProductHistory.fromJson(Map<String, dynamic> json) =>
      _$ProductHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$ProductHistoryToJson(this);

  static String format({required double price}) =>
      NumberFormat.currency(locale: 'vi', symbol: '₫', decimalDigits: 0)
          .format(price);
}
