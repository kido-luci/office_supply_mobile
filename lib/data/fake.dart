import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/models/item.dart';

class Fake {
  static int numberOfItemsInCart = 1;

  static List<Item> stationery = [
    Item(
      name: 'Bút chì kim Luci',
      imagePath: imagePath + luciPencilPNG,
      originalPrice: 32500,
      rating: 5.0,
      discountPercent: 40,
      quantity: 100,
    ),
    Item(
      name: 'Bút dạ Graffiti',
      imagePath: imagePath + graffitiPenPNG,
      originalPrice: 25400,
      rating: 4.5,
      discountPercent: 15,
      quantity: 100,
    ),
    Item(
      name: 'Bút lông Metallie',
      imagePath: imagePath + metalliePenPNG,
      originalPrice: 16400,
      rating: 4.5,
      discountPercent: 22,
      quantity: 100,
    ),
    Item(
      name: 'Bút Bi Sakura 2mm',
      imagePath: imagePath + sakuraPenPNG,
      originalPrice: 18000,
      rating: 4.5,
      discountPercent: 30,
      quantity: 100,
    ),
    Item(
      name: 'Bút Bi Sakura 2mm',
      imagePath: imagePath + sakuraPenPNG,
      originalPrice: 18000,
      rating: 4.5,
      discountPercent: 30,
      quantity: 100,
    ),
    Item(
      name: 'Bút Bi Sakura 2mm',
      imagePath: imagePath + sakuraPenPNG,
      originalPrice: 18000,
      rating: 4.5,
      discountPercent: 30,
      quantity: 100,
    ),
    Item(
      name: 'Bút Bi Sakura 2mm',
      imagePath: imagePath + sakuraPenPNG,
      originalPrice: 18000,
      rating: 4.5,
      discountPercent: 30,
      quantity: 100,
    ),
  ];

  // static List<Category> productCategories = [
  //   Category(
  //     title: 'Bút',
  //     iconPath: iconPath + pencilBoxSvg,
  //   ),
  //   Category(
  //     title: 'Sổ sách',
  //     iconPath: iconPath + notebookSvg,
  //   ),
  //   Category(
  //     title: 'Giấy',
  //     iconPath: iconPath + paperSvg,
  //   ),
  //   Category(
  //     title: 'Bút',
  //     iconPath: iconPath + pencilBoxSvg,
  //   ),
  //   Category(
  //     title: 'Bút',
  //     iconPath: iconPath + pencilBoxSvg,
  //   ),
  //   Category(
  //     title: 'Bút',
  //     iconPath: iconPath + pencilBoxSvg,
  //   ),
  //   Category(
  //     title: 'Bút',
  //     iconPath: iconPath + pencilBoxSvg,
  //   ),
  // ];
}
