import 'package:intl/intl.dart';

class Item {
  String name;
  String imagePath;
  int discountPercent;
  double originalPrice;
  double rating;

  Item({
    required this.name,
    required this.imagePath,
    required this.originalPrice,
    required this.rating,
    this.discountPercent = 0,
  });

  double get price {
    return discountPercent != 0
        ? (originalPrice - (originalPrice * discountPercent / 100))
        : originalPrice;
  }

  static String format(double price) =>
      NumberFormat.currency(locale: 'vi', symbol: '₫', decimalDigits: 0)
          .format(price);
}
