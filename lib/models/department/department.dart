import 'package:json_annotation/json_annotation.dart';
part 'department.g.dart';

@JsonSerializable(explicitToJson: true)
class Department {
  final int id;
  final String name;
  final String phoneNumber;
  final String email;
  final int companyID;
  final bool? isDelete;

  Department({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.companyID,
    required this.isDelete,
  });

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);
  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}
