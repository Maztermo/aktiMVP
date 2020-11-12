import 'package:aktiMVP/providers/user_info.dart';
import 'package:aktiMVP/widgets/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthClass extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Create UserProfileObject based on FIrebaseUser
  UserProfileInfo _userFromFirebase(User user) {
    return user != null ? UserProfileInfo(userId: user.uid) : null;
  }

// sign in with email & pw
  Future signIn(email, password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  User get user {
    return _auth.currentUser;
  }

// register with email & pw
  Future registerWithEmailAndPassword(
      String email, String password, String navn, bool isCompanyUser) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user;

      // create a new document for the user with the uid
      await DatabaseService().updateUserData(navn, email, isCompanyUser);
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // delete le user
  Future deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser.delete();
    } catch (e) {
      print(
          'The user must reauthenticate before this operation can be executed.');
    }
  }
}
