import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:office_supply_mobile_master/models/auth.dart';

class AuthAPI {
  //static const url = 'https://172.16.1.220/api/v1/auth/token';
  static const url = 'https://officesupplier.software/api/v1/auth/token';

  static Auth parseAuth(String responseBody) {
    var jsons = json.decode(responseBody);
    final auth = Auth.fromJson(jsons);
    return auth;
  }

  static Future<Auth> fetchAuth({
    //required http.Client client,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'idToken': idToken}),
    );
    // ignore: avoid_print
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        return compute(parseAuth, response.body);
      //return parsePost(response.body);
      // case 404:
      //   throw Exception('Not Found');
      // case 400:
      //   throw Exception('Invalid Id token');
      default:
        throw Exception('Cannot get auth');
    }
  }
}
