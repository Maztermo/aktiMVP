import 'package:aktiMVP/screens/add_ticket_screen.dart';
import 'package:aktiMVP/screens/favs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aktiMVP/widgets/auth.dart';
import 'package:aktiMVP/widgets/not_logged_in.dart';
import 'package:aktiMVP/widgets/cloud_functions.dart';

class Tab1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthClass>(context).user;
    Widget showScreen;

    // return either the Home or Authenticate widget
    if (user == null) {
      return NotLoggedin();
    } else {
      final DatabaseService _cloud = DatabaseService();
      Future<Map<String, dynamic>> userData = _cloud.getUserData();
      return FutureBuilder(
        future: userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['isCompanyUser']) {
              showScreen = AddTicketForm();
            } else {
              showScreen = MyFavs();
            }
          } else {
            showScreen = NotLoggedin();
          }
          return showScreen;
        },
      );
    }
  }
}
