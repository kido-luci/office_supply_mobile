import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/models/category/category.dart';

class CategogyCard extends StatelessWidget {
  const CategogyCard({
    Key? key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onTap,
  }) : super(key: key);

  final Map<int, Category> categories;
  final int selectedCategoryId;
  final Function({required int selectedCategoryId}) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Loại văn phòng phẩm',
                  style: h5.copyWith(
                    color: lightGrey,
                    fontSize: 14,
                  ),
                ),
                InkWell(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Xem tất cả',
                        style: h5.copyWith(
                          color: primaryColor,
                          fontSize: 14,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(Icons.arrow_forward,
                            color: primaryColor, size: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Wrap(
                spacing: 28,
                children: categories.entries
                    .map((e) => CategoryItem(
                          category: e.value,
                          index: e.key,
                          isSelected: e.key == selectedCategoryId,
                          onTap: () => onTap.call(selectedCategoryId: e.key),
                        ))
                    .toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sản phẩm nổi bật',
                  style: h5.copyWith(
                    color: lightGrey,
                    fontSize: 14,
                  ),
                ),
                InkWell(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Xem tất cả',
                        style: h5.copyWith(
                          color: primaryColor,
                          fontSize: 14,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.arrow_forward,
                          color: primaryColor,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.category,
    required this.index,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final Category category;
  final bool isSelected;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    String icon;
    switch (category.name) {
      case 'Bút':
        icon = iconPath + pencilBoxSvg;
        break;
      case 'Sổ sách':
        icon = iconPath + notebookSvg;
        break;
      case 'Giấy':
        icon = iconPath + paperSvg;
        break;
      default:
        icon = iconPath + pencilBoxSvg;
    }
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 80,
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : primaryLightColor,
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? primaryColor.withOpacity(0.5)
                  : Colors.black.withOpacity(0.13),
              offset: Offset.zero,
              blurRadius: 15,
            ),
          ],
        ),
        child: Center(
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                color: isSelected ? primaryLightColor : primaryColor,
                width: 30,
                height: 30,
              ),
              Text(
                category.name,
                style: h5.copyWith(
                  color: isSelected ? primaryLightColor : primaryColor,
                  fontSize: 15,
                  height: 1.5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
