import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:http/http.dart' as http;
import 'package:office_supply_mobile_master/models/period/period.dart';
import 'package:office_supply_mobile_master/models/period/periodPayload.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';

class PeriodService {
  static const url = '/api/v1/periods';
  static const api = apiPath + url;

  static Future<List<Period>?> getPeriodOfCompany({
    required User user,
    required String jwtToken,
  }) async {
    final res = await http.get(
        Uri.parse(api + '?CompanyID=' + user.companyID.toString()),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + jwtToken,
        });

    if (res.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(res.body);
      final responseData = jsonData['responseData'] as Map<String, dynamic>;
      final items = responseData['items'] as List;

      List<Period> data = List.empty(growable: true);
      for (var item in items) {
        var periodMap = item as Map<String, dynamic>;
        var period = Period.fromJson(periodMap);
        data.add(period);
      }

      // await DepartmentAPI.getDepartments(userID: user.id, jwtToken: jwtToken, all: true);
      return data;
    }
  }

  static Period parsePeriod(Map<String, dynamic> jsonData) =>
      Period.fromJson(jsonData);

  static Future<Period?> fetchPeriod({
    required int departmentId,
    required String jwtToken,
  }) async {
    final response = await http.get(
      Uri.parse(apiPath + url + '/department/' + departmentId.toString()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwtToken,
      },
    );
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> jsonDecode = json.decode(response.body);
        return compute(
            parsePeriod, jsonDecode['responseData'] as Map<String, dynamic>);
      default:
        throw Exception('Error ${response.statusCode}, cannot get period');
    }
  }

  static Future<Map<String, dynamic>?> createPeriod({
    required String jwtToken,
    required PeriodPayload periodPayload,
  }) async {
    final res = await http.post(
      Uri.parse(api),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + jwtToken,
        'Content-type': 'application/json',
      },
      body: periodPayload.toJson(),
    );

    if (res.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(res.body);
      return jsonData;
    } else if (res.statusCode == 400) {
      Map<String, dynamic> jsonData = json.decode(res.body);
      return jsonData;
    }
  }
}
