import 'package:flutter/material.dart';

class TitleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 30,
        width: 180,
        margin: EdgeInsets.only(top: 20, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Aktive Billetter',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(
                    63, 107, 71, 1), //Color.fromRGBO(129, 168, 121, 1),
              ),
            ),
            // Container(
            //   height: 2.0,
            //   width: 180.0,
            //   color: Color.fromRGBO(129, 168, 121, 1),
            // ),
          ],
        ),
      ),
    );
  }
}
