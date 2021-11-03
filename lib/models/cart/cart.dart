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
      ifAbsent: () => ProductInMenu(
        menuID: productInMenu.menuID,
        price: productInMenu.price,
        product: productInMenu.product,
        productID: productInMenu.productID,
        quantity: productInMenu.quantity,
        productObject: productInMenu.productObject,
      ),
    );

    totalPrice += productInMenu.quantity * productInMenu.price;
  }

  removeItemFromCart({required int key}) {
    ProductInMenu? productInMenu = cartItems.remove(key);
    if (productInMenu != null) {
      addTotalPrice(price: -(productInMenu.quantity * productInMenu.price));
    }
  }

  addTotalPrice({required double price}) {
    totalPrice += price;
  }
}
