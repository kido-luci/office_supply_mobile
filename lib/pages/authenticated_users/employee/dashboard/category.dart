import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/config/themes.dart';

class CategogyCard extends StatelessWidget {
  const CategogyCard({Key? key}) : super(key: key);

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
                    color: const Color.fromRGBO(0, 0, 0, 0.54),
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
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.arrow_forward,
                          color: primaryColor,
                        ),
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
                children: const [
                  CategoryItem(
                    categoryName: 'Bút',
                    iconPath: iconPath + pencilBoxSvg,
                    isSelected: true,
                  ),
                  CategoryItem(
                    categoryName: 'Sổ sách',
                    iconPath: iconPath + notebookSvg,
                    isSelected: false,
                  ),
                  CategoryItem(
                    categoryName: 'Giấy',
                    iconPath: iconPath + paperSvg,
                    isSelected: false,
                  ),
                  CategoryItem(
                    categoryName: 'Giấy',
                    iconPath: iconPath + paperSvg,
                    isSelected: false,
                  ),
                  CategoryItem(
                    categoryName: 'Giấy',
                    iconPath: iconPath + paperSvg,
                    isSelected: false,
                  ),
                  CategoryItem(
                    categoryName: 'Giấy',
                    iconPath: iconPath + paperSvg,
                    isSelected: false,
                  ),
                ],
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
                    color: const Color.fromRGBO(0, 0, 0, 0.54),
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
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.arrow_forward,
                          color: primaryColor,
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
  const CategoryItem(
      {Key? key,
      required this.categoryName,
      required this.iconPath,
      required this.isSelected})
      : super(key: key);
  final String categoryName;
  final String iconPath;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                  iconPath,
                  color: isSelected ? primaryLightColor : primaryColor,
                ),
              ),
              Text(
                categoryName,
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
