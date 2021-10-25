import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable(explicitToJson: true)
class Category {
  final int id;
  final String name;
  final String? description;
  final bool? isDelete;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.isDelete,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
