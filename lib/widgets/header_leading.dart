import 'package:flutter/material.dart';

class LeadingHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/headerbike.png',
            height: 225,
            fit: BoxFit.fitHeight,
          ),
          Positioned(
            top: 40,
            right: 30,
            child: Image.asset(
              'assets/images/logoTry1.png',
              height: 50,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}
