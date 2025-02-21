import 'package:eventgo/pages/bottomnav.dart';
import 'package:eventgo/services/database.dart';
import 'package:eventgo/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  getCurrentUser() async {
    return auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken);

    UserCredential result = await firebaseAuth.signInWithCredential(credential);

    User? userDetails = result.user;
    await SharedpreferenceHelper().saveUserEmail(userDetails!.email!);
    await SharedpreferenceHelper().saveUserName(userDetails.displayName!);
    await SharedpreferenceHelper().saveUserImage(userDetails.photoURL!);
    await SharedpreferenceHelper().saveUserId(userDetails.uid);

    Map<String, dynamic> userdata = {
      "Name": userDetails!.displayName,
      "Email": userDetails.email,
      "Image": userDetails.photoURL,
      "Id": userDetails.uid,
    };
    await DatabaseMethods()
        .addUserDetail(userdata, userDetails.uid)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Registered Successfully!!!",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          )));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const BottomNav()));
    });
  }
}
