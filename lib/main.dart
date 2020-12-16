import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tolet_bazar/data/app_data.dart';
import 'package:tolet_bazar/pages/account.dart';
import 'package:tolet_bazar/pages/favorite.dart';
import 'package:tolet_bazar/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _mainColor = '#0d4957';
  var _currentIndex = 1;
  final List<Widget> _pages = [Favorite(), Home(), Account()];

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        buttonBackgroundColor: themeData.primaryColor,
        color: themeData.primaryColor,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.search_sharp,
            size: 26.0,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            size: 26.0,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 26.0,
            color: Colors.white,
          ),
        ],
        animationCurve: Curves.bounceInOut,
        animationDuration: Duration(milliseconds: 200),
        index: _currentIndex,
        onTap: (index) {
          //debugPrint("$index");
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
