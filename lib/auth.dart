import 'package:fanpageapp/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

@override
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  dynamic user;

  //Create local user object based on Firebase User
  MyUser _firebaseUser(User? user) {
    return MyUser(uid: user!.uid);
  }

  // User auth change stream
  // Stream<MyUser> get userStream {
  //   return _auth
  //       .authStateChanges()
  //       // .map((User user) => _firebaseUser(user));
  //       .map(_firebaseUser);
  // }

  // Anonymous signin
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      dynamic user = result.user;
      return _firebaseUser(user);
    } catch (e) {
      print('Signin error\n' + e.toString());
      return null;
    }
  }
}
