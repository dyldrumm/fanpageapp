import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fanpageapp/loading.dart';
import 'package:fanpageapp/somethingwrong.dart';
import 'package:fanpageapp/chathome.dart';
import 'package:fanpageapp/user.dart';
import 'package:fanpageapp/authenticate.dart';
import 'package:fanpageapp/auth.dart';

class MyApp extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  // The future is part of the state of our widget. We should not call `initializeApp`
  // directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  bool authed = false;

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null)
    //     authed = false;
    //   else
    //     authed = true;
    // });
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasData && authed == true) return Home();
        if (snapshot.hasData && authed == false) return Authenticate();
        if (snapshot.hasError) return SomethingWrong(); // Check for errors
        if (snapshot.connectionState == ConnectionState.done)
          return Home(); // Once complete, show your application
        return Loading(); // Otherwise, show something whilst waiting for initialization to complete
      },
    );
  }
}
