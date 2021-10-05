import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController with ChangeNotifier {
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  GoogleSignInAuthentication? googleAuth;
  OAuthCredential? credential;

  signIn() async {
    googleSignInAccount = await _googleSignIn.signIn();
    googleAuth = await googleSignInAccount!.authentication;
    credential = GoogleAuthProvider.credential(
      accessToken: googleAuth!.accessToken,
      idToken: googleAuth!.idToken,
    );
    // ignore: avoid_print
    print(
        "accessToken: ${googleAuth!.accessToken} - idToken: ${googleAuth!.idToken}");
    await FirebaseAuth.instance.signInWithCredential(credential!);
    notifyListeners();
  }

  signOut() async {
    googleSignInAccount = await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
