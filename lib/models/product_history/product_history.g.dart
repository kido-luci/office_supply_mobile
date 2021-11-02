// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductHistory _$ProductHistoryFromJson(Map<String, dynamic> json) =>
    ProductHistory(
      id: json['id'] as int,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      categoryID: json['categoryID'] as int,
      supplierID: json['supplierID'] as int,
      category: json['category'] as Map<String, dynamic>,
      isDelete: json['isDelete'] as bool,
    );

Map<String, dynamic> _$ProductHistoryToJson(ProductHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'categoryID': instance.categoryID,
      'supplierID': instance.supplierID,
      'category': instance.category,
      'isDelete': instance.isDelete,
    };
