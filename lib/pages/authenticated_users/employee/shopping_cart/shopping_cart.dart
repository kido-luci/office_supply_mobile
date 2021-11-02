import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/models/company/company.dart';
import 'package:office_supply_mobile_master/models/department/department.dart';
import 'package:office_supply_mobile_master/models/order/order.dart';
import 'package:office_supply_mobile_master/models/order_detail/order_detail.dart';
import 'package:office_supply_mobile_master/models/order_detail_history/order_detail_history.dart';
import 'package:office_supply_mobile_master/models/order_history/order_history.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/shopping_cart/widgets/bottom_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/shopping_cart/widgets/cart_item.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/shopping_cart/widgets/top_navigation_bar.dart';
import 'package:office_supply_mobile_master/providers/cart.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:office_supply_mobile_master/services/company.dart';
import 'package:office_supply_mobile_master/services/department.dart';
import 'package:office_supply_mobile_master/services/order.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/order_detail/order_detail.dart'
    as order_detail_page;
import 'package:office_supply_mobile_master/services/order_detail.dart';
import 'package:office_supply_mobile_master/services/user.dart';
import 'package:office_supply_mobile_master/widgets/loading_ui.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  late CartProvider cartProvider;
  late SignInProvider signInProvider;
  var isCheckOut = false;

  @override
  void initState() {
    super.initState();
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    signInProvider = Provider.of<SignInProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                  child: TopNavigationBar(onTapBack: () {
                    setState(() {});
                  }),
                ),
                Expanded(
                  flex: 1,
                  child: ListView(
                    children: cartProvider.cart.cartItems.entries
                        .map(
                          (e) => CartItem(
                            productInMenu: e.value,
                            reloadShoppingCart: () => setState(() {}),
                          ),
                        )
                        .toList(),
                  ),
                ),
                BottomNavigation(
                  onTapCheckOut: checkOut,
                  cart: cartProvider.cart,
                ),
              ],
            ),
            Visibility(
              visible: isCheckOut,
              child: const LoadingUI(),
            ),
          ],
        ),
      );

  checkOut() async {
    setState(() {
      isCheckOut = true;
    });
    Order order = Order(
      userOrderID: signInProvider.user!.id,
    );
    cartProvider.cart.cartItems.forEach((key, value) {
      order.orderDetails.add(OrderDetail(
          menuID: value.menuID,
          price: value.price,
          productID: key,
          quantity: value.quantity));
    });
    OrderHistory orderHistory = await OrderService.postOrder(
        jsonBody: order.toJson(), jwtToken: signInProvider.auth!.jwtToken);
    User user = await UserService.fetchUser(
        id: orderHistory.userOrderID, jwtToken: signInProvider.auth!.jwtToken);

    Company company = await CompanyService.fetchCompany(
      id: user.departmentID!,
      jwtToken: signInProvider.auth!.jwtToken,
    );

    Department department = await DepartmentService.fetchDepartment(
      id: user.departmentID!,
      jwtToken: signInProvider.auth!.jwtToken,
    );

    List<OrderDetailHistory> orderDetailHistory =
        await OrderDetailService.fetchOrderDetail(
            orderId: orderHistory.id, jwtToken: signInProvider.auth!.jwtToken);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => order_detail_page.OrderDetail(
          orderHistory: orderHistory,
          orderdetailHistory: orderDetailHistory,
          userOrder: user,
          company: company,
          department: department,
        ),
      ),
      ModalRoute.withName('/employee_dashboard'),
    );
    cartProvider.removeAllItem();
  }
}
