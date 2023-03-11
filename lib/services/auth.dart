import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/models/myuser.dart';

import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? _userFromFirebaseUser(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<MyUser> get user {
    return _auth.authStateChanges().map(
          (User? user) => _userFromFirebaseUser(user!)!,
        );
  }

  //=====> sign in anonymous
  Future signInAnon() async {
    try {
      final result = await _auth.signInAnonymously();
      User? xuser = result.user;
      print("Signed in with temporary account.");
      return _userFromFirebaseUser(xuser!);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
      return null;
    }
  }

  //=====> sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? fbuser = result.user;
      return fbuser;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //=====> register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      final result =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? fbuser = result.user;
      await DatabaseService(uid: fbuser!.uid).updateUserData('0', 'new crew member', 100);

      return _userFromFirebaseUser(fbuser);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //=====> sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
