import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:office_supply_mobile_master/models/auth/auth.dart';

class AuthAPI {
  static const url = 'https://officesupplier.software/api/v1/auth/token';

  static Auth parseAuth(String responseBody) {
    var jsons = json.decode(responseBody);
    final auth = Auth.fromJson(jsons);
    return auth;
  }

  static Future<Auth> fetchAuth(
      {required String idToken, required VoidCallback signOut}) async {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'idToken': idToken}),
    );
    switch (response.statusCode) {
      case 200:
        return compute(parseAuth, response.body);
      default:
        signOut.call();
        throw Exception('Cannot get auth');
    }
  }
}
