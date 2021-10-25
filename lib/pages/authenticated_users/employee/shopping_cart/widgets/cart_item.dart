import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/controllers/cart_controller.dart';
import 'package:office_supply_mobile_master/models/item.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';
import 'package:office_supply_mobile_master/widgets/circle_icon_button.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    Key? key,
    required this.productInMenu,
    required this.reloadShoppingCart,
  }) : super(key: key);

  final ProductInMenu productInMenu;
  final VoidCallback reloadShoppingCart;

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
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
              widget.productInMenu.productObject!.imageUrl,
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
                  widget.productInMenu.productObject!.name,
                  style: h5.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Loại: bút',
                    style: h5.copyWith(color: lightGrey),
                  ),
                ),
                Text(
                  Item.format(
                      price: widget.productInMenu.productObject!.price *
                          widget.productInMenu.productObject!.quantity),
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
                    if (widget.productInMenu.productObject!.quantity > 1) {
                      widget.productInMenu.addQuantity(quantity: -1);
                      Provider.of<CartController>(context, listen: false)
                          .cart
                          .addTotalPrice(price: -widget.productInMenu.price);
                    } else {
                      Provider.of<CartController>(context, listen: false)
                          .cart
                          .removeItemFromCart(
                              key: widget.productInMenu.productObject!.id);
                    }
                    widget.reloadShoppingCart.call();
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
                    widget.productInMenu.quantity < 10
                        ? '0' + widget.productInMenu.quantity.toString()
                        : widget.productInMenu.quantity.toString(),
                    style: h5.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                CircleIconButton(
                  onTap: () {
                    widget.productInMenu.addQuantity(quantity: 1);
                    Provider.of<CartController>(context, listen: false)
                        .cart
                        .addTotalPrice(price: widget.productInMenu.price);
                    widget.reloadShoppingCart.call();
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
                Provider.of<CartController>(context, listen: false)
                    .cart
                    .removeItemFromCart(
                        key: widget.productInMenu.productObject!.id);
                widget.reloadShoppingCart.call();
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
