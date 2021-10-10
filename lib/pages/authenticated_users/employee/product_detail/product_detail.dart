import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/models/item.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/product_detail/widgets/top_navigation_bar.dart';
import 'package:office_supply_mobile_master/widgets/circle_icon_button.dart';
import 'package:palette_generator/palette_generator.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.item}) : super(key: key);
  final Item item;

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
      //backgroundColor: Colors.white,
      extendBody: true,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: TopNavigationBar(size: _size),
            ),
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          widget.item.imagePath,
                          fit: BoxFit.cover,
                          width: _size.width,
                        ),
                        flex: 11,
                      ),
                      Expanded(
                        flex: 18,
                        child: Container(),
                      )
                    ],
                  ),
                  Positioned(
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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.topCenter,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(25)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 50),
                                child: Text(
                                  widget.item.name,
                                  style: h4.copyWith(color: lightGrey),
                                ),
                              ),
                              Wrap(
                                spacing: 3,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    Item.format(widget.item.price),
                                    style: const TextStyle(
                                      fontSize: 30,
                                      color: primaryColor,
                                      height: 1.5,
                                    ),
                                  ),
                                  if (widget.item.discountPercent != 0)
                                    Text(
                                      Item.format(widget.item.originalPrice),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        height: 1.5,
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.black38,
                                      ),
                                    ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RatingBar.builder(
                                      initialRating: widget.item.rating,
                                      minRating: 1,
                                      itemSize: 20,
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
                                      '${widget.item.rating}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        'Quantity: ',
                                        style: h5.copyWith(color: lightGrey),
                                      ),
                                    ),
                                    CircleIconButton(
                                      onTap: () {},
                                      margin: EdgeInsets.zero,
                                      iconData: Icons.remove,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        '01',
                                        style: h4,
                                      ),
                                    ),
                                    CircleIconButton(
                                      onTap: () {},
                                      margin: EdgeInsets.zero,
                                      iconData: Icons.add,
                                    ),
                                  ],
                                ),
                              ),
                              SignInButtonBuilder(
                                backgroundColor: primaryColor,
                                onPressed: () {},
                                text: 'Add stationery to cart    +',
                                icon: CupertinoIcons.cart,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  // const Align(
                  //     alignment: Alignment.bottomCenter,
                  //     child: BottomNavigation()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }
}
