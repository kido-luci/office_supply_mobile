import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/models/company/company.dart';
import 'package:office_supply_mobile_master/models/department/department.dart';
import 'package:office_supply_mobile_master/models/period/period.dart';
import 'package:office_supply_mobile_master/models/product_in_menu/product_in_menu.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';
import 'package:office_supply_mobile_master/pages/guest/sign_in/sign_in.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:office_supply_mobile_master/config/themes.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final signInProvider = Provider.of<SignInProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        backgroundImage(imagePath + sweetHomePNG),
        backgroundColor(primaryLightColorTransparent),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: searchTextField(size),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 35, left: 10, right: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  accountAvatar(photoUrl: signInProvider.user!.avatarUrl),
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
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const SignInPage()),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
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
          //!deparment wallet
          Row(
            children: [
              Text(
                'Phòng: ${department.name} - ',
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
          Text(
            'Công ty: ${company.name}',
            style: h6.copyWith(
              color: primaryLightColor,
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
            textAlign: TextAlign.start,
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

  searchTextField(Size size) => SizedBox(
        width: size.width * 5 / 7,
        height: 40,
        child: const Material(
          elevation: 5,
          shadowColor: primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
          child: TextField(
            obscureText: false,
            autofocus: false,
            decoration: InputDecoration(
              isCollapsed: true,
              prefixIcon: Icon(
                Icons.search,
                color: primaryColor,
                size: 18,
              ),
              suffixIcon: Icon(
                Icons.list,
                color: primaryColor,
                size: 18,
              ),
              hintText: 'Tìm loại văn phòng phẩm',
              hintStyle: TextStyle(
                fontSize: 10,
                color: lightGrey,
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
          ),
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
