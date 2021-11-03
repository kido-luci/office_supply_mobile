// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryPage _$OrderHistoryPageFromJson(Map<String, dynamic> json) =>
    OrderHistoryPage(
      currentPage: json['currentPage'] as int,
      totalPage: json['totalPage'] as int,
      pageSize: json['pageSize'] as int,
      totalCount: json['totalCount'] as int,
      items: json['items'] as List<dynamic>?,
    );

Map<String, dynamic> _$OrderHistoryPageToJson(OrderHistoryPage instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPage': instance.totalPage,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'items': instance.items,
    };
