import 'package:intl/intl.dart';

class Item {
  String name;
  String imagePath;
  int discountPercent;
  double originalPrice;
  double rating;
  int quantity;

  Item({
    required this.name,
    required this.quantity,
    required this.originalPrice,
    this.imagePath = '',
    this.rating = 5,
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
