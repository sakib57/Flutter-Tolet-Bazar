import 'dart:ui';

import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  final TextStyle style = TextStyle(
      color: Colors.blueGrey[800], fontWeight: FontWeight.bold, fontSize: 15.0);
  final Color iconColor = Colors.blueGrey[800];
  final double iconSize = 19.0;
  final String image, targetMonth, category, location, rent, bed;
  PostTile({
    @required this.image,
    @required this.targetMonth,
    @required this.category,
    @required this.location,
    @required this.rent,
    @required this.bed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("fgdfgd");
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0,
                  spreadRadius: 0.6,
                  offset: Offset(0.7, 0.7))
            ]),
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0)),
              child: Image.asset(
                image,
                width: 120.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.event_note,
                      color: iconColor,
                      size: iconSize,
                    ),
                    SizedBox(width: 2.0),
                    Text(
                      targetMonth,
                      style: style,
                    ),
                    SizedBox(
                      width: 35.0,
                    ),
                    Icon(
                      Icons.category,
                      color: iconColor,
                      size: iconSize,
                    ),
                    SizedBox(width: 2.0),
                    Text(
                      category,
                      style: style,
                    )
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: iconColor,
                      size: iconSize,
                    ),
                    SizedBox(width: 2.0),
                    Text(
                      location,
                      style: style,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.local_atm,
                      color: iconColor,
                      size: iconSize,
                    ),
                    SizedBox(width: 2.0),
                    Text(
                      rent,
                      style: style,
                    ),
                    SizedBox(
                      width: 85.0,
                    ),
                    Icon(
                      Icons.local_hotel,
                      color: iconColor,
                      size: iconSize,
                    ),
                    SizedBox(width: 2.0),
                    Text(
                      bed,
                      style: style,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
