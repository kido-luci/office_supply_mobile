import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/controllers/cart_controller.dart';
import 'package:provider/provider.dart';

class CartButton extends StatefulWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  _CartButtonState createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.only(
        right: 15,
        bottom: 100,
      ),
      child: Stack(
        children: [
          FloatingActionButton(
            backgroundColor: primaryLightColor,
            child: const Icon(
              CupertinoIcons.shopping_cart,
              size: 20,
              color: primaryColor,
            ),
            onPressed: () {},
          ),
          Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              child: Text(
                Provider.of<CartController>(context, listen: false)
                    .cart
                    .cartItemsQuantity
                    .toString(),
                style: h6.copyWith(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
              radius: 9,
            ),
          )
        ],
      ),
    );
  }
}
