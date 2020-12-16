import 'package:flutter/material.dart';

class AccountCounter extends StatelessWidget {
  final String title;
  final String value;
  AccountCounter({
    @required this.value,
    @required this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: 140.0,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(6.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          Text(title,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
