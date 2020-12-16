import 'package:flutter/material.dart';
import 'package:tolet_bazar/models/Category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.white70]),
            borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              color: Colors.blue,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              category.categoryName,
              style: TextStyle(color: Colors.blue),
            ),
          ],
        )));
  }
}
