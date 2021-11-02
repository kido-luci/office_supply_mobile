import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/models/order_history/order_history.dart';
import 'package:office_supply_mobile_master/models/order_history_page/order_history_page.dart';

class OrderService {
  static const url = '/api/v1/orders';

  static OrderHistory parseOrderHistory(Map<String, dynamic> jsonData) =>
      OrderHistory.fromJson(jsonData);

  static Future<OrderHistory> postOrder({
    required Map jsonBody,
    required String jwtToken,
  }) async {
    final response = await http.post(
      Uri.parse(apiPath + url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwtToken,
      },
      body: jsonEncode(jsonBody),
    );
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> jsonDecode = json.decode(response.body);
        return compute(parseOrderHistory,
            jsonDecode['responseData'] as Map<String, dynamic>);
      default:
        throw Exception('Error ${response.statusCode}, cannot post order');
    }
  }

  static OrderHistoryPage parseOrderHistoryPage(
          Map<String, dynamic> jsonData) =>
      OrderHistoryPage.fromJson(jsonData);

  static Future<OrderHistoryPage> fetchOrderByUserId({
    required int userId,
    required String jwtToken,
  }) async {
    final response = await http.get(
      Uri.parse(apiPath +
          url +
          '?UserID=' +
          userId.toString() +
          '&PageSize=15&PageNumber=1'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwtToken,
      },
    );
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> jsonDecode = json.decode(response.body);
        return compute(parseOrderHistoryPage,
            jsonDecode['responseData'] as Map<String, dynamic>);
      default:
        throw Exception('Error ${response.statusCode}, cannot post order');
    }
  }
}
