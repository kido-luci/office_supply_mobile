import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/models/order_history_page/order_history_page.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/order_history/widgets/bottom_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/order_history/widgets/top_navigation_bar.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:office_supply_mobile_master/services/order.dart';
import 'package:provider/provider.dart';

class EmployeeOrderHistory extends StatefulWidget {
  const EmployeeOrderHistory({Key? key}) : super(key: key);

  @override
  State<EmployeeOrderHistory> createState() => _EmployeeOrderHistoryState();
}

class _EmployeeOrderHistoryState extends State<EmployeeOrderHistory> {
  late SignInProvider signInProvider;
  late OrderHistoryPage tmp;

  @override
  void initState() {
    signInProvider = Provider.of<SignInProvider>(context, listen: false);
    getTmp();
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
              const SizedBox(
                height: 150,
                child: TopNavigationBar(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: const [
                      Text(
                        'History',
                        style: h4,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigation(),
          ),
        ],
      ),
    );
  }

  getTmp() async {
    tmp = await OrderService.fetchOrderByUserId(
        userId: signInProvider.user!.id,
        jwtToken: signInProvider.auth!.jwtToken);
    setState(() {});
  }
}
