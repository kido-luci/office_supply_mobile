// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:office_supply_mobile_master/models/order_detail_history/order_detail_history.dart';
import 'package:office_supply_mobile_master/services/order_detail.dart';

class OrderProvider with ChangeNotifier {
  late List<OrderDetailHistory> orderDetails;

  getOrderDetails({
    required int orderId,
    required String jwtToken,
  }) async {
    orderDetails = await OrderDetailService.fetchOrderDetail(jwtToken: jwtToken, orderId: orderId);
    notifyListeners();
  }
}
