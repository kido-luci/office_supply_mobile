// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/product_detail/widgets/item_information.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/product_detail/widgets/top_navigation_bar.dart';
import 'package:office_supply_mobile_master/widgets/cart_button.dart';
import 'package:palette_generator/palette_generator.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.productInMenu})
      : super(key: key);
  final ProductInMenu productInMenu;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  var imageMainColor = Colors.white;

  @override
  void initState() {
    super.initState();
    getImagePalette(NetworkImage(widget.productInMenu.productObject!.imageUrl))
        .then((value) {
      imageMainColor = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: imageMainColor,
      extendBody: true,
      floatingActionButton: CartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Column(
        children: [
          const SizedBox(
            height: 80,
            child: TopNavigationBar(),
          ),
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                itemImage(_size),
                itemSaleDiscount(),
                Column(
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 2,
                      child: ItemInformation(
                        productInMenu: widget.productInMenu,
                        reloadProductDetail: () => setState(() {}),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  itemImage(Size size) => Column(
        children: [
          Expanded(
            child: Image.network(
              widget.productInMenu.productObject!.imageUrl,
              fit: BoxFit.cover,
              width: size.width,
            ),
            flex: 1,
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      );

  itemSaleDiscount() => Positioned(
        top: 30,
        right: 30,
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: primaryLightColorTransparent,
            shape: BoxShape.circle,
          ),
          child: const Text(
            '-0%',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      );

  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }
}
