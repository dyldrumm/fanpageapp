import 'package:fanpageapp/objs/user.dart';
// import 'package:fanpageapp/sharedpref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@override
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  dynamic user;

  //Create local user object based on Firebase User
  MyUser _firebaseUser(User? user) {
    return MyUser(uid: user!.uid);
  }

  // User auth change stream
  // Stream<MyUser> get userStream {
  //   return _auth
  //       .authStateChanges()
  //       // .map((User user) => _firebaseUser(user));
  //       .map(_firebaseUser);
  // }

  // Anonymous signin
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      dynamic user = result.user;
      return _firebaseUser(user);
    } catch (e) {
      print('Signin error\n' + e.toString());
      return null;
    }
  }

  signInGoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication signInAuth =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: signInAuth.idToken, accessToken: signInAuth.accessToken);

    UserCredential result =
        await _firebaseAuth.signInWithCredential(credential);

    User? googleUser = result.user;

    Map<String, String?> Usermap = {
      'email': googleUser?.email,
    };
    FirebaseFirestore.instance.collection("users").add(Usermap);
  }
}
