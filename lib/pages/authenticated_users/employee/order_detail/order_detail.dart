import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/models/company/company.dart';
import 'package:office_supply_mobile_master/models/department/department.dart';
import 'package:office_supply_mobile_master/models/order_detail_history/order_detail_history.dart';
import 'package:office_supply_mobile_master/models/order_history/order_history.dart';
import 'package:office_supply_mobile_master/models/order_history_item/order_history_item.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/order_detail/widgets/order_item.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/order_detail/widgets/order_status.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/order_detail/widgets/top_navigation_bar.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:office_supply_mobile_master/services/order.dart';
import 'package:provider/provider.dart';

class OrderDetail extends StatefulWidget {
  final OrderHistory? orderHistory;
  final OrderHistoryItem? orderHistoryItem;
  final List<OrderDetailHistory> orderdetailHistory;
  final User userOrder;
  final Company company;
  final Department department;
  final VoidCallback? onTapBack;

  const OrderDetail({
    Key? key,
    required this.orderHistory,
    required this.orderHistoryItem,
    required this.orderdetailHistory,
    required this.userOrder,
    required this.company,
    required this.department,
    this.onTapBack,
  }) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  var totalPrice = 0.0;
  late OrderHistory tmp;
  late SignInProvider signInProvider;

  @override
  void initState() {
    signInProvider = Provider.of<SignInProvider>(context, listen: false);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      RemoteNotification? remoteNotification = remoteMessage.notification;
      AndroidNotification? androidNotification =
          remoteMessage.notification?.android;
      if (remoteNotification != null && androidNotification != null) {
        getOrder();
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? remoteNotification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if (remoteNotification != null && androidNotification != null) {
        getOrder();
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                titlePadding: EdgeInsets.zero,
                actionsPadding: EdgeInsets.zero,
                insetPadding: EdgeInsets.zero,
                buttonPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                content: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset.zero,
                        blurRadius: 3,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        color: primaryLightColor,
                        height: 40,
                        child: Text(
                          'Thông báo',
                          style: h5.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              remoteNotification.body!,
                              style: h5.copyWith(
                                fontStyle: FontStyle.italic,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 40,
                                width: 115,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      offset: Offset.zero,
                                      blurRadius: 3,
                                    )
                                  ],
                                ),
                                child: Text(
                                  'Ok',
                                  style: h5.copyWith(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      }
    });

    tmp = widget.orderHistory ??
        OrderHistory(
          approveTime: widget.orderHistoryItem!.approveTime,
          createTime:
              widget.orderHistoryItem!.createTime.add(const Duration(hours: 7)),
          id: widget.orderHistoryItem!.id,
          orderStatusID: widget.orderHistoryItem!.orderStatusID,
          userApprove: widget.orderHistoryItem!.userApprove,
          userApproveID: widget.orderHistoryItem!.userApproveID,
          userOrder: widget.orderHistoryItem!.userOrder,
          userOrderID: widget.orderHistoryItem!.userOrderID,
        );
    for (var e in widget.orderdetailHistory) {
      totalPrice += e.price * e.quantity;
    }
    switch (widget.userOrder.roleName) {
      case 'Admin':
        widget.userOrder.roleName = 'Quản trị viên';
        break;
      case 'Manager':
        widget.userOrder.roleName = 'Quản lý';
        break;
      case 'Leader':
        widget.userOrder.roleName = 'Trưởng phòng';
        break;
      case 'Employee':
        widget.userOrder.roleName = 'Nhân viên';
        break;
      default:
        widget.userOrder.roleName = 'Khách';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
              child: TopNavigationBar(),
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
                        widget.company.name,
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
                        'Phòng ban: ',
                        style: h6.copyWith(
                          color: Colors.black,
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.department.name,
                        style: h6.copyWith(
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Mã đơn hàng: ',
                        style: h6.copyWith(
                          color: Colors.black,
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '#' + tmp.id.toString(),
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
                        widget.userOrder.firstname +
                            ' ' +
                            widget.userOrder.lastname,
                        style: h6.copyWith(
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                      Text(
                        ' (' + widget.userOrder.roleName + ')',
                        style: h6.copyWith(
                          color: lightGrey,
                          height: 1.5,
                          fontStyle: FontStyle.italic,
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
            //!orderstatus
            tmp.orderStatusID == 4
                ? Center(
                    child: Text(
                      'Đã huỷ đơn hàng',
                      style: h4.copyWith(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  )
                : OrderStatus(
                    doneStep: tmp.orderStatusID == 3 ? 4 : tmp.orderStatusID,
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15),
              child: Text(
                'Sản phẩm',
                style: h5.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView(
                children: widget.orderdetailHistory
                    .asMap()
                    .entries
                    .map(
                      (e) => OrderItem(
                        orderDetailHistory: e.value,
                        isCancelCheckOut: tmp.orderStatusID == 4,
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
                  DateFormat('kk:mm - dd/MM/yyyy').format(
                    tmp.createTime.add(
                      const Duration(hours: 0),
                    ),
                  ),
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
                  ProductInMenu.format(price: totalPrice),
                  style: h4.copyWith(
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                    decoration: tmp.orderStatusID == 4
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      );

  getOrder() async {
    await OrderService.getOrder(
            jwtToken: signInProvider.auth!.jwtToken, orderId: tmp.id)
        .then((e) {
      setState(() {
        tmp.orderStatusID = e.orderStatusID;
        tmp.approveTime = e.approveTime;
        tmp.userApproveID = e.userApproveID;
        tmp.userApprove = e.userApprove;
      });
    });
  }
}
