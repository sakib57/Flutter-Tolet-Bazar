import 'package:flutter/material.dart';

class AccountMenu extends StatelessWidget {
  final IconData icon;
  final String title;
  AccountMenu({Key key, @required this.icon, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}
