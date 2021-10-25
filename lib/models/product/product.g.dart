// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      categoryID: json['categoryID'] as int,
      supplierID: json['supplierID'] as int,
      category: json['category'] as String?,
      isDelete: json['isDelete'] as bool,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
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
