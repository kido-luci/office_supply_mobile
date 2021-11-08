import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:office_supply_mobile_master/models/auth/auth.dart';
import 'package:office_supply_mobile_master/models/company/company.dart';
import 'package:office_supply_mobile_master/models/department/department.dart';
import 'package:office_supply_mobile_master/models/period/period.dart';
import 'package:office_supply_mobile_master/models/user/user.dart' as app_user;
import 'package:office_supply_mobile_master/services/auth.dart';
import 'package:office_supply_mobile_master/services/company.dart';
import 'package:office_supply_mobile_master/services/department.dart';
import 'package:office_supply_mobile_master/services/period.dart';
import 'package:office_supply_mobile_master/services/role.dart';
import 'package:office_supply_mobile_master/services/user.dart';

class SignInProvider with ChangeNotifier {
  late GoogleSignInAccount? googleSignInAccount;
  late GoogleSignInAuthentication? googleSignInAuthentication;
  Auth? auth;
  late app_user.User? user;
  Company? company;
  Department? department;
  Period? period;
  late List<Department> departments;

  Future<bool> isSignedIn() async => await GoogleSignIn().isSignedIn();

  signIn(String regisToken) async {
    await GoogleSignIn().signIn().then((e) => googleSignInAccount = e);
    await googleSignInAccount!.authentication
        .then((e) => googleSignInAuthentication = e);

    await FirebaseAuth.instance.signInWithCredential(
      GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication!.accessToken,
        idToken: googleSignInAuthentication!.idToken,
      ),
    );

    await AuthService.fetchAuth(
      idToken: await FirebaseAuth.instance.currentUser!.getIdToken(),
      regisToken: regisToken,
    ).then((e) => auth = e);

    if (auth != null) {
      await UserService.fetchUser(
        id: auth!.id,
        jwtToken: auth!.jwtToken,
      ).then((e) => user = e);
      await RoleService.fetchRole(
        id: user!.roleID,
        jwtToken: auth!.jwtToken,
      ).then((e) => user!.roleName = e.name);

      if (user!.companyID != null) {
        await CompanyService.fetchCompany(
          id: user!.companyID!,
          jwtToken: auth!.jwtToken,
        ).then((e) => company = e);

        if (user!.departmentID != null) {
          await DepartmentService.fetchDepartment(
            id: user!.departmentID!,
            jwtToken: auth!.jwtToken,
          ).then((e) => department = e);

          await PeriodService.fetchPeriod(
                  departmentId: user!.departmentID!, jwtToken: auth!.jwtToken)
              .then((e) => period = e);
        }

        // get list department if user is manager
        if (user!.roleID == 2) {
          departments = (await DepartmentService.getDepartments(
              userID: user!.id, jwtToken: auth!.jwtToken, all: true))!;
        }
      }
    }
    notifyListeners();
  }

  getUserInfo() async {
    user = await UserService.fetchUser(
      id: auth!.id,
      jwtToken: auth!.jwtToken,
    );
    var role = await RoleService.fetchRole(
      id: user!.roleID,
      jwtToken: auth!.jwtToken,
    );
    user!.roleName = role.name;
  }

  signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    googleSignInAccount = null;
    googleSignInAuthentication = null;
    auth = null;
    user = null;
    company = null;
    department = null;
    period = null;
    notifyListeners();
  }
}
