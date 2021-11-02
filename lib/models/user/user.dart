import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final int id;
  final String firstname;
  final String lastname;
  final DateTime? dateOfBirth;
  final bool? isMale;
  final String? phoneNumber;
  final String email;
  final String? address;
  final String avatarUrl;
  final int? departmentID;
  final int? companyID;
  final int? menuID;
  final int roleID;
  final bool isDelete;
  @JsonKey(ignore: true)
  late String roleName;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.isMale,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.avatarUrl,
    required this.departmentID,
    required this.companyID,
    required this.menuID,
    required this.roleID,
    required this.isDelete,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
