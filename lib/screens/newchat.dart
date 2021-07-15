import 'package:fanpageapp/objs/currentuser.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpageapp/helpers/auth.dart';
import 'package:fanpageapp/screens/chathome.dart';
import 'dart:math';
import 'dart:convert';

class NewChat extends StatefulWidget {
  @override
  _NewChatState createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  final AuthService _auth = AuthService();
  final FirebaseAuth _fireauth = FirebaseAuth.instance;
  String randID = '';
  String? currUser = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    final userController = TextEditingController();
    final nameController = TextEditingController();
    return new Builder(builder: (reg) {
      return new Scaffold(
          appBar: AppBar(title: Text("Create new chat")),
          backgroundColor: Colors.green[200],
          body: Container(
            alignment: Alignment.center,
            padding: new EdgeInsets.all(40),
            child: new Column(children: <Widget>[
              TextField(
                  controller: userController,
                  decoration: InputDecoration(hintText: 'Enter user email')),
              TextField(
                  controller: nameController,
                  decoration:
                      InputDecoration(hintText: 'Enter chat room name')),
              ElevatedButton(
                  child: Text('Create chat'),
                  onPressed: () async {
                    randID = getRandString(8);
                    FirebaseFirestore.instance
                        .collection("chatrooms")
                        .doc(randID)
                        .set({'chatID': randID});
                    FirebaseFirestore.instance
                        .collection("chatrooms")
                        .doc(randID)
                        .collection("users")
                        .doc('user1')
                        .set({'user1': currUser});
                    FirebaseFirestore.instance
                        .collection("chatrooms")
                        .doc(randID)
                        .collection("users")
                        .doc('user2')
                        .set({'user2': userController.text});
                    FirebaseFirestore.instance
                        .collection("chatrooms")
                        .doc(randID)
                        .collection("messages")
                        .doc('testmessage')
                        .set({
                      'message': "idk, something",
                      'sender': "idk, me?"
                    });
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(CurrentUser.getEmail())
                        .collection("chats")
                        .doc(randID)
                        .set({'title': nameController.text});
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(userController.text)
                        .collection("chats")
                        .doc(randID)
                        .set({'title': nameController.text});
                    userController.clear();
                    nameController.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  }),
            ]),
          ));
    });
  }
}

String getRandString(int len) {
  var random = Random.secure();
  var values = List<int>.generate(len, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}
