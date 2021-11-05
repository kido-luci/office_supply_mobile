import 'package:flutter/material.dart';

import 'package:office_supply_mobile_master/config/themes.dart';

class CategogyCard extends StatelessWidget {
  final int selectedIndex;
  final Function({required int selectedCategoryId}) onTap;
  final List<String> categories;

  const CategogyCard({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              'Trạng thái đơn hàng',
              style: h5.copyWith(
                color: lightGrey,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Wrap(
                spacing: 15,
                children: categories
                    .asMap()
                    .entries
                    .map((e) => CategoryItem(
                          category: e.value,
                          index: e.key,
                          isSelected: e.key == selectedIndex,
                          onTap: () => onTap.call(selectedCategoryId: e.key),
                        ))
                    .toList(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              'Kết quả tìm kiếm',
              style: h5.copyWith(
                color: lightGrey,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String category;
  final bool isSelected;
  final int index;
  final VoidCallback onTap;

  const CategoryItem({
    Key? key,
    required this.category,
    required this.index,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
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
        child: Text(
          category,
          style: h5.copyWith(
            color: isSelected ? primaryLightColor : primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
