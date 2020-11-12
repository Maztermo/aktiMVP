import 'package:aktiMVP/widgets/profile_screen%20copy.dart';
import 'package:aktiMVP/widgets/auth.dart';
import 'package:aktiMVP/widgets/not_logged_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab2 extends StatefulWidget {
  @override
  _Tab2State createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthClass>(context).user;

    // return either the Home or Authenticate widget
    if (user == null) {
      return NotLoggedin();
    } else {
      print('Id: ' + user.uid);
      return ProfileScreen2();
    }
  }
}
