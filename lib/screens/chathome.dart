import 'package:fanpageapp/objs/currentuser.dart';
import 'package:fanpageapp/screens/newchat.dart';
import 'package:flutter/material.dart';
import 'package:fanpageapp/helpers/auth.dart';
import 'package:fanpageapp/screens/chatroom.dart';
import 'package:fanpageapp/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:fanpageapp/helpers/adhelper.dart';

class Home extends StatefulWidget {
  int users = 0;
  String title = '';
  @override
  _State createState() => _State();
}

// @override
// void initState() {
//   // TODO: Initialize _bannerAd
//   BannerAd _bannerAd = BannerAd(
//     adUnitId: AdHelper.bannerAdUnitId,
//     request: AdRequest(),
//     size: AdSize.banner,
//     listener: BannerAdListener(
//       onAdLoaded: (_) {
//         setState(() {
//           _isBannerAdReady = true;
//         });
//       },
//       onAdFailedToLoad: (ad, err) {
//         print('Failed to load a banner ad: ${err.message}');
//         _isBannerAdReady = false;
//         ad.dispose();
//       },
//     ),
//   );

//   _bannerAd.load();
// }

class _State extends State<Home> {
  @override
  final AuthService _auth = AuthService();
  int index = 0;
  int indexx = 0;

  @override
  Widget build(BuildContext context) {
    return new Builder(builder: (reg) {
      return new Scaffold(
        appBar: AppBar(title: Text("Chat App Home Screen")),
        backgroundColor: Colors.green[200],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (int indexx) {
            setState(() {
              this.index = index;
              if (indexx == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              } else if (indexx == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              } else if (indexx == 2) {
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
                      Container(
                          child: new Column(children: <Widget>[
                        Builder(
                            builder: (context) => new Scaffold(
                                  backgroundColor: Colors.green[200],
                                  body: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SafeArea(
                                            child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 16, right: 16, top: 10),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection("users")
                                                      .doc(CurrentUser
                                                          .getEmail())
                                                      .collection("chats")
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    return snapshot.hasData
                                                        ? ListView.builder(
                                                            itemCount: (snapshot
                                                                        .data!
                                                                    as QuerySnapshot)
                                                                .docs
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return ChatTile(
                                                                  title: (snapshot
                                                                              .data!
                                                                          as QuerySnapshot)
                                                                      .docs[
                                                                          index]
                                                                      .data()!
                                                                      .toString());
                                                            })
                                                        : Container();
                                                  },
                                                ),
                                                new Column(),
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
                                            MaterialPageRoute(
                                                builder: (context) => Home()),
                                          );
                                        } else if (index == 1) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()),
                                          );
                                        } else if (index == 2) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Profile()),
                                          );
                                        }
                                      });
                                    },
                                    selectedItemColor: Colors.red,
                                    unselectedItemColor: Colors.grey.shade600,
                                    selectedLabelStyle:
                                        TextStyle(fontWeight: FontWeight.w600),
                                    unselectedLabelStyle:
                                        TextStyle(fontWeight: FontWeight.w600),
                                    type: BottomNavigationBarType.fixed,
                                    items: [
                                      BottomNavigationBarItem(
                                        icon: Icon(Icons.message,
                                            color: Colors.blue),
                                        title: Text("Chats",
                                            style: TextStyle(
                                              color: Colors.blue,
                                            )),
                                      ),
                                      BottomNavigationBarItem(
                                        icon: Icon(Icons.account_box,
                                            color: Colors.blue),
                                        title: Text("Profile",
                                            style:
                                                TextStyle(color: Colors.blue)),
                                      ),
                                    ],
                                  ),
                                )),
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

Future<InitializationStatus> _initGoogleMobileAds() {
  // COMPLETE: Initialize Google Mobile Ads SDK
  return MobileAds.instance.initialize();
}

class ChatTile extends StatelessWidget {
  final String title;

  ChatTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
          child: Text(title,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300)),
        ));
  }
}
