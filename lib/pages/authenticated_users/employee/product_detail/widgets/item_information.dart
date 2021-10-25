import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/controllers/cart_controller.dart';
import 'package:office_supply_mobile_master/models/item.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';
import 'package:office_supply_mobile_master/widgets/circle_icon_button.dart';
import 'package:provider/provider.dart';

class ItemInformation extends StatefulWidget {
  const ItemInformation({
    Key? key,
    required this.productInMenu,
    required this.reloadProductDetail,
  }) : super(key: key);
  final ProductInMenu productInMenu;
  final VoidCallback reloadProductDetail;

  @override
  State<ItemInformation> createState() => _ItemInformationState();
}

class _ItemInformationState extends State<ItemInformation> {
  var _itemQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          itemName(),
          itemPrice(),
          itemRate(),
          itemDescription(),
          itemQuantity(),
          itemAddToCart(),
        ],
      ),
    );
  }

  itemName() => Padding(
        padding: const EdgeInsets.only(left: 15, top: 15),
        child: Text(
          widget.productInMenu.productObject!.name,
          style: h4.copyWith(
            color: Colors.black87,
            fontSize: 35,
            height: 1,
          ),
        ),
      );

  itemPrice() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          color: Colors.white,
          child: Wrap(
            spacing: 3,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                Item.format(price: widget.productInMenu.price),
                style: const TextStyle(
                  fontSize: 20,
                  color: primaryColor,
                  height: 1.5,
                ),
              ),
              Text(
                Item.format(price: widget.productInMenu.price),
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  decoration: TextDecoration.lineThrough,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        ),
      );

  itemRate() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RatingBar.builder(
              initialRating: 4.5,
              minRating: 1,
              itemSize: 12,
              ignoreGestures: true,
              allowHalfRating: true,
              itemCount: 5,
              unratedColor: Colors.amber[100],
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                size: 10,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) => {},
            ),
            const SizedBox(width: 5),
            Text(
              '4.5',
              style: h6.copyWith(
                color: lightGrey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );

  itemDescription() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('Loại: bút'),
                SizedBox(
                  width: 20,
                ),
                Text('Số lượng còn trong kho: 100'),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
                'Bút dạ, bút đánh dấu, tiếng Anh: marker pen, felt-tip marker; texta (ở Úc), sketch pen (ở Ấn Độ) hoặc koki (ở Nam Phi), là một cây bút có nguồn mực riêng và một đầu làm bằng sợi xốp, ép như ống nỉ.[1] Một bút dạ bao gồm một hộp chứa (thủy tinh, nhôm hoặc nhựa) và lõi của mọt vật liệu thấm nước.'),
          ],
        ),
      );

  itemQuantity() => Padding(
        padding: const EdgeInsets.only(
          bottom: 30,
          left: 15,
        ),
        child: ItemQuantity(
          itemPrice: widget.productInMenu.price,
          itemQuantity: _itemQuantity,
          onTapMinus: () => setState(
              () => _itemQuantity > 1 ? _itemQuantity-- : _itemQuantity),
          onTapPlus: () => setState(
              () => _itemQuantity < 12 ? _itemQuantity++ : _itemQuantity),
        ),
      );

  itemAddToCart() => InkWell(
        onTap: () => setState(() {
          widget.productInMenu.setQuantity(quantity: _itemQuantity);
          //!
          // Provider.of<CartController>(context, listen: false)
          //     .cart
          //     .addItemToCart(item: );
          widget.reloadProductDetail.call();
        }),
        child: Container(
          color: primaryColor,
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add stationery to cart',
                style: h5.copyWith(color: Colors.white),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                CupertinoIcons.cart_badge_plus,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
}

class ItemQuantity extends StatelessWidget {
  const ItemQuantity(
      {Key? key,
      required this.itemQuantity,
      required this.itemPrice,
      required this.onTapMinus,
      required this.onTapPlus})
      : super(key: key);
  final int itemQuantity;
  final double itemPrice;
  final VoidCallback onTapMinus;
  final VoidCallback onTapPlus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 95,
              child: Text(
                'Số lượng:',
                style: h5.copyWith(
                  color: lightGrey,
                ),
              ),
            ),
            CircleIconButton(
              onTap: onTapMinus,
              margin: EdgeInsets.zero,
              iconData: Icons.remove,
              size: 20,
              iconColor: Colors.white,
              backgroundColor: primaryLightColorTransparent,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                itemQuantity < 10
                    ? '0${itemQuantity.toString()}'
                    : itemQuantity.toString(),
                style: h5.copyWith(
                  color: Colors.black87,
                  fontSize: 20,
                ),
              ),
            ),
            CircleIconButton(
              onTap: onTapPlus,
              margin: EdgeInsets.zero,
              iconData: Icons.add,
              size: 20,
              iconColor: Colors.white,
              backgroundColor: primaryLightColorTransparent,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 95,
              child: Text(
                'Thành tiền:',
                style: h5.copyWith(color: lightGrey),
              ),
            ),
            Text(
              Item.format(price: itemPrice * itemQuantity),
              style: h4,
            ),
          ],
        ),
      ],
    );
  }
}
