import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/models/department/department.dart';

class DepartmentAPI {
  static const url = '/api/v1/departments';

  static Department parseDepartment(Map<String, dynamic> jsonData) {
    //print('test');
    var department = Department.fromJson(jsonData);
    //print('name : ' + department.name);
    return department;
  }

  static Future<Department> fetchDepartment({
    required int id,
    required String jwtToken,
  }) async {
    //print(apiPath + url + '/' + id.toString());
    final response = await http.get(
      Uri.parse(apiPath + url + '/' + id.toString()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwtToken,
      },
    );
    //print('code: ' + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        //print(json.decode(response.body));
        Map<String, dynamic> jsonDecode = json.decode(response.body);
        return compute(parseDepartment,
            jsonDecode['responseData'] as Map<String, dynamic>);
      default:
        throw Exception('Error ${response.statusCode}, cannot get department');
    }
  }
}
