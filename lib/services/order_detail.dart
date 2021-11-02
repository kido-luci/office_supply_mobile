import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/models/order_detail_history/order_detail_history.dart';

class OrderDetailService {
  static const url = '/api/v1/orderdetails';

  static OrderDetailHistory parseOrderDetailHistory(
          Map<String, dynamic> jsonData) =>
      OrderDetailHistory.fromJson(jsonData);

  static Future<List<OrderDetailHistory>> fetchOrderDetail({
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
        List<OrderDetailHistory> orderDetailHistory =
            List.empty(growable: true);
        Map<String, dynamic> jsonDecode = json.decode(response.body);
        var responseData = jsonDecode['responseData'] as List<dynamic>;
        for (var e in responseData) {
          orderDetailHistory.add(parseOrderDetailHistory(e));
        }
        return orderDetailHistory;
      default:
        throw Exception('Error ${response.statusCode}, cannot get items page');
    }
  }
}
