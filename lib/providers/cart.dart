import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/models/cart/cart.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';

class CartProvider extends ChangeNotifier {
  var cart = Cart();

  addItemToCart({required ProductInMenu productInMenu}) {
    cart.addItemToCart(productInMenu: productInMenu);
    notifyListeners();
  }

  removeAllItem() {
    cart.cartItems = <int, ProductInMenu>{};
    notifyListeners();
  }
}
