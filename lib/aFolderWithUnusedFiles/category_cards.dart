import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final IconData categoryIcon;
  final String categoryName;

  CategoryCard(this.categoryName, this.categoryIcon);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  categoryIcon,
                  color: Color.fromRGBO(129, 168, 121, 1),
                ),
              ),
              Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
