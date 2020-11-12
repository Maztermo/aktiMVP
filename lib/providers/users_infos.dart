import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aktiMVP/models/http_exception.dart';

import 'user_info.dart';

class UserProfileInfos with ChangeNotifier {
  UserProfileInfo loggedInUser;
  List<UserProfileInfo> _userProfileInfos = [];

  List<UserProfileInfo> get userProfileInfos {
    return [..._userProfileInfos];
  }

  // List<UserProfileInfo> get favoriteUserProfileInfos {
  //   return _userProfileInfo
  //       .where((indexedUserProfileInfo) => indexedUserProfileInfo.isFavorite)
  //       .toList();
  // }

  UserProfileInfo findById(String id) {
    return _userProfileInfos.firstWhere(
        (indexedUserProfileInfo) => indexedUserProfileInfo.userId == id);
  }

  Future<void> fetchAndSetUserProfileInfos() async {
    const url =
        'https://my-first-project-de6c8.firebaseio.com/UserProfileInfos.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<UserProfileInfo> loadedUserProfileInfos = [];
      extractedData.forEach((userProfileInfoId, userProfileInfoData) {
        loadedUserProfileInfos.add(UserProfileInfo(
          userId: userProfileInfoId,
          userName: userProfileInfoData['userName'],
          userEmail: userProfileInfoData['userEmail'],
          isCompanyUser: userProfileInfoData['isCompanyUser'],
        ));
      });
      _userProfileInfos = loadedUserProfileInfos;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addUserToDatabase(UserProfileInfo userProfileInfo) async {
    const url =
        'https://my-first-project-de6c8.firebaseio.com/UserProfileInfos.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'userName': userProfileInfo.userName,
          'userEmail': userProfileInfo.userEmail,
          'isCompanyUser': userProfileInfo.isCompanyUser,
        }),
      );
      final newUser = UserProfileInfo(
        userName: userProfileInfo.userName,
        userEmail: userProfileInfo.userEmail,
        isCompanyUser: userProfileInfo.isCompanyUser,
        userId: json.decode(response.body)['name'],
      );
      _userProfileInfos.add(newUser);
      print(_userProfileInfos[0]);
      // _userProfileInfo.insert(0, newUser); // at the start of the list
      UserProfileInfo().setUserId(newUser.userId);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateUserInfo(
      String id, UserProfileInfo newUserProfileInfo) async {
    final userProfileInfoIndex = _userProfileInfos
        .indexWhere((userProfileInfo) => userProfileInfo.userId == id);
    if (userProfileInfoIndex >= 0) {
      final url =
          'https://my-first-project-de6c8.firebaseio.com/UserProfileInfos/$id.json';
      await http.patch(url,
          body: json.encode({
            'userName': newUserProfileInfo.userName,
            'description': newUserProfileInfo.userEmail,
          }));
      _userProfileInfos[userProfileInfoIndex] = newUserProfileInfo;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteUserFromDatabase(String id) async {
    final url =
        'https://my-first-project-de6c8.firebaseio.com/UserProfileInfos/$id.json';
    final existingUserProfileInfoIndex = _userProfileInfos
        .indexWhere((userProfileInfo) => userProfileInfo.userId == id);
    var existingUserProfileInfo =
        _userProfileInfos[existingUserProfileInfoIndex];
    _userProfileInfos.removeAt(existingUserProfileInfoIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _userProfileInfos.insert(
          existingUserProfileInfoIndex, existingUserProfileInfo);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingUserProfileInfo = null;
  }
}
