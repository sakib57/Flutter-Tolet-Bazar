import 'package:tolet_bazar/models/Category.dart';

import '../models/Category.dart';
import 'package:flutter/material.dart';

import 'category_card.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key key,
    this.categories,
  }) : super(key: key);

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: categories.length > 9 ? 9 : categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.5),
          itemBuilder: (context, index) => CategoryCard(
                category: categories[index],
              )),
    );
  }
}
