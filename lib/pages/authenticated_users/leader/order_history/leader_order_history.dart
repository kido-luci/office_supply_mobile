import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/models/company/company.dart';
import 'package:office_supply_mobile_master/models/department/department.dart';
import 'package:office_supply_mobile_master/models/order_detail_history/order_detail_history.dart';
import 'package:office_supply_mobile_master/models/order_history_item/order_history_item.dart';
import 'package:office_supply_mobile_master/models/order_history_page/order_history_page.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/order_history/widgets/bottom_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/order_history/widgets/order_history_item.dart'
    as order_history_item_ui;
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/order_detail/order_detail.dart'
    as order_detail_page;
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/order_history/widgets/top_navigation_bar.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:office_supply_mobile_master/services/company.dart';
import 'package:office_supply_mobile_master/services/department.dart';
import 'package:office_supply_mobile_master/services/order.dart';
import 'package:office_supply_mobile_master/services/order_detail.dart';
import 'package:office_supply_mobile_master/services/role.dart';
import 'package:office_supply_mobile_master/services/user.dart';
import 'package:office_supply_mobile_master/widgets/loading_ui.dart';
import 'package:provider/provider.dart';

class LeaderOrderHistory extends StatefulWidget {
  const LeaderOrderHistory({Key? key}) : super(key: key);

  @override
  State<LeaderOrderHistory> createState() => _LeaderOrderHistoryState();
}

class _LeaderOrderHistoryState extends State<LeaderOrderHistory> {
  late SignInProvider signInProvider;
  bool isWattingGetOrderDetail = false;

  @override
  void initState() {
    signInProvider = Provider.of<SignInProvider>(context, listen: false);
    super.initState();
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
                height: 150,
                child: TopNavigationBar(signInProvider: signInProvider),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    imagePath + recentPNG,
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Lịch sử đơn hàng phòng ban: ' +
                        signInProvider.department!.name,
                    style: h4.copyWith(fontSize: 16),
                  ),
                ],
              ),
              Text(
                'Giới hạn của kỳ: ' +
                    ProductInMenu.format(price: signInProvider.period!.quota),
                style: h5.copyWith(fontSize: 18, fontWeight: FontWeight.w300),
              ),
              Text(
                'Số tiền còn lại: ' +
                    ProductInMenu.format(
                        price: signInProvider.period!.remainingQuota),
                style: h5.copyWith(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              Expanded(
                flex: 1,
                child: FutureBuilder<OrderHistoryPage>(
                  future: OrderService.fetchOrderByUserId(
                      userId: signInProvider.user!.id,
                      jwtToken: signInProvider.auth!.jwtToken),
                  builder: (context, snapshot) => snapshot.hasData
                      ? ListView(
                          padding: const EdgeInsets.only(top: 10, bottom: 50),
                          children: snapshot.data!.itemsObject!
                              .asMap()
                              .entries
                              .map(
                                  (e) => order_history_item_ui.OrderHistoryItem(
                                        orderHistoryItem: e.value,
                                        onTap: viewOrderDetail,
                                      ))
                              .toList())
                      : const LoadingUI(),
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

    //!error
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
        ),
      ),
    );

    setState(() {
      isWattingGetOrderDetail = false;
    });
  }
}
