import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/controllers/cart_controller.dart';
import 'package:office_supply_mobile_master/models/item.dart';
import 'package:office_supply_mobile_master/widgets/circle_icon_button.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    Key? key,
    required this.item,
    required this.reloadShoppingCart,
  }) : super(key: key);

  final Item item;
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
            child: Image.asset(
              widget.item.imagePath,
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
                  widget.item.name,
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
                  Item.format(price: widget.item.price * widget.item.quantity),
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
                    if (widget.item.quantity > 1) {
                      widget.item.addQuantity(quantity: -1);
                      Provider.of<CartController>(context, listen: false)
                          .cart
                          .addTotalPrice(price: -widget.item.price);
                    } else {
                      Provider.of<CartController>(context, listen: false)
                          .cart
                          .removeItemFromCart(key: widget.item.name);
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
                    widget.item.quantity < 10
                        ? '0' + widget.item.quantity.toString()
                        : widget.item.quantity.toString(),
                    style: h5.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                CircleIconButton(
                  onTap: () {
                    widget.item.addQuantity(quantity: 1);
                    Provider.of<CartController>(context, listen: false)
                        .cart
                        .addTotalPrice(price: widget.item.price);
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
                    .removeItemFromCart(key: widget.item.name);
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
