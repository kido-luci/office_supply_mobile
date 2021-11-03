import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/models/auth/auth.dart';

class AuthService {
  static const url = '/api/v1/auth/token';

  static Auth parseAuth(String responseBody) =>
      Auth.fromJson(json.decode(responseBody));

  static Future<Auth> fetchAuth({
    required String idToken,
    required VoidCallback signOut,
    required String regisToken,
  }) async {
    final response = await http.post(
      Uri.parse(apiPath + url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'idToken': idToken,
        'regisToken': regisToken,
      }),
    );
    switch (response.statusCode) {
      case 200:
        return compute(parseAuth, response.body);
      default:
        signOut.call();
        throw Exception('Error ${response.statusCode}, cannot get auth');
    }
  }
}
