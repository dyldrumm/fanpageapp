import 'package:fanpageapp/screens/registration.dart';
import 'package:fanpageapp/screens/chathome.dart';
import 'package:fanpageapp/objs/currentuser.dart';
import 'package:flutter/material.dart';
import 'package:fanpageapp/helpers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpageapp/objs/user.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final FirebaseAuth _fireauth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: new MediaQueryData(),
        child: MaterialApp(
            home: Scaffold(
          backgroundColor: Colors.green[200],
          appBar: AppBar(title: Text('Chat App Signin')),
          body: Container(
              alignment: Alignment.center,
              padding: new EdgeInsets.all(10),
              child: new Column(children: <Widget>[
                Container(
                  // Email text field
                  alignment: Alignment.center,
                  width: 300,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                      controller: emailController,
                      decoration:
                          InputDecoration(hintText: 'Enter your email')),
                ),
                Container(
                  // Password text field
                  alignment: Alignment.center,
                  width: 300,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                      controller: passController,
                      decoration:
                          InputDecoration(hintText: 'Enter your password')),
                ),
                Builder(
                    // Email sign in button
                    builder: (context) => ElevatedButton(
                        child: Text('Email Signin'),
                        onPressed: () async {
                          Map<String, String> Usermap = {
                            'first': '',
                            'last': '',
                            'email': emailController.text,
                          };
                          FirebaseFirestore.instance
                              .collection("users")
                              .add(Usermap);
                          dynamic result =
                              await _fireauth.signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passController.text);
                          if (result == null)
                            print('Error with email signin\n');
                          else {
                            print('Signed in with email\n');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          }
                        })),
                Builder(
                    // Guest sign in button
                    builder: (context) => ElevatedButton(
                        child: Text('Guest Signin'),
                        onPressed: () async {
                          dynamic result = await _auth.signInAnon();
                          if (result == null)
                            print('Error with anonymous signin\n');
                          else {
                            print('Signed in anonymously\n');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          }
                        })),
                Builder(
                    // Registration button
                    builder: (context) => ElevatedButton(
                        child: Text('Registration '),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        }))
              ])),
        )));
  }
}

// uploadUserInfo(userMap user) {
//       FirebaseFirestore.instance.collection("users").add(user);
//     }