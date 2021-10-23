import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                padding: const EdgeInsets.only(top: 10, bottom: 0, left: 15),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Công ty: ',
                          style: h6.copyWith(
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'TNHH một thành viên ABC',
                          style: h6.copyWith(
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Người đặt hàng: ',
                          style: h6.copyWith(
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Tiêu Trung Lập',
                          style: h6.copyWith(
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                        Text(
                          ' (nhân viên)',
                          style: h6.copyWith(
                            color: lightGrey,
                            height: 1.5,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Mã đơn hàng: ',
                          style: h6.copyWith(
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Axbc1QQE',
                          style: h6.copyWith(
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                      ],
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
              const Expanded(flex: 1, child: OrderStatus()),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Thời gian đặt hàng: ',
                    style: h6.copyWith(
                      color: Colors.black,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('kk:mm - dd/MM/yyyy').format(DateTime.now()),
                    style: h6.copyWith(
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Số tiền thanh toán:',
                    style: h6.copyWith(
                      color: Colors.black,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    Item.format(
                        price:
                            Provider.of<CartController>(context, listen: false)
                                .cart
                                .totalPrice),
                    style: h4.copyWith(
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      );
}
