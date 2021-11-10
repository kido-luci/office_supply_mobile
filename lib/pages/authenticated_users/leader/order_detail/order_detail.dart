import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/models/company/company.dart';
import 'package:office_supply_mobile_master/models/department/department.dart';
import 'package:office_supply_mobile_master/models/order/orderUpdatePayload.dart';
import 'package:office_supply_mobile_master/models/order_detail_history/order_detail_history.dart';
import 'package:office_supply_mobile_master/models/order_history/order_history.dart';
import 'package:office_supply_mobile_master/models/order_history_item/order_history_item.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/order_detail/widgets/order_item.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/order_detail/widgets/order_status.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/order_detail/widgets/top_navigation_bar.dart';
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
  late SignInProvider signInProvider;
  late OrderHistoryItem tmp;

  @override
  void initState() {
    signInProvider = Provider.of<SignInProvider>(context, listen: false);
    tmp = widget.orderHistoryItem ??
        OrderHistoryItem(
          approveTime: widget.orderHistory!.approveTime,
          createTime:
              widget.orderHistory!.createTime.add(const Duration(hours: 7)),
          id: widget.orderHistory!.id,
          orderStatusID: widget.orderHistory!.orderStatusID,
          userApprove: widget.orderHistory!.userApprove,
          userApproveID: widget.orderHistory!.userApproveID,
          userOrder: widget.orderHistory!.userOrder!,
          userOrderID: widget.orderHistory!.userOrderID,
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
            SizedBox(
              height: 80,
              child: TopNavigationBar(onTapBack: widget.onTapBack),
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
            Visibility(
              visible: tmp.orderStatusID == 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40,
                    width: 150,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFAD4444),
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
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          tmp.orderStatusID = 4;
                        });
                        await OrderService.updateOrder(
                          jwtToken: signInProvider.auth!.jwtToken,
                          oup: OrderUpdatePayload(
                            isApprove: false,
                            orderID: tmp.id,
                            userApproveID: signInProvider.user!.id,
                            description: '',
                          ),
                        );
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Huỷ đơn hàng',
                              style: h5.copyWith(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 150,
                    margin: const EdgeInsets.symmetric(vertical: 10),
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
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          tmp.orderStatusID = 2;
                        });
                        await OrderService.updateOrder(
                          jwtToken: signInProvider.auth!.jwtToken,
                          oup: OrderUpdatePayload(
                            isApprove: true,
                            orderID: tmp.id,
                            userApproveID: signInProvider.user!.id,
                            description: '',
                          ),
                        );
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Duyệt đơn hàng',
                              style: h5.copyWith(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
}
