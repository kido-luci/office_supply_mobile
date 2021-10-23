// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:office_supply_mobile_master/api/auth.dart';
import 'package:office_supply_mobile_master/models/auth.dart';
//import 'package:http/http.dart' as http;

class GoogleSignInController with ChangeNotifier {
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  GoogleSignInAuthentication? googleAuth;
  OAuthCredential? credential;
  late Auth auth;

  signIn() async {
    googleSignInAccount = await _googleSignIn.signIn();
    googleAuth = await googleSignInAccount!.authentication;
    credential = GoogleAuthProvider.credential(
      accessToken: googleAuth!.accessToken,
      idToken: googleAuth!.idToken,
    );
    //print(
    //    "- accessToken: ${googleAuth!.accessToken} \n- idToken: ${googleAuth!.idToken}");

    //!google
    //print('google ' + googleSignInAccount!.photoUrl.toString());
    //print('google ' + googleAuth!.idToken!);

    //!firebase
    final user =
        (await FirebaseAuth.instance.signInWithCredential(credential!)).user;

    String idToken = await user!.getIdToken();
    //final token = idToken.token;
    //print('firebase ' + user.photoURL!);
    print('firebase ' + idToken);

    await AuthAPI.fetchAuth(
      //client: http.Client(),
      //idToken: googleAuth!.accessToken!,
      idToken: idToken,
    ).then((e) => auth = e);
    notifyListeners();
  }

  signOut() async {
    googleSignInAccount = await _googleSignIn.signOut();
    //await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
