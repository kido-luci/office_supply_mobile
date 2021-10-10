import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/data/fake.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/widgets/bottom_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/widgets/category.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/widgets/stationery_grid_item.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/widgets/top_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/product_detail/product_detail.dart';

class EmployeeDashBoard extends StatelessWidget {
  const EmployeeDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
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
                                                        item: Fake
                                                            .stationery[e.key],
                                                      )));
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
                      child: BottomNavigation()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
