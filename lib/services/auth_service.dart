import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle() async {
    try {
      // begin interactive signin process
      final GoogleSignInAccount? guser = await GoogleSignIn().signIn();

      // obtain auth details from request
      final GoogleSignInAuthentication gAuth = await guser!.authentication;

      // create a new creadential for user
      final credentials = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // lets sign in
      return await FirebaseAuth.instance.signInWithCredential(credentials);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> signOut() async {
    // Sign out from Google
    await GoogleSignIn().signOut();
    // Sign out from Firebase Auth
    await FirebaseAuth.instance.signOut();
  }
}
