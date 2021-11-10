import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/models/department/department.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';
import 'package:office_supply_mobile_master/services/user.dart';

class DepartmentService {
  static const url = '/api/v1/departments';

  static Department parseDepartment(Map<String, dynamic> jsonData) =>
      Department.fromJson(jsonData);

  static Future<Department> fetchDepartment({
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
        return compute(parseDepartment,
            jsonDecode['responseData'] as Map<String, dynamic>);
      default:
        throw Exception('Error ${response.statusCode}, cannot get department');
    }
  }

  static Future<List<Department>?> getDepartments({
    required String jwtToken,
    required int userID,
    required bool all,
  }) async {
    String api = apiPath + url + '?userID=$userID&all=$all';

    final res = await http.get(Uri.parse(api), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + jwtToken,
    });

    if (res.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(res.body);
      final responseData = jsonData['responseData'] as List;

      List<Department> data = List.empty(growable: true);
      for (var item in responseData) {
        var departmentMap = item as Map<String, dynamic>;
        var departments = Department.fromJson(departmentMap);
        data.add(departments);
      }

      return data;
    }
  }

  static Future<List<User>> fetchDepartmentUser({
    required int depathmentId,
    required String jwtToken,
  }) async {
    final response = await http.get(
      Uri.parse('$apiPath$url/$depathmentId/users?PageSize=100'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwtToken,
      },
    );
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> jsonDecode = json.decode(response.body);
        Map<String, dynamic> responseData =
            jsonDecode['responseData'] as Map<String, dynamic>;
        List<dynamic> items = responseData['items'] as List<dynamic>;
        List<User> users = List.empty(growable: true);

        await Future.forEach(
          items,
          (e) async =>
              await compute(UserService.parseUser, e as Map<String, dynamic>)
                  .then(
            (e) => users.add(e),
          ),
        ).then((_) {
          //return users;
        });
        return users;
      default:
        throw Exception('Error ${response.statusCode}, cannot get department');
    }
  }
}
