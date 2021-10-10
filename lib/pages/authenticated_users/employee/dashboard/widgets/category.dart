import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/data/fake.dart';
import 'package:office_supply_mobile_master/models/category.dart';

class CategogyCard extends StatefulWidget {
  const CategogyCard({Key? key}) : super(key: key);

  @override
  State<CategogyCard> createState() => _CategogyCardState();
}

class _CategogyCardState extends State<CategogyCard> {
  var selectedIndex = 0;

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
          // const Padding(
          //   padding: EdgeInsets.only(left: 15, right: 15, top: 0),
          //   child: Divider(
          //     height: 1,
          //     thickness: 1,
          //     color: primaryColor,
          //   ),
          // ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Wrap(
                spacing: 28,
                children: Fake.productCategories
                    .asMap()
                    .entries
                    .map((e) => CategoryItem(
                          productCategory: e.value,
                          index: e.key,
                          isSelected: e.key == selectedIndex,
                          onTap: () => setState(() {
                            selectedIndex = e.key;
                          }),
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
    required this.productCategory,
    required this.index,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final Category productCategory;
  final bool isSelected;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                height: 30,
                width: 30,
                child: SvgPicture.asset(
                  productCategory.iconPath,
                  color: isSelected ? primaryLightColor : primaryColor,
                ),
              ),
              Text(
                productCategory.title,
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
