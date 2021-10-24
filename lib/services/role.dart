import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/models/role/role.dart';

class RoleAPI {
  static const url = '/api/v1/roles';

  static Role parseRole(Map<String, dynamic> jsonData) =>
      Role.fromJson(jsonData);

  static Future<Role> fetchRole({
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
            parseRole, jsonDecode['responseData'] as Map<String, dynamic>);
      default:
        throw Exception('Error ${response.statusCode}, cannot get role');
    }
  }
}
