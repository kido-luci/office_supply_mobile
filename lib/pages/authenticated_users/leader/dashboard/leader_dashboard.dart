import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/models/category/category.dart';
import 'package:office_supply_mobile_master/models/items_page/items_page.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/dashboard/widgets/bottom_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/dashboard/widgets/category.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/dashboard/widgets/stationery_grid_item.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/dashboard/widgets/top_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/department_manager/leader_order_history.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/product_detail/product_detail.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:office_supply_mobile_master/services/category.dart';
import 'package:office_supply_mobile_master/services/handler_background_message.dart';
import 'package:office_supply_mobile_master/services/period.dart';
import 'package:office_supply_mobile_master/services/product.dart';
import 'package:office_supply_mobile_master/widgets/cart_button.dart';
import 'package:office_supply_mobile_master/widgets/loading_ui.dart';
import 'package:provider/provider.dart';

class LeaderDashBoard extends StatefulWidget {
  const LeaderDashBoard({Key? key}) : super(key: key);

  @override
  State<LeaderDashBoard> createState() => _LeaderDashBoardState();
}

class _LeaderDashBoardState extends State<LeaderDashBoard> {
  late SignInProvider signInProvider;
  late ItemsPage itemsPage;
  late Map<int, List<ProductInMenu>> categoryItems;
  String searchItem = "";
  int selectedCategoryId = -1;

  @override
  void initState() {
    super.initState();
    signInProvider = Provider.of<SignInProvider>(context, listen: false);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? remoteNotification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if (remoteNotification != null && androidNotification != null) {
        // flutterLocalNotificationsPlugin.show(
        //   notification.hashCode,
        //   notification.title,
        //   notification.body,
        //   NotificationDetails(
        //     android: AndroidNotificationDetails(
        //       channel.id,
        //       channel.name,
        //       color: Colors.blue,
        //       playSound: true,
        //       //icon: '@mipmap/ic_launcher',
        //     ),
        //   ),
        // );
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                titlePadding: EdgeInsets.zero,
                actionsPadding: EdgeInsets.zero,
                insetPadding: EdgeInsets.zero,
                buttonPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                content: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset.zero,
                        blurRadius: 3,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        color: primaryLightColor,
                        height: 40,
                        child: Text(
                          'Thông báo',
                          style: h5.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              remoteNotification.body!,
                              style: h5.copyWith(
                                fontStyle: FontStyle.italic,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 115,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFAD4444),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          offset: Offset.zero,
                                          blurRadius: 3,
                                        )
                                      ],
                                    ),
                                    child: Text(
                                      'Bỏ qua',
                                      style: h5.copyWith(
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    reloadPeriod(
                                        signInProvider: signInProvider);
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DepartmentManager(
                                          firstselectedBarIndex: 1,
                                          firstOrderStatusId: 1,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 115,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          offset: Offset.zero,
                                          blurRadius: 3,
                                        )
                                      ],
                                    ),
                                    child: Text(
                                      'Xem chi tiết',
                                      style: h5.copyWith(
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      RemoteNotification? remoteNotification = remoteMessage.notification;
      AndroidNotification? androidNotification =
          remoteMessage.notification?.android;
      if (remoteNotification != null && androidNotification != null) {
        // showDialog(
        //     context: context,
        //     builder: (_) {
        //       return AlertDialog(
        //         title: Text(remoteNotification.title!),
        //         content: SingleChildScrollView(
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [Text(remoteNotification.body!)],
        //           ),
        //         ),
        //       );
        //     });
      }
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomNavigation(
                    signInProvider: signInProvider,
                  ),
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

  reloadPeriod({required SignInProvider signInProvider}) async {
    signInProvider.period = await PeriodService.fetchPeriod(
        departmentId: signInProvider.department!.id,
        jwtToken: signInProvider.auth!.jwtToken);
  }
}
