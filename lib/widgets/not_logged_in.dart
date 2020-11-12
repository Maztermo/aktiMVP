import 'package:flutter/material.dart';

import 'package:aktiMVP/screens/auth_screen.dart';

class NotLoggedin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('Du er ikke logget inn \n Trykk her for å ordne det!'),
        onPressed: () {
          Navigator.pushReplacementNamed(context, AuthScreen.routeName);
        },
      ),
    );
  }
}
