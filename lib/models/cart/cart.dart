import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';

class Cart {
  Map<int, ProductInMenu> cartItems = {};
  double totalPrice;

  Cart({
    this.totalPrice = 0,
  });

  addItemToCart({required ProductInMenu productInMenu}) {
    cartItems.update(
      productInMenu.productObject!.id,
      (value) => value.addQuantity(quantity: productInMenu.quantity),
      // ifAbsent: () => Item(
      //   name: item.name,
      //   quantity: item.quantity,
      //   imagePath: item.imagePath,
      //   originalPrice: item.originalPrice,
      //   discountPercent: item.discountPercent,
      // ),
      //!warming
      ifAbsent: () => productInMenu,
    );

    totalPrice += productInMenu.quantity * productInMenu.price;

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

  removeItemFromCart({required int key}) {
    ProductInMenu? productInMenu = cartItems.remove(key);
    if (productInMenu != null) {
      addTotalPrice(price: -(productInMenu.quantity * productInMenu.price));
      //totalPrice -= item.quantity * item.price;
    }
  }

  addTotalPrice({required double price}) {
    totalPrice += price;
  }
}
