import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/models/item.dart';

class Fake {
  static int numberOfItemsInCart = 1;

  static List<String> trending = [
    'assets/images/furniture/jacalyn-beales-435629-unsplash.png',
    'assets/images/furniture/sven-brandsma-1379481-unsplash.png',
  ];

  static List<String> featured = [
    'assets/images/furniture/pexels-eric-montanah-1350789.jpg',
    'assets/images/furniture/pexels-patryk-kamenczak-775219.jpg',
    'assets/images/furniture/pexels-pixabay-276534.jpg',
    'assets/images/furniture/pexels-steve-johnson-923192.jpg'
  ];

  static List<Item> furniture = [
    Item(
      name: 'Bút chì kim Luci',
      imagePath: imagePath + luciPencilPNG,
      originalPrice: 32500,
      rating: 5.0,
      discountPercent: 40,
    ),
    Item(
      name: 'Bút dạ Graffiti',
      imagePath: imagePath + graffitiPenPNG,
      originalPrice: 25400,
      rating: 4.5,
      discountPercent: 15,
    ),
    Item(
      name: 'Bút lông Metallie',
      imagePath: imagePath + metalliePenPNG,
      originalPrice: 16400,
      rating: 4.5,
      discountPercent: 22,
    ),
    Item(
      name: 'Bút Bi Sakura 2mm',
      imagePath: imagePath + sakuraPenPNG,
      originalPrice: 18000,
      rating: 4.5,
      discountPercent: 30,
    ),
    Item(
      name: 'Bút Bi Sakura 2mm',
      imagePath: imagePath + sakuraPenPNG,
      originalPrice: 18000,
      rating: 4.5,
      discountPercent: 30,
    ),
    Item(
      name: 'Bút Bi Sakura 2mm',
      imagePath: imagePath + sakuraPenPNG,
      originalPrice: 18000,
      rating: 4.5,
      discountPercent: 30,
    ),
    Item(
      name: 'Bút Bi Sakura 2mm',
      imagePath: imagePath + sakuraPenPNG,
      originalPrice: 18000,
      rating: 4.5,
      discountPercent: 30,
    ),
  ];
}
