// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/models/order/orderDTO.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/manager/managerBottomNav.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/manager/provider/orderProvide.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/manager/provider/period_provide.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:office_supply_mobile_master/services/order.dart';
import 'package:provider/provider.dart';

class ListOrderRequest extends StatelessWidget {
  const ListOrderRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userInfo = context.watch<SignInProvider>().user!;
    var jwtToken = context.watch<SignInProvider>().auth!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Request'),
        backgroundColor: Colors.indigo[400],
      ),
      backgroundColor: Colors.indigo[100],
      body: FutureBuilder<List<OrderDTO>?>(
        future: OrderService.getOrders(
            jwtToken: jwtToken.jwtToken, userId: userInfo.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: createOrderList(context, snapshot.data),
            );
          } else {
            return Center(child: Text('No Data'));
          }
        },
      ),
      bottomNavigationBar: ManagerBottomNav(),
    );
  }

  List<Widget> createOrderList(BuildContext context, List<OrderDTO>? data) {
    List<Widget> list = List.empty(growable: true);
    var jwtToken = context.watch<SignInProvider>().auth!;

    for (var o in data!) {
      var item = InkWell(
        onTap: () async {
          await context
              .read<OrderProvider>()
              .changeStatusOrderSelected(orderStatus: o.orderStatusID);
          await context.read<PeriodProvider>().getPeriodOfDepartment(
              jwtToken.jwtToken, o.userApprove.departmentID!);
          await context
              .read<OrderProvider>()
              .getOrderDetails(orderId: o.id, jwtToken: jwtToken.jwtToken);
          Navigator.of(context).pushReplacementNamed('/order_request_detail');
        },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('ID: ' + p.id.toString()),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.account_circle_rounded),
                      ),
                      Text(
                        'Order By:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '${o.userOrder.firstname} ${o.userOrder.lastname}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.account_circle_rounded),
                      ),
                      Text(
                        'Approve by:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '${o.userApprove.firstname} ${o.userApprove.lastname}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.schedule_outlined),
                      ),
                      Text(
                        'Order Time:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '${o.createTime.year}-${o.createTime.month}-${o.createTime.day}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.schedule_outlined),
                      ),
                      Text(
                        'Approve Time:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '${o.approveTime!.year}-${o.approveTime!.month}-${o.approveTime!.day}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.task_alt_rounded),
                      ),
                      Text(
                        'Status:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          getTextStatusById(o.orderStatusID),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      list.add(item);
    }

    return list;
  }

  String getTextStatusById(int statusId) {
    switch (statusId) {
      case 2:
        return 'Leader Approve';
      case 3:
        return 'Manager Approve';
      case 4:
        return 'Cancel';
      default:
        return '';
    }
  }
}
