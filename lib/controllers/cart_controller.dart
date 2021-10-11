import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/models/cart.dart';
import 'package:office_supply_mobile_master/models/item.dart';

class CartController extends ChangeNotifier {
  var cart = Cart();

  addToCart(Item item) {
    cart.addItemToCart(item);
    for (var element in cart.cartItems) {
      print(element.name +
          ' ' +
          element.quantity.toString() +
          ' ' +
          element.price.toString());
    }
    notifyListeners();
  }
}
