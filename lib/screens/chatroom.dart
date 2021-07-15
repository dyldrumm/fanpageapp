import 'package:fanpageapp/objs/currentuser.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpageapp/helpers/auth.dart';
import 'package:fanpageapp/screens/chathome.dart';
import 'package:fanpageapp/screens/profile.dart';

class Chatroom extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Chatroom> {
  @override
  int index = 0;
  // late Stream<QuerySnapshot> messages;
  Widget chatMessages(String chatroomID) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatroomID)
          .collection("messages")
          .snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: (snapshot.data! as QuerySnapshot)
                        .docs[index]
                        .data()!
                        .toString(),
                    sender: CurrentUser.getDisplay() ==
                        (snapshot.data! as QuerySnapshot)
                            .docs[index]
                            .data()!
                            .toString(),
                  );
                })
            : Container();
      },
    );
  }

  final textController = TextEditingController();
  final AuthService _auth = AuthService();
  final FirebaseAuth _fireauth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return new Builder(builder: (chat) {
      return new Scaffold(
        appBar: AppBar(title: Text("Test chat room")),
        backgroundColor: Colors.green[200],
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
                        "Messages",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      new Column(
                        children: <Widget>[
                          Container(
                            // Email text field
                            alignment: Alignment.bottomCenter,
                            width: 300,
                            padding: EdgeInsets.all(10),
                            child: TextField(
                                controller: textController,
                                decoration:
                                    InputDecoration(hintText: 'Type here')),
                          ),
                          Container(
                            child: new Column(children: <Widget>[
                              ElevatedButton(
                                  child: Text('Send'),
                                  onPressed: () async {
                                    Map<String, String> Usermap = {
                                      'message': textController.text,
                                      'sender': CurrentUser.getUid(),
                                    };
                                    FirebaseFirestore.instance
                                        .collection("chatrooms")
                                        .doc("chatroom")
                                        .collection("messages")
                                        .add(Usermap);
                                    textController.clear();
                                  }),
                            ]),
                          )
                        ],
                      ),
                    ]),
              )),
            ],
          ),
        ),
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
      );
    });
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sender;

  MessageTile({required this.message, required this.sender});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: 8, bottom: 8, left: sender ? 0 : 24, right: sender ? 24 : 0),
        alignment: sender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin:
              sender ? EdgeInsets.only(left: 35) : EdgeInsets.only(right: 35),
          padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: sender
                  ? BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomLeft: Radius.circular(23))
                  : BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomRight: Radius.circular(23)),
              gradient: LinearGradient(
                colors: sender
                    ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                    : [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)],
              )),
          child: Text(message,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300)),
        ));
  }
}
