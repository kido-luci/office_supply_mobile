import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/models/item.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/product_detail/widgets/item_information.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/product_detail/widgets/top_navigation_bar.dart';
import 'package:office_supply_mobile_master/widgets/cart_button.dart';
import 'package:palette_generator/palette_generator.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.item, required this.onTapBack})
      : super(key: key);
  final Item item;
  final VoidCallback onTapBack;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  var imageMainColor = Colors.white;

  @override
  void initState() {
    super.initState();
    getImagePalette(AssetImage(widget.item.imagePath)).then((value) {
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
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: TopNavigationBar(size: _size, onTapBack: widget.onTapBack),
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
                          item: widget.item,
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
      ),
    );
  }

  itemImage(Size size) => Column(
        children: [
          Expanded(
            child: Image.asset(
              widget.item.imagePath,
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
          child: Text(
            '-${widget.item.discountPercent}%',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      );

  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }
}
