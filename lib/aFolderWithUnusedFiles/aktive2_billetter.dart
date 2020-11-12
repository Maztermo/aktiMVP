import 'package:flutter/material.dart';

class Aktive2Billetter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 50,
        width: 260,
        margin: EdgeInsets.only(top: 10, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tilbud',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: Color.fromRGBO(129, 168, 121, 1),
              ),
            ),
            Container(
              height: 2.0,
              width: 200.0,
              color: Color.fromRGBO(129, 168, 121, 1),
            ),
          ],
        ),
      ),
    );

    // GridView(
    //   physics: NeverScrollableScrollPhysics(),
    //   padding: const EdgeInsets.all(5),
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 3,
    //     childAspectRatio: 2.5,
    //     crossAxisSpacing: 1,
    //     mainAxisSpacing: 1,
    //   ),
    //   children: [
    //     CategoryCard('Natur', Icons.directions_walk),
    //     CategoryCard('Mat', Icons.restaurant),
    //     CategoryCard('Nordlys', Icons.satellite),
    //     CategoryCard('Hotel', Icons.hotel),
    //     CategoryCard('Museum', Icons.home),
    //     CategoryCard('Ribb-båt', Icons.directions_boat),
    //   ],
    // ),
  }
}
