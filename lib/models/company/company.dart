import 'package:json_annotation/json_annotation.dart';
part 'company.g.dart';

@JsonSerializable(explicitToJson: true)
class Company {
  final int id;
  final String name;
  final double wallet;
  final String address;
  final String phoneNumber;
  final String email;
  final int areaID;
  final int managerID;
  final bool? isDelete;

  Company({
    required this.id,
    required this.name,
    required this.wallet,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.areaID,
    required this.managerID,
    required this.isDelete,
  });

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
