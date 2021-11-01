import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/models/order/order.dart';
import 'package:office_supply_mobile_master/models/order_detail/order_detail.dart';
import 'package:office_supply_mobile_master/models/order_history/order_history.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/shopping_cart/widgets/bottom_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/shopping_cart/widgets/cart_item.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/shopping_cart/widgets/top_navigation_bar.dart';
import 'package:office_supply_mobile_master/providers/cart.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:office_supply_mobile_master/services/order.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/order_detail/order_detail.dart'
    as order_detail_page;
import 'package:provider/provider.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  late CartProvider cartProvider;
  late SignInProvider signInProvider;
  @override
  void initState() {
    super.initState();
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    signInProvider = Provider.of<SignInProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
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
              //!demo
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
      );

  checkOut() async {
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
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => order_detail_page.OrderDetail(
          orderHistory: orderHistory,
        ),
      ),
      ModalRoute.withName('/employee_dashboard'),
    );
  }
}
