import 'package:flutter/material.dart';
import 'package:fanpageapp/helpers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpageapp/screens/signin.dart';
import 'dart:math';
import 'dart:convert';

class Register extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State {
  final AuthService _auth = AuthService();
  final FirebaseAuth _fireauth = FirebaseAuth.instance;
  final displayController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final firstController = TextEditingController();
  final lastController = TextEditingController();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Email Registration'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Registered with email'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String randID = '';
    return new Builder(builder: (reg) {
      return new Scaffold(
        appBar: AppBar(title: Text("Fan Page Registration")),
        backgroundColor: Colors.green[200],
        body: Container(
            alignment: Alignment.center,
            padding: new EdgeInsets.all(40),
            child: new Column(children: <Widget>[
              TextField(
                  controller: displayController,
                  decoration:
                      InputDecoration(hintText: 'Enter your display name')),
              TextField(
                  controller: firstController,
                  decoration:
                      InputDecoration(hintText: 'Enter your first name')),
              TextField(
                  controller: lastController,
                  decoration:
                      InputDecoration(hintText: 'Enter your last name')),
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: 'Enter your email')),
              TextField(
                  controller: passController,
                  decoration: InputDecoration(hintText: 'Enter your password')),
              ElevatedButton(
                  child: Text('Register with email'),
                  onPressed: () async {
                    dynamic result =
                        await _fireauth.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passController.text);
                    if (result == null)
                      print('Error with email registration\n');
                    else {
                      randID = getRandString(8);
                      Map<String, String> Usermap = {
                        'email': emailController.text,
                        'first': firstController.text,
                        'last': lastController.text,
                        'userID': randID,
                        'username': displayController.text,
                        'chats': '',
                      };
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(emailController.text)
                          .set(Usermap);
                      print('Registered with email\n');
                      _showMyDialog();
                      displayController.clear();
                      firstController.clear();
                      lastController.clear();
                      emailController.clear();
                      passController.clear();
                    }
                  }),
              // ElevatedButton(
              //     child: Text('Register with google'),
              //     onPressed: () async {
              //       dynamic result =
              //           await _fireauth.createUserWithEmailAndPassword(
              //               email: emailController.text,
              //               password: passController.text);
              //       if (result == null)
              //         print('Error with Google registration\n');
              //       else {
              //         Map<String, String> Usermap = {
              //           'email': emailController.text,
              //           'first': firstController.text,
              //           'last': lastController.text,
              //         };
              //         FirebaseFirestore.instance
              //             .collection("users")
              //             .add(Usermap);
              //         print('Registered with Google\n');
              //         _showMyDialog();
              //         firstController.clear();
              //         lastController.clear();
              //         emailController.clear();
              //         passController.clear();
              //       }
              //     })
            ])),
      );
    });
  }
}

String getRandString(int len) {
  var random = Random.secure();
  var values = List<int>.generate(len, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}
