import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/controllers/google_sign_in_controller.dart';
import 'package:office_supply_mobile_master/data/fake.dart';
import 'package:office_supply_mobile_master/models/auth/auth.dart';
import 'package:office_supply_mobile_master/models/items_page/items_page.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/widgets/bottom_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/widgets/category.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/widgets/stationery_grid_item.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/widgets/top_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/product_detail/product_detail.dart';
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

  @override
  void initState() {
    super.initState();
    auth = Provider.of<GoogleSignInController>(context, listen: false).auth!;
    user = Provider.of<GoogleSignInController>(context, listen: false).user;
    if (user.companyID != null) {
      getItemsPage(id: user.id, jwtToken: auth.jwtToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
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
                  Column(
                    children: [
                      const CategogyCard(),
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
                                children: Fake.stationery
                                    .asMap()
                                    .entries
                                    .map(
                                      (e) => StationeryGridItem(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetail(
                                                item: Fake.stationery[e.key],
                                                onTapBack: () {
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        item: e.value,
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

  getItemsPage({required int id, required String jwtToken}) async {
    await ProductAPI.fetchItemsPage(id: id, jwtToken: jwtToken).then((e) {
      itemsPage = e;
    });
    Map<int, List<ProductInMenu>> categoryItems = <int, List<ProductInMenu>>{};
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
  }
}
