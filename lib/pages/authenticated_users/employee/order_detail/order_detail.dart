import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/controllers/cart_controller.dart';
import 'package:office_supply_mobile_master/models/item.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/order_detail/widgets/order_item.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/order_detail/widgets/order_status.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/order_detail/widgets/top_navigation_bar.dart';
import 'package:provider/provider.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                child: TopNavigationBar(onTapBack: () {
                  setState(() {});
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
                child: Text(
                  'Chi tiết đơn hàng',
                  style: h5.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Công ty: TNHH một thành viên ABC',
                      style: h6.copyWith(color: Colors.black, height: 1.5),
                    ),
                    Text(
                      'Người đặt hàng: Tiêu Trung Lập',
                      style: h6.copyWith(color: Colors.black, height: 1.5),
                    ),
                    Text(
                      'Chức vụ: Nhân viên',
                      style: h6.copyWith(color: Colors.black, height: 1.5),
                    ),
                    Text(
                      'Số tiền thanh toán: ${Item.format(price: 165000)}',
                      style: h6.copyWith(color: Colors.black, height: 1.5),
                    ),
                    Text(
                      'Thời gian đặt hàng: 15:17 14/10/2021',
                      style: h6.copyWith(color: Colors.black, height: 1.5),
                    ),
                    Text(
                      'Mã đơn hàng: ABC123xyz',
                      style: h6.copyWith(color: Colors.black, height: 1.5),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
                child: Text(
                  'Trạng thái đơn hàng',
                  style: h5.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const OrderStatus(),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15),
                child: Text(
                  'Sản phẩm',
                  style: h5.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  children: Provider.of<CartController>(context, listen: false)
                      .cart
                      .cartItems
                      .entries
                      .map(
                        (e) => OrderItem(
                          item: e.value,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
}
