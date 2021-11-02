import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';
import 'package:office_supply_mobile_master/models/user/userUpdatePayload.dart';

class UserService {
  static const url = '/api/v1/users';
  static const api = apiPath + url;

  static User parseUser(Map<String, dynamic> jsonData) =>
      User.fromJson(jsonData);

  static Future<User> fetchUser({
    required int id,
    required String jwtToken,
  }) async {
    final response = await http.get(
      Uri.parse(apiPath + url + '/' + id.toString()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwtToken,
      },
    );
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> jsonDecode = json.decode(response.body);
        return compute(
            parseUser, jsonDecode['responseData'] as Map<String, dynamic>);
      default:
        throw Exception('Error ${response.statusCode}, cannot get user');
    }
  }

  static Future<bool?> updateUserInfo(
      {required int userId,
      required String jwtToken,
      required UserUpdatePayload userPayload}) async {
    final res = await http.put(
      Uri.parse('$api/$userId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + jwtToken,
        'Content-type': 'application/json',
      },
      body: userPayload.toJson(),
    );

    if (res.statusCode == 204) {
      return true;
    }
  }
}
