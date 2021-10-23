import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:office_supply_mobile_master/api/auth.dart';
import 'package:office_supply_mobile_master/models/auth/auth.dart';

class GoogleSignInController with ChangeNotifier {
  late GoogleSignInAccount? googleSignInAccount;
  late GoogleSignInAuthentication? googleAuth;
  late Auth auth;

  signIn() async {
    googleSignInAccount = await GoogleSignIn().signIn();
    googleAuth = await googleSignInAccount!.authentication;

    await FirebaseAuth.instance.signInWithCredential(
      GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken,
        idToken: googleAuth!.idToken,
      ),
    );

    await AuthAPI.fetchAuth(
      idToken: await FirebaseAuth.instance.currentUser!.getIdToken(),
      signOut: signOut,
    ).then((e) => auth = e);
    notifyListeners();
  }

  signOut() async {
    googleSignInAccount = await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
