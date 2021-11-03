import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/models/order_detail_history/order_detail_history.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';

class OrderItem extends StatelessWidget {
  final OrderDetailHistory orderDetailHistory;
  final bool isCancelCheckOut;

  const OrderItem({
    Key? key,
    required this.orderDetailHistory,
    this.isCancelCheckOut = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
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
                orderDetailHistory.productInMenuObject.productObject!.imageUrl,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderDetailHistory.productInMenuObject.productObject!.name,
                    style: h6.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    'Loại: ' +
                        orderDetailHistory.productInMenuObject.productObject!
                            .categoryObject.name,
                    style: h6.copyWith(color: lightGrey, height: 1.5),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Số lượng: ${orderDetailHistory.quantity < 10 ? '0' + orderDetailHistory.quantity.toString() : orderDetailHistory.quantity.toString()}',
                    style: h6.copyWith(
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    ProductInMenu.format(
                        price: orderDetailHistory.price *
                            orderDetailHistory.quantity),
                    style: h6.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                      decoration: isCancelCheckOut
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
