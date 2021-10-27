import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';
import 'package:json_annotation/json_annotation.dart';

part 'items_page.g.dart';

@JsonSerializable(explicitToJson: true)
class ItemsPage {
  final int currentPage;
  final int totalPage;
  final int pageSize;
  final int totalCount;
  final List<dynamic>? items;
  @JsonKey(ignore: true)
  List<ProductInMenu>? itemsObject;

  ItemsPage({
    required this.currentPage,
    required this.totalPage,
    required this.pageSize,
    required this.totalCount,
    required this.items,
  }) {
    if (items != null && itemsObject == null) {
      itemsObject = List.empty(growable: true);
      for (var e in items!) {
        itemsObject!.add(
          ProductInMenu.fromJson(e as Map<String, dynamic>),
        );
      }
    }
  }

  factory ItemsPage.fromJson(Map<String, dynamic> json) =>
      _$ItemsPageFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsPageToJson(this);
}
