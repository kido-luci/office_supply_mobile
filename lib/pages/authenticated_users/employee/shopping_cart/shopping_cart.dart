import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/controllers/cart_controller.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/shopping_cart/widgets/bottom_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/shopping_cart/widgets/cart_item.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/shopping_cart/widgets/top_navigation_bar.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                child: TopNavigationBar(onTapBack: () {
                  setState(() {});
                }),
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  children: Provider.of<CartController>(context, listen: false)
                      .cart
                      .cartItems
                      .entries
                      .map((e) => CartItem(
                            productInMenu: e.value,
                            reloadShoppingCart: () => setState(() {}),
                          ))
                      .toList(),
                ),
              ),
              BottomNavigation(
                cart: Provider.of<CartController>(context, listen: false).cart,
              ),
            ],
          ),
        ),
      );
}
