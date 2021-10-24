import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:office_supply_mobile_master/models/auth/auth.dart';
import 'package:office_supply_mobile_master/models/role/role.dart';
import 'package:office_supply_mobile_master/models/user/user.dart' as app_user;
import 'package:office_supply_mobile_master/services/auth.dart';
import 'package:office_supply_mobile_master/services/role.dart';
import 'package:office_supply_mobile_master/services/user.dart';

class GoogleSignInController with ChangeNotifier {
  late GoogleSignInAccount? googleSignInAccount;
  late GoogleSignInAuthentication? googleSignInAuthentication;
  late Auth? auth;
  late app_user.User user;
  late Role userRole;

  Future<bool> isSignedIn() async => await GoogleSignIn().isSignedIn();

  signIn() async {
    await GoogleSignIn().signIn().then((e) => googleSignInAccount = e);
    await googleSignInAccount!.authentication
        .then((e) => googleSignInAuthentication = e);

    await FirebaseAuth.instance.signInWithCredential(
      GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication!.accessToken,
        idToken: googleSignInAuthentication!.idToken,
      ),
    );

    await AuthAPI.fetchAuth(
      idToken: await FirebaseAuth.instance.currentUser!.getIdToken(),
      signOut: signOut,
    ).then((e) => auth = e);

    if (auth != null) {
      await UserAPI.fetchUser(
        id: auth!.id,
        jwtToken: auth!.jwtToken,
      ).then((e) => user = e);
      await RoleAPI.fetchRole(
        id: user.roleID,
        jwtToken: auth!.jwtToken,
      ).then((e) => userRole = e);
    }
    notifyListeners();
  }

  signOut() async {
    googleSignInAuthentication = null;
    auth = null;
    await GoogleSignIn().signOut().then((e) => googleSignInAccount = e);
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
