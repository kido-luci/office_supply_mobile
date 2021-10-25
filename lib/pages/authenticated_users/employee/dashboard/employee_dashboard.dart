import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/controllers/google_sign_in_controller.dart';
import 'package:office_supply_mobile_master/models/auth/auth.dart';
import 'package:office_supply_mobile_master/models/category/category.dart';
import 'package:office_supply_mobile_master/models/items_page/items_page.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/widgets/bottom_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/widgets/category.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/widgets/stationery_grid_item.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/widgets/top_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/product_detail/product_detail.dart';
import 'package:office_supply_mobile_master/services/category.dart';
import 'package:office_supply_mobile_master/services/product.dart';
import 'package:office_supply_mobile_master/widgets/cart_button.dart';
import 'package:provider/provider.dart';

class EmployeeDashBoard extends StatefulWidget {
  const EmployeeDashBoard({Key? key}) : super(key: key);

  @override
  State<EmployeeDashBoard> createState() => _EmployeeDashBoardState();
}

class _EmployeeDashBoardState extends State<EmployeeDashBoard> {
  late User user;
  late Auth auth;
  late ItemsPage itemsPage;
  late Map<int, List<ProductInMenu>> categoryItems;
  late Size _size;
  late int selectedCategoryId;

  @override
  void initState() {
    auth = Provider.of<GoogleSignInController>(context, listen: false).auth!;
    user = Provider.of<GoogleSignInController>(context, listen: false).user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      floatingActionButton: const CartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 130,
              child: TopNavigationBar(size: _size),
            ),
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  FutureBuilder<Map<int, Category>>(
                    future:
                        getItemsPage(userID: user.id, jwtToken: auth.jwtToken),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          return Column(
                            children: [
                              //!categories
                              CategogyCard(
                                categories: snapshot.data!,
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: CustomScrollView(
                                    slivers: [
                                      SliverGrid.count(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.65,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 16,
                                        children: categoryItems[
                                                selectedCategoryId]!
                                            .asMap()
                                            .entries
                                            .map(
                                              (e) => StationeryGridItem(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetail(
                                                        productInMenu: e.value,
                                                        onTapBack: () {
                                                          setState(() {});
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                },
                                                productInMenu: e.value,
                                                margin: EdgeInsets.only(
                                                  left: e.key.isEven ? 16 : 0,
                                                  right: e.key.isOdd ? 16 : 0,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        default:
                          return Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            child: const SizedBox(
                              height: 60,
                              width: 60,
                              child: CircularProgressIndicator(
                                color: primaryColor,
                                backgroundColor: primaryLightColor,
                                strokeWidth: 6,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(primaryColor),
                              ),
                            ),
                          );
                      }
                    },
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: BottomNavigation(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Map<int, Category>> getItemsPage(
      {required int userID, required String jwtToken}) async {
    await ProductAPI.fetchItemsPage(id: userID, jwtToken: jwtToken).then((e) {
      itemsPage = e;
    });
    categoryItems = <int, List<ProductInMenu>>{};
    if (itemsPage.itemsObject != null) {
      for (var e in itemsPage.itemsObject!) {
        categoryItems.update(
          e.productObject!.categoryID,
          (value) {
            List<ProductInMenu> tmpList = value;
            tmpList.add(e);
            return tmpList;
          },
          ifAbsent: () {
            List<ProductInMenu> tmpList = List.empty(growable: true);
            tmpList.add(e);
            return tmpList;
          },
        );
      }
    }

    Map<int, Category> categories = <int, Category>{};

    await Future.forEach(categoryItems.keys, (key) async {
      await CategoryAPI.fetchCategory(
        id: key as int,
        jwtToken: jwtToken,
      ).then((e) => categories[key] = e);
    });

    selectedCategoryId = categories.keys.elementAt(0);

    return categories;
  }
}
