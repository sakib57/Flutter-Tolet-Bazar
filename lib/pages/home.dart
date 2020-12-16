import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tolet_bazar/components/categories.dart';
import 'package:tolet_bazar/components/home_page_background.dart';
import 'package:tolet_bazar/components/home_post_card.dart';
import 'package:tolet_bazar/constants.dart';
import 'package:tolet_bazar/data/app_data.dart';
import 'package:tolet_bazar/services/category_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            shape: _DiamondBorder(),
            onPressed: () {},
            child: Icon(Icons.notifications),
          ),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: Badge(
              badgeColor: accentColor,
              animationType: BadgeAnimationType.scale,
              badgeContent: Text(
                '3',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: <Widget>[
              HomePageBackground(
                  screenHeight: MediaQuery.of(context).size.height),
              SafeArea(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: FutureBuilder(
                      future: appData.fetchCategories(),
                      builder: (context, snapshot) => snapshot.hasData
                          ? Categories(
                              categories: snapshot.data,
                            )
                          : Center(
                              child: Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Image.asset(
                                "assets/ld.gif",
                                width: 150.0,
                                height: 150.0,
                              ),
                            )),
                    ),
                  ),
                ],
              )),
              Positioned(
                bottom: 0.0,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                    margin: EdgeInsets.symmetric(horizontal: 100.0),
                    decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(50.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blueGrey,
                              blurRadius: 3.0,
                              spreadRadius: 0.2,
                              offset: Offset(0.7, 0.3))
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Create Post",
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 5.0),
            child: Text(
              "Recent",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                HomePostCard(),
                HomePostCard(),
                HomePostCard(),
                HomePostCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _DiamondBorder extends ShapeBorder {
  const _DiamondBorder();

  @override
  EdgeInsetsGeometry get dimensions {
    return const EdgeInsets.only();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return Path()
      ..moveTo(rect.left + rect.width / 2.0, rect.top)
      ..lineTo(rect.right, rect.top + rect.height / 2.0)
      ..lineTo(rect.left + rect.width / 2.0, rect.bottom)
      ..lineTo(rect.left, rect.top + rect.height / 2.0)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  // This border doesn't support scaling.
  @override
  ShapeBorder scale(double t) {
    return null;
  }
}
