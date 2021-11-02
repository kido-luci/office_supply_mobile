// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'dart:io';
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

    print(res.statusCode);
    if (res.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(res.body);
      print(jsonData);
      return jsonData;
    } else if (res.statusCode == 400) {
      Map<String, dynamic> jsonData = json.decode(res.body);
      return jsonData;
    }
  }
}
