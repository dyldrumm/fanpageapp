import 'package:fanpageapp/screens/newchat.dart';
import 'package:flutter/material.dart';
import 'package:fanpageapp/helpers/auth.dart';
import 'package:fanpageapp/screens/chatroom.dart';
import 'package:fanpageapp/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  int users = 0;
  String title = '';
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  @override
  final AuthService _auth = AuthService();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return new Builder(builder: (reg) {
      return new Scaffold(
        appBar: AppBar(title: Text("Chat App Home Screen")),
        backgroundColor: Colors.green[200],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (int index) {
            setState(() {
              this.index = index;
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              }
            });
          },
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey.shade600,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.blue),
              title: Text("Search", style: TextStyle(color: Colors.blue)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message, color: Colors.blue),
              title: Text("Chats",
                  style: TextStyle(
                    color: Colors.blue,
                  )),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box, color: Colors.blue),
              title: Text("Profile", style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Conversations",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      Container(
                          child: new Column(children: <Widget>[
                        Builder(
                            builder: (context) => ElevatedButton(
                                child: Text('Test Chatroom'),
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Chatroom()),
                                  );
                                })),
                      ])),
                      Container(
                          padding: EdgeInsets.only(
                              left: 8, right: 8, top: 2, bottom: 2),
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.blue[100],
                          ),
                          child: new ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewChat()),
                                );
                              },
                              child: Text('Create new chat'))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

// class _State extends State {
//   final AuthService _auth = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return new Builder(builder: (home) {
//       return new Scaffold(
//         appBar: AppBar(title: Text("Fan Page Registration")),
//         backgroundColor: Colors.green[200],
//       );
//     });
//   }
// }
