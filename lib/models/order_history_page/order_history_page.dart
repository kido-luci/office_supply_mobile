import 'package:office_supply_mobile_master/models/order_history_item/order_history_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_history_page.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderHistoryPage {
  final int currentPage;
  final int totalPage;
  final int pageSize;
  final int totalCount;
  final List<dynamic>? items;
  @JsonKey(ignore: true)
  List<OrderHistoryItem>? itemsObject;

  OrderHistoryPage({
    required this.currentPage,
    required this.totalPage,
    required this.pageSize,
    required this.totalCount,
    required this.items,
  }) {
    itemsObject = List.empty(growable: true);
    for (var e in items!) {
      itemsObject!.add(
        OrderHistoryItem.fromJson(e as Map<String, dynamic>),
      );
    }
  }

  factory OrderHistoryPage.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryPageFromJson(json);

  Map<String, dynamic> toJson() => _$OrderHistoryPageToJson(this);
}
