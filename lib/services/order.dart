import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/models/order/orderDTO.dart';
import 'package:office_supply_mobile_master/models/order/orderUpdatePayload.dart';
import 'package:office_supply_mobile_master/models/order_history/order_history.dart';
import 'package:office_supply_mobile_master/models/order_history_page/order_history_page.dart';

class OrderService {
  static const url = '/api/v1/orders';
  static const api = apiPath + url;

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

  static Future<OrderHistory> getOrder({
    required int orderId,
    required String jwtToken,
  }) async {
    final response = await http.get(
      Uri.parse(apiPath + url + '/' + orderId.toString()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwtToken,
      },
    );
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> jsonDecode = json.decode(response.body);
        return compute(parseOrderHistory,
            jsonDecode['responseData'] as Map<String, dynamic>);
      default:
        throw Exception('Error ${response.statusCode}, cannot get order');
    }
  }

  static Future<List<OrderDTO>?> getOrders({
    required String jwtToken,
    required int userId,
  }) async {
    final res = await http.get(
      Uri.parse('$api?userID=$userId&orderBy=id desc'),
      headers: {
        // 'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwtToken,
      },
    );

    if (res.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(res.body);
      final responseData = jsonData['responseData'] as Map<String, dynamic>;
      final items = responseData['items'] as List;

      List<OrderDTO> data = List.empty(growable: true);
      for (var item in items) {
        var orderDTOMap = item as Map<String, dynamic>;
        var orderDTO = OrderDTO.fromJson(orderDTOMap);
        data.add(orderDTO);
      }

      return data;
    }
  }

  static Future<bool?> updateOrder({
    required String jwtToken,
    required OrderUpdatePayload oup,
  }) async {
    final res = await http.put(
      Uri.parse(api),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwtToken,
      },
      body: oup.toJson(),
    );

    if (res.statusCode == 204) {
      return true;
    } else if (res.statusCode == 500) {
      return false;
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
          '&PageSize=1000&PageNumber=1&orderBy=id desc'),
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
