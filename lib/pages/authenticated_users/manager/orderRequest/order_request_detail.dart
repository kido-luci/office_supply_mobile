import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/models/order/orderDTO.dart';
import 'package:office_supply_mobile_master/models/order/orderUpdatePayload.dart';
import 'package:office_supply_mobile_master/models/order_detail_history/order_detail_history.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/manager/orderRequest/order_status.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/manager/orderRequest/top_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/manager/provider/orderProvide.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/manager/provider/period_provide.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:office_supply_mobile_master/services/order.dart';
import 'package:provider/provider.dart';

class OrderRequestDetail extends StatefulWidget {
  const OrderRequestDetail({Key? key, required this.orderDTO})
      : super(key: key);
  final OrderDTO orderDTO;

  @override
  State<OrderRequestDetail> createState() => _OrderRequestDetailState();
}

class _OrderRequestDetailState extends State<OrderRequestDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final signInProvider = Provider.of<SignInProvider>(context, listen: false);

    var userInfo = signInProvider.user!;
    var periodOfDepartment = context.watch<PeriodProvider>().periodOfDepartment;
    var orderDetails = context.watch<OrderProvider>().orderDetails;
    var jwtToken = signInProvider.auth!;
    var statusOrderSelected =
        context.watch<OrderProvider>().statusOrderSelected;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
            child: TopNavigationBar(onTapBack: () {}),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
            child: Text(
              'Chi tiết đơn hàng',
              style: h5.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      'From Time: ${periodOfDepartment.fromTime.year}/${periodOfDepartment.fromTime.month}/${periodOfDepartment.fromTime.day} ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      'To Time: ${periodOfDepartment.toTime.year}/${periodOfDepartment.toTime.month}/${periodOfDepartment.toTime.day}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      'Quota: ${periodOfDepartment.quota} VNĐ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      'Remaining Quota: ${periodOfDepartment.remainingQuota} VNĐ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
            child: Text(
              'Trạng thái đơn hàng',
              style: h5.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          //!orderstatus
          widget.orderDTO.orderStatusID == 4
              ? Center(
                  child: Text(
                    'Đã huỷ đơn hàng',
                    style: h4.copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              : OrderStatus(
                  doneStep: widget.orderDTO.orderStatusID == 3
                      ? 4
                      : widget.orderDTO.orderStatusID,
                ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: Text(
              'Sản phẩm',
              style: h5.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: generateCart(context, orderDetails),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (statusOrderSelected == 3 ||
                              statusOrderSelected == 4) {
                            Fluttertoast.showToast(
                                msg: 'Cannot perform this action',
                                fontSize: 18,
                                gravity: ToastGravity.CENTER);
                          } else {
                            var oup = OrderUpdatePayload(
                                userApproveID: userInfo.id,
                                orderID: orderDetails[0].orderID,
                                description: '',
                                isApprove: true);

                            var result = await OrderService.updateOrder(
                                jwtToken: jwtToken.jwtToken, oup: oup);

                            if (result!) {
                              Fluttertoast.showToast(
                                  msg: 'Approve success',
                                  fontSize: 18,
                                  gravity: ToastGravity.CENTER);
                              Navigator.of(context)
                                  .pushReplacementNamed('/list_order');
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Server error, please try again',
                                  fontSize: 18,
                                  gravity: ToastGravity.CENTER);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 50),
                        ),
                        child: Text('Accept'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          TextEditingController txtReason =
                              TextEditingController();

                          if (statusOrderSelected == 3 ||
                              statusOrderSelected == 4) {
                            Fluttertoast.showToast(
                                msg: 'Cannot perform this action',
                                fontSize: 18,
                                gravity: ToastGravity.CENTER);
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Reason for reject'),
                                  content: TextFormField(
                                    controller: txtReason,
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red[600],
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        var oup = OrderUpdatePayload(
                                            userApproveID: userInfo.id,
                                            orderID: orderDetails[0].orderID,
                                            description:
                                                txtReason.text.toString(),
                                            isApprove: false);

                                        var result =
                                            await OrderService.updateOrder(
                                                jwtToken: jwtToken.jwtToken,
                                                oup: oup);

                                        if (result!) {
                                          Fluttertoast.showToast(
                                              msg: 'Cancel this order request',
                                              fontSize: 18,
                                              gravity: ToastGravity.CENTER);
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  '/list_order');
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  'Server error, please try again',
                                              fontSize: 18,
                                              gravity: ToastGravity.CENTER);
                                        }
                                      },
                                      child: Text('Ok'),
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 50),
                        ),
                        child: Text('Reject'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> generateCart(
      BuildContext context, List<OrderDetailHistory> orderDetails) {
    List<Widget> list = List.empty(growable: true);
    double totalPrice = 0;

    for (var o in orderDetails) {
      totalPrice += (o.quantity * o.price);
      var row = Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset.zero,
              blurRadius: 3,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(20)),
              child: Image.network(
                o.productInMenuObject.productObject!.imageUrl,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    o.productInMenuObject.productObject!.name,
                    style: h6.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    'Loại: ' +
                        o.productInMenuObject.productObject!.categoryObject
                            .name,
                    style: h6.copyWith(color: lightGrey, height: 1.5),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Số lượng: ${o.quantity < 10 ? '0' + o.quantity.toString() : o.quantity.toString()}',
                    style: h6.copyWith(
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    ProductInMenu.format(price: o.quantity * o.price),
                    style: h6.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                      decoration: //isCancelCheckOut
                          false
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
      // var row1 = Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(15),
      //     color: Colors.grey[300],
      //   ),
      //   child: Row(
      //     children: [
      //       Image.network(o.productInMenuObject.productObject!.imageUrl),
      //       SizedBox(width: 20),
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(
      //             o.productInMenuObject.productObject!.name,
      //             style: TextStyle(color: Colors.black, fontSize: 16),
      //             maxLines: 2,
      //           ),
      //           SizedBox(height: 10),
      //           Text.rich(
      //             TextSpan(
      //               text: "\$${o.price}",
      //               style: TextStyle(
      //                   fontWeight: FontWeight.w600, color: Color(0xFFFF7643)),
      //               children: [
      //                 TextSpan(
      //                     text: " x${o.quantity}",
      //                     style: Theme.of(context).textTheme.bodyText1),
      //               ],
      //             ),
      //           )
      //         ],
      //       )
      //     ],
      //   ),
      // );

      var sizedBox = SizedBox(
        height: 10,
      );

      list.add(row);
      list.add(sizedBox);
    }

    var titleTotal = FlatButton(
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Color(0xFFF5F6F9),
      onPressed: () {},
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  'Total Price: $totalPrice',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    list.add(titleTotal);

    return list;
  }
}
