import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/models/items_page/items_page.dart';

class ProductService {
  static const url = '/api/v1/products';

  static ItemsPage parseItemsPage(Map<String, dynamic> jsonData) =>
      ItemsPage.fromJson(jsonData);

  static Future<ItemsPage> fetchItemsPage({
    required int id,
    required String jwtToken,
    required String search,
  }) async {
    final response = await http.get(
      (search == "")
          ? Uri.parse(apiPath + url + '?' + 'UserID=' + id.toString())
          : Uri.parse(apiPath +
              url +
              '?' +
              'UserID=' +
              id.toString() +
              '&Name=' +
              search),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwtToken,
      },
    );
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> jsonDecode = json.decode(response.body);
        return compute(
            parseItemsPage, jsonDecode['responseData'] as Map<String, dynamic>);
      default:
        throw Exception('Error ${response.statusCode}, cannot get items page');
    }
  }
}
