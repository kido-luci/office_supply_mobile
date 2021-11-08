import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/models/company/company.dart';
import 'package:office_supply_mobile_master/models/department/department.dart';
import 'package:office_supply_mobile_master/models/order_detail_history/order_detail_history.dart';
import 'package:office_supply_mobile_master/models/order_history_item/order_history_item.dart';
import 'package:office_supply_mobile_master/models/order_history_page/order_history_page.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/department_manager/widgets/category.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/department_manager/widgets/bottom_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/department_manager/widgets/order_history_item.dart'
    as order_history_item_ui;
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/order_detail/order_detail.dart'
    as order_detail_page;
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/department_manager/widgets/top_navigation_bar.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:office_supply_mobile_master/services/company.dart';
import 'package:office_supply_mobile_master/services/department.dart';
import 'package:office_supply_mobile_master/services/order.dart';
import 'package:office_supply_mobile_master/services/order_detail.dart';
import 'package:office_supply_mobile_master/services/period.dart';
import 'package:office_supply_mobile_master/services/role.dart';
import 'package:office_supply_mobile_master/services/user.dart';
import 'package:office_supply_mobile_master/widgets/loading_ui.dart';
import 'package:provider/provider.dart';

class DepartmentManager extends StatefulWidget {
  const DepartmentManager(
      {Key? key, this.firstselectedBarIndex = 0, this.firstOrderStatusId = 0})
      : super(key: key);
  final int firstselectedBarIndex;
  final int firstOrderStatusId;

  @override
  State<DepartmentManager> createState() => _DepartmentManagerState();
}

class _DepartmentManagerState extends State<DepartmentManager> {
  late SignInProvider signInProvider;
  bool isWattingGetOrderDetail = false;
  late int selectedOrderStatusId;
  late int selectedBarIndex;

  @override
  void initState() {
    super.initState();

    selectedBarIndex = widget.firstselectedBarIndex;
    selectedOrderStatusId = widget.firstOrderStatusId;
    signInProvider = Provider.of<SignInProvider>(context, listen: false);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? remoteNotification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if (remoteNotification != null && androidNotification != null) {
        reloadPeriod(signInProvider: signInProvider);
        setState(() {});
        // showDialog(
        //     context: context,
        //     builder: (_) {
        //       return AlertDialog(
        //         title: Text(remoteNotification.title!),
        //         content: Text(remoteNotification.body!),
        //       );
        //     });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 160,
                child: TopNavigationBar(
                  signInProvider: signInProvider,
                  selectedBarIndex: selectedBarIndex,
                  onTapIndexBar: ({required int selectedBarIndex}) => setState(
                    () => this.selectedBarIndex = selectedBarIndex,
                  ),
                ),
              ),
              selectedBarIndex == 0
                  ? Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Center(
                            child: Text(
                              'Phòng ban ' + signInProvider.department!.name,
                              style: h5.copyWith(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Kỳ hiện tại: ',
                                    style: h5.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                    children: [
                                      TextSpan(
                                        text: '#' +
                                            signInProvider.period!.id
                                                .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.italic),
                                      )
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Giới hạn kỳ: ',
                                    style: h5.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                    children: [
                                      TextSpan(
                                        text: ProductInMenu.format(
                                            price:
                                                signInProvider.period!.quota),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.italic),
                                      )
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Số tiền còn lại: ',
                                    style: h5.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                    children: [
                                      TextSpan(
                                        text: ProductInMenu.format(
                                            price: signInProvider
                                                .period!.remainingQuota),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.italic),
                                      )
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Thời hạn: ',
                                    style: h5.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                    children: [
                                      TextSpan(
                                        text: DateFormat('dd/MM/yyyy').format(
                                                signInProvider
                                                    .period!.fromTime) +
                                            ' - ' +
                                            DateFormat('dd/MM/yyyy').format(
                                                signInProvider.period!.toTime),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.italic),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Center(
                          //   child: Text(
                          //     'Thành viên phòng ban',
                          //     style: h5.copyWith(
                          //         fontSize: 20, fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  : Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CategogyCard(
                            categories: const [
                              'Tất \ncả',
                              'Chưa \nduyệt',
                              'Đã \nduyệt',
                              'Hoàn \nthành',
                              'Đã \nhuỷ',
                            ],
                            onTap: ({required int selectedCategoryId}) {
                              setState(() {
                                selectedOrderStatusId = selectedCategoryId;
                              });
                            },
                            selectedIndex: selectedOrderStatusId,
                          ),
                          Expanded(
                            flex: 1,
                            child: FutureBuilder<OrderHistoryPage>(
                              future: OrderService.fetchOrderByUserId(
                                  userId: signInProvider.user!.id,
                                  jwtToken: signInProvider.auth!.jwtToken),
                              builder: (context, snapshot) => snapshot.hasData
                                  ? ListView(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 50),
                                      children: snapshot.data!.itemsObject!
                                          .asMap()
                                          .entries
                                          .map((e) =>
                                              selectedOrderStatusId == 0 ||
                                                      e.value.orderStatusID ==
                                                          selectedOrderStatusId
                                                  ? order_history_item_ui
                                                      .OrderHistoryItem(
                                                      orderHistoryItem: e.value,
                                                      onTap: viewOrderDetail,
                                                    )
                                                  : const SizedBox.shrink())
                                          .toList())
                                  : const LoadingUI(),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigation(),
          ),
          Visibility(
            visible: isWattingGetOrderDetail,
            child: const LoadingUI(),
          )
        ],
      ),
    );
  }

  viewOrderDetail({required OrderHistoryItem orderHistoryItem}) async {
    setState(() {
      isWattingGetOrderDetail = true;
    });

    Department department = await DepartmentService.fetchDepartment(
      id: orderHistoryItem.userOrdrerObject.departmentID!,
      jwtToken: signInProvider.auth!.jwtToken,
    );

    User user = await UserService.fetchUser(
        id: orderHistoryItem.userOrderID,
        jwtToken: signInProvider.auth!.jwtToken);

    await RoleService.fetchRole(
      id: user.roleID,
      jwtToken: signInProvider.auth!.jwtToken,
    ).then((e) => user.roleName = e.name);

    Company company = await CompanyService.fetchCompany(
      id: user.companyID!,
      jwtToken: signInProvider.auth!.jwtToken,
    );

    List<OrderDetailHistory> orderDetailHistory =
        await OrderDetailService.fetchOrderDetail(
            orderId: orderHistoryItem.id,
            jwtToken: signInProvider.auth!.jwtToken);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => order_detail_page.OrderDetail(
          orderHistory: null,
          orderHistoryItem: orderHistoryItem,
          orderdetailHistory: orderDetailHistory,
          userOrder: user,
          company: company,
          department: department,
          onTapBack: () {
            setState(() {});
          },
        ),
      ),
    );

    setState(() {
      isWattingGetOrderDetail = false;
    });
  }

  reloadPeriod({required SignInProvider signInProvider}) async {
    signInProvider.period = await PeriodService.fetchPeriod(
        departmentId: signInProvider.department!.id,
        jwtToken: signInProvider.auth!.jwtToken);
  }
}
