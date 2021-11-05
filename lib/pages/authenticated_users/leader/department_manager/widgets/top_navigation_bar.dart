import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/models/company/company.dart';
import 'package:office_supply_mobile_master/models/department/department.dart';
import 'package:office_supply_mobile_master/models/period/period.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';
import 'package:office_supply_mobile_master/pages/guest/sign_in/sign_in.dart';
import 'package:office_supply_mobile_master/providers/cart.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:office_supply_mobile_master/config/themes.dart';

class TopNavigationBar extends StatelessWidget {
  final SignInProvider signInProvider;
  final int selectedBarIndex;
  final Function({required int selectedBarIndex}) onTapIndexBar;

  const TopNavigationBar({
    Key? key,
    required this.signInProvider,
    required this.selectedBarIndex,
    required this.onTapIndexBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Stack(
      children: [
        backgroundImage(imagePath + sweetHomePNG),
        backgroundColor(primaryLightColorTransparent),
        Padding(
          padding: const EdgeInsets.only(top: 45),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    accountAvatar(photoUrl: signInProvider.user!.avatarUrl!),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 6,
                      child: signInProvider.user!.companyID != null
                          ? accountInfoInCompany(
                              user: signInProvider.user!,
                              department: signInProvider.department!,
                              company: signInProvider.company!,
                              period: signInProvider.period!,
                            )
                          : accountInfo(
                              user: signInProvider.user!,
                            ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          notificationButton(() {}),
                          const SizedBox(
                            height: 10,
                          ),
                          signOutButton(
                            () {
                              signInProvider.signOut();
                              cartProvider.removeAllItem();
                              cartProvider.cart.totalPrice = 0;
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const SignInPage()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    onTapIndexBar(selectedBarIndex: 0);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  color: primaryDarkColor,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.home_work_outlined,
                                        color: selectedBarIndex == 0
                                            ? Colors.white
                                            : Colors.white54,
                                        size: 17,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Quản lý phòng ban',
                                        style: h5.copyWith(
                                          color: selectedBarIndex == 0
                                              ? Colors.white
                                              : Colors.white54,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              selectedBarIndex == 0
                                  ? Container(
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            offset: Offset.zero,
                                            blurRadius: 3,
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(
                                      height: 2,
                                      color: primaryDarkColor,
                                    ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              onTapIndexBar(selectedBarIndex: 1);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    color: primaryDarkColor,
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: selectedBarIndex == 1
                                              ? Colors.white
                                              : Colors.white54,
                                          size: 17,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Lịch sử đơn hàng',
                                          style: h5.copyWith(
                                            color: selectedBarIndex == 1
                                                ? Colors.white
                                                : Colors.white54,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                selectedBarIndex == 1
                                    ? Container(
                                        height: 2,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                              offset: Offset.zero,
                                              blurRadius: 3,
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(
                                        height: 2,
                                        color: primaryDarkColor,
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  accountAvatar({required String photoUrl}) => Material(
        elevation: 5,
        shadowColor: primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        child: CircleAvatar(
          radius: 28,
          backgroundImage: const AssetImage(imagePath + blueAndPinkPNG),
          child: CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(photoUrl),
          ),
        ),
      );

  accountInfo({
    required User user,
  }) {
    String roleNameVietnamese;
    switch (user.roleName) {
      case 'Admin':
        roleNameVietnamese = 'Quản trị viên';
        break;
      case 'Manager':
        roleNameVietnamese = 'Người quản lý';
        break;
      case 'Leader':
        roleNameVietnamese = 'Trưởng phòng';
        break;
      case 'Employee':
        roleNameVietnamese = 'Nhân viên';
        break;
      default:
        roleNameVietnamese = 'Khách';
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //!user name
          Text(
            user.firstname + ' ' + user.lastname,
            style: h6.copyWith(color: primaryLightColor, fontSize: 14),
            textAlign: TextAlign.start,
          ),
          //!user role
          Text(
            '($roleNameVietnamese)',
            style: h6.copyWith(
              color: primaryLightColor,
              fontWeight: FontWeight.w200,
              fontSize: 13,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  accountInfoInCompany({
    required User user,
    required Department department,
    required Company company,
    required Period period,
  }) {
    String roleNameVietnamese;
    switch (user.roleName) {
      case 'Admin':
        roleNameVietnamese = 'Quản trị viên';
        break;
      case 'Manager':
        roleNameVietnamese = 'Người quản lý';
        break;
      case 'Leader':
        roleNameVietnamese = 'Trưởng phòng';
        break;
      case 'Employee':
        roleNameVietnamese = 'Nhân viên';
        break;
      default:
        roleNameVietnamese = 'Khách';
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Công ty: ${company.name}',
            style: h6.copyWith(
              color: primaryLightColor,
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
            textAlign: TextAlign.start,
          ),
          //!deparment wallet
          Row(
            children: [
              Text(
                'Phòng ban: ${department.name} - ',
                style: h6.copyWith(
                  color: primaryLightColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
                textAlign: TextAlign.start,
              ),
              Text(
                ProductInMenu.format(price: period.remainingQuota),
                style: h6.copyWith(
                  color: primaryLightColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                Icons.remove_red_eye,
                color: Colors.yellow.shade800,
                size: 14,
              )
            ],
          ),
          //!user name && role
          RichText(
            text: TextSpan(
              text: user.firstname + ' ' + user.lastname,
              style: h6.copyWith(
                color: primaryLightColor,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: ' ($roleNameVietnamese)',
                  style: h6.copyWith(
                    color: primaryLightColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  notificationButton(VoidCallback onTap) => InkWell(
        onTap: onTap,
        child: const Icon(
          Icons.notifications_active_outlined,
          color: primaryLightColor,
          size: 15,
        ),
      );

  signOutButton(VoidCallback onTap) => InkWell(
        onTap: onTap,
        child: const Icon(
          Icons.logout_outlined,
          color: primaryLightColor,
          size: 15,
        ),
      );

  backgroundImage(String photoUrl) => Container(
        height: 115,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(photoUrl),
            fit: BoxFit.cover,
          ),
        ),
      );

  backgroundColor(Color color) => Container(
        height: 115,
        decoration: BoxDecoration(
          color: color,
        ),
      );
}
