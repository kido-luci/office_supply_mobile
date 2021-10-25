// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemsPage _$ItemsPageFromJson(Map<String, dynamic> json) => ItemsPage(
      currentPage: json['currentPage'] as int,
      totalPage: json['totalPage'] as int,
      pageSize: json['pageSize'] as int,
      totalCount: json['totalCount'] as int,
      items: json['items'] as List<dynamic>?,
    );

Map<String, dynamic> _$ItemsPageToJson(ItemsPage instance) => <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPage': instance.totalPage,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'items': instance.items,
    };
