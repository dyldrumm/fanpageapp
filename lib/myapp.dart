import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fanpageapp/Loading.dart';
import 'package:fanpageapp/SomethingWrong.dart';
import 'package:fanpageapp/AwesomeApp.dart';

class MyApp extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasData) return MyAwesomeApp();
        if (snapshot.hasError) return SomethingWrong(); // Check for errors
        if (snapshot.connectionState == ConnectionState.done)
          return MyAwesomeApp(); // Once complete, show your application
        return Loading(); // Otherwise, show something whilst waiting for initialization to complete
      },
    );
  }
}
