// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailHistory _$OrderDetailHistoryFromJson(Map<String, dynamic> json) =>
    OrderDetailHistory(
      orderID: json['orderID'] as int,
      productID: json['productID'] as int,
      menuID: json['menuID'] as int,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      productInMenu: json['productInMenu'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$OrderDetailHistoryToJson(OrderDetailHistory instance) =>
    <String, dynamic>{
      'orderID': instance.orderID,
      'productID': instance.productID,
      'menuID': instance.menuID,
      'quantity': instance.quantity,
      'price': instance.price,
      'productInMenu': instance.productInMenu,
    };
