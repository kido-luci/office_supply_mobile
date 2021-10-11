import 'package:office_supply_mobile_master/models/item.dart';

class Cart {
  List<Item> cartItems = <Item>[];
  int cartItemsQuantity;

  Cart({
    this.cartItemsQuantity = 0,
  });

  addItemToCart(Item item) {
    cartItems.add(item);
    cartItemsQuantity += item.quantity;
  }
}
