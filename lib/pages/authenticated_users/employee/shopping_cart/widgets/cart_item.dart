import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';
import 'package:office_supply_mobile_master/providers/cart.dart';
import 'package:office_supply_mobile_master/widgets/circle_icon_button.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.productInMenu,
    required this.reloadShoppingCart,
  }) : super(key: key);

  final ProductInMenu productInMenu;
  final VoidCallback reloadShoppingCart;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: Offset.zero,
            blurRadius: 3,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(20)),
            child: Image.network(
              productInMenu.productObject!.imageUrl,
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productInMenu.productObject!.name,
                  style: h5.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Loại: ' + productInMenu.productObject!.category!,
                    style: h5.copyWith(color: lightGrey),
                  ),
                ),
                Text(
                  ProductInMenu.format(
                      price: productInMenu.price * productInMenu.quantity),
                  style: h5.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleIconButton(
                  onTap: () {
                    if (productInMenu.productObject!.quantity > 1) {
                      productInMenu.addQuantity(quantity: -1);
                      cartProvider.cart
                          .addTotalPrice(price: -productInMenu.price);
                    } else {
                      cartProvider.cart.removeItemFromCart(
                          key: productInMenu.productObject!.id);
                    }
                    reloadShoppingCart.call();
                  },
                  margin: EdgeInsets.zero,
                  iconData: Icons.remove,
                  size: 20,
                  iconColor: primaryColor,
                  backgroundColor: primaryLightColor,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    productInMenu.quantity < 10
                        ? '0' + productInMenu.quantity.toString()
                        : productInMenu.quantity.toString(),
                    style: h5.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                CircleIconButton(
                  //!demo
                  onTap: () {
                    productInMenu.addQuantity(quantity: 1);
                    cartProvider.cart.addTotalPrice(price: productInMenu.price);
                    reloadShoppingCart.call();
                  },
                  margin: EdgeInsets.zero,
                  iconData: Icons.add,
                  size: 20,
                  iconColor: Colors.white,
                  backgroundColor: primaryColor,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(20),
            ),
            child: InkWell(
              onTap: () {
                cartProvider.cart
                    .removeItemFromCart(key: productInMenu.productObject!.id);
                reloadShoppingCart.call();
              },
              child: Container(
                color: primaryLightColor,
                width: 15,
                height: 90,
                child: Center(
                  child: Text(
                    'x',
                    style: h5.copyWith(color: primaryColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
