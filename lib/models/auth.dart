import 'package:json_annotation/json_annotation.dart';
part 'auth.g.dart';

@JsonSerializable(explicitToJson: true)
class Auth {
  final int id;
  final String email;
  final String firstname;
  final String lastname;
  final String avatarUrl;
  final String jwtToken;

  Auth(
      {required this.id,
      required this.email,
      required this.firstname,
      required this.lastname,
      required this.avatarUrl,
      required this.jwtToken});

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
  Map<String, dynamic> toJson() => _$AuthToJson(this);
}
