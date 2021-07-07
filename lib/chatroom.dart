import 'package:flutter/material.dart';

class Chatroom extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Chatroom> {
  @override
  Widget build(BuildContext context) {
    return new Builder(builder: (chat) {
      return new Scaffold(
        appBar: AppBar(title: Text("Test chat room")),
        backgroundColor: Colors.green[200],
        bottomNavigationBar: BottomNavigationBar(
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
