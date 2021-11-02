import 'package:json_annotation/json_annotation.dart';
part 'order_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDetail {
  final int productID;
  final int menuID;
  int quantity;
  double price;

  OrderDetail(
      {required this.productID,
      required this.menuID,
      required this.quantity,
      required this.price});

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);

  Map toJson() => _$OrderDetailToJson(this);
}
