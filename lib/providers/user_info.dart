import 'package:flutter/material.dart';

class UserProfileInfo with ChangeNotifier {
  final String userName;
  final String userEmail;
  String userId;
  bool isCompanyUser;
  bool loggedIn;

  UserProfileInfo({
    this.userId,
    this.userName,
    this.userEmail,
    this.isCompanyUser = false,
    this.loggedIn = false,
  });

  void setUserId(id) {
    userId = id;
  }

  void changeToCompanyUser() {
    isCompanyUser = true;
    notifyListeners();
  }

  void changeToPrivateUser() {
    isCompanyUser = false;
    notifyListeners();
  }
}
