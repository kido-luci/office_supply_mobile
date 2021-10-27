import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/shopping_cart/widgets/bottom_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/shopping_cart/widgets/cart_item.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/shopping_cart/widgets/top_navigation_bar.dart';
import 'package:office_supply_mobile_master/providers/cart.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  late CartProvider cartProvider;
  @override
  void initState() {
    super.initState();
    cartProvider = Provider.of<CartProvider>(context, listen: false);
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
              cart: cartProvider.cart,
            ),
          ],
        ),
      );
}
