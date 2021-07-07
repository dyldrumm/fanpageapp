import 'package:fanpageapp/signin.dart';
import 'package:flutter/material.dart';
import 'package:fanpageapp/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpageapp/signin.dart';

class Register extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State {
  final AuthService _auth = AuthService();
  final FirebaseAuth _fireauth = FirebaseAuth.instance;
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
    return new Builder(builder: (reg) {
      return new Scaffold(
        appBar: AppBar(title: Text("Fan Page Registration")),
        backgroundColor: Colors.green[200],
        body: Container(
            alignment: Alignment.center,
            padding: new EdgeInsets.all(40),
            child: new Column(children: <Widget>[
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
                    Map<String, String> Usermap = {
                      'email': emailController.text,
                      'first': firstController.text,
                      'last': lastController.text,
                    };
                    FirebaseFirestore.instance.collection("users").add(Usermap);
                    dynamic result =
                        await _fireauth.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passController.text);
                    if (result == null)
                      print('Error with email registration\n');
                    else {
                      print('Registered with email\n');
                      _showMyDialog();
                      firstController.clear();
                      lastController.clear();
                      emailController.clear();
                      passController.clear();
                    }
                  })
            ])),
      );
    });
  }
}
