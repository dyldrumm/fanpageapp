import 'package:flutter/material.dart';

class Chatroom extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Chatroom> {
  @override
  int index = 0;
  final textController = TextEditingController();
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
                            alignment: Alignment.center,
                            width: 300,
                            padding: EdgeInsets.all(10),
                            child: TextField(
                                controller: textController,
                                decoration:
                                    InputDecoration(hintText: 'Type here')),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 8, right: 8, top: 2, bottom: 2),
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.pink[50],
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  color: Colors.green,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Send",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ]),
              )),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              this.index = index;
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
