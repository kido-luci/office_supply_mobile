import 'package:office_supply_mobile_master/models/item.dart';

class Cart {
  Map<String, Item> cartItems = {};
  double totalPrice;

  Cart({
    this.totalPrice = 0,
  });

  addItemToCart({required Item item}) {
    cartItems.update(
      item.name,
      (value) => value.addQuantity(quantity: item.quantity),
      ifAbsent: () => Item(
        name: item.name,
        quantity: item.quantity,
        imagePath: item.imagePath,
        originalPrice: item.originalPrice,
        discountPercent: item.discountPercent,
      ),
    );

    totalPrice += item.quantity * item.price;

    // if (cartItems.containsKey(item.name)) {
    //   cartItems[item.name]!.addQuantity(item.quantity);
    // } else {
    //   cartItems[item.name] = Item(
    //     name: item.name,
    //     quantity: item.quantity,
    //     imagePath: item.imagePath,
    //     originalPrice: item.originalPrice,
    //   );
    // }
  }

  removeItemFromCart({required String key}) {
    Item? item = cartItems.remove(key);
    if (item != null) {
      addTotalPrice(price: -(item.quantity * item.price));
      //totalPrice -= item.quantity * item.price;
    }
  }

  addTotalPrice({required double price}) {
    totalPrice += price;
  }
}
