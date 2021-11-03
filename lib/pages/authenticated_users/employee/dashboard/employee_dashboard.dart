import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/models/category/category.dart';
import 'package:office_supply_mobile_master/models/items_page/items_page.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/widgets/bottom_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/widgets/category.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/widgets/stationery_grid_item.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/widgets/top_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/product_detail/product_detail.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:office_supply_mobile_master/services/category.dart';
import 'package:office_supply_mobile_master/services/product.dart';
import 'package:office_supply_mobile_master/widgets/cart_button.dart';
import 'package:office_supply_mobile_master/widgets/loading_ui.dart';
import 'package:provider/provider.dart';

class EmployeeDashBoard extends StatefulWidget {
  const EmployeeDashBoard({Key? key}) : super(key: key);

  @override
  State<EmployeeDashBoard> createState() => _EmployeeDashBoardState();
}

class _EmployeeDashBoardState extends State<EmployeeDashBoard> {
  late SignInProvider signInProvider;
  late ItemsPage itemsPage;
  late Map<int, List<ProductInMenu>> categoryItems;
  String searchItem = "";
  int selectedCategoryId = -1;

  @override
  void initState() {
    super.initState();
    signInProvider = Provider.of<SignInProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      floatingActionButton: const CartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Column(
        children: [
          SizedBox(
            height: 150,
            child: TopNavigationBar(
              onTapSearch: ({required String searchItem}) {
                setState(() {
                  this.searchItem = searchItem;
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                FutureBuilder<Map<int, Category>>(
                  future: getItemsPage(
                    userID: signInProvider.user!.id,
                    jwtToken: signInProvider.auth!.jwtToken,
                    search: searchItem,
                  ),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return categoryItems[selectedCategoryId] == null
                            ? SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 100),
                                      child: Image.asset(
                                        imagePath + notFoundPNG,
                                        height: 180,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 70,
                                        vertical: 30,
                                      ),
                                      child: Text(
                                        'Không tìm thấy sản phẩm phù hợp với "$searchItem"',
                                        style: h5.copyWith(
                                          fontStyle: FontStyle.italic,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  //!categories
                                  CategogyCard(
                                    categories: snapshot.data!,
                                    selectedCategoryId: selectedCategoryId,
                                    onTap:
                                        ({required int selectedCategoryId}) =>
                                            setState(
                                      () => this.selectedCategoryId =
                                          selectedCategoryId,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: CustomScrollView(
                                          slivers: [
                                            SliverGrid.count(
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.65,
                                              mainAxisSpacing: 5,
                                              crossAxisSpacing: 5,
                                              children: <Widget>[] +
                                                  (categoryItems[
                                                          selectedCategoryId]!
                                                      .asMap()
                                                      .entries
                                                      .map(
                                                        (e) =>
                                                            StationeryGridItem(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ProductDetail(
                                                                  productInMenu:
                                                                      e.value,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          productInMenu:
                                                              e.value,
                                                        ),
                                                      )
                                                      .toList()) +
                                                  [
                                                    const SizedBox.shrink(),
                                                  ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                      default:
                        return Container(
                          alignment: Alignment.center,
                          child: const LoadingUI(),
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
    );
  }

  Future<Map<int, Category>> getItemsPage(
      {required int userID,
      required String jwtToken,
      required String search}) async {
    await ProductService.fetchItemsPage(
            id: userID, jwtToken: jwtToken, search: search)
        .then((e) {
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
      await CategoryService.fetchCategory(
        id: key as int,
        jwtToken: jwtToken,
      ).then((e) {
        for (var tmpProduct in categoryItems[key]!) {
          tmpProduct.productObject!.category = e.name;
        }
        categories[key] = e;
      });
    });

    if (selectedCategoryId == -1) {
      selectedCategoryId = categories.keys.elementAt(0);
    }

    return categories;
  }
}
