import 'package:flutter/material.dart';
import 'package:fanpageapp/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State {
  final AuthService _auth = AuthService();
  final FirebaseAuth _fireauth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passController = TextEditingController();

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
                      print('Registered with email\n');
                      print(result);
                    }
                  })
            ])),
      );
    });
  }
}
