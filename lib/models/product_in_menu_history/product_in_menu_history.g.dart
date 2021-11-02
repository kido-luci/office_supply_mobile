// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_in_menu_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductInMenuHistory _$ProductInMenuHistoryFromJson(
        Map<String, dynamic> json) =>
    ProductInMenuHistory(
      menuID: json['menuID'] as int,
      productID: json['productID'] as int,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      product: json['product'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ProductInMenuHistoryToJson(
        ProductInMenuHistory instance) =>
    <String, dynamic>{
      'menuID': instance.menuID,
      'productID': instance.productID,
      'quantity': instance.quantity,
      'price': instance.price,
      'product': instance.product,
    };
