import 'dart:convert';
import 'dart:io';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:http/http.dart' as http;
import 'package:office_supply_mobile_master/models/period/period.dart';

class PeriodService {
  static const url = '/api/v1/periods';
  static const api = apiPath + url;

  static Future<List<Period>?> getPeriodOfCompany({
    required int? companyId,
    required String jwtToken,
  }) async {
    final res = await http
        .get(Uri.parse(api + '?CompanyID=' + companyId.toString()), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + jwtToken,
    });

    // http.Request req = http.Request('GET', Uri.parse(api));     // initiate an http request
    // req.body= 'data request';                                   // set body data request
    // req.headers;                                                // get header
    // req.contentLength=256;                                      // set content length
    // req.send();                                                 // send request

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
      return data;
    }
  }
}
