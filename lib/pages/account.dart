import 'dart:ui';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:tolet_bazar/components/account_counter.dart';
import 'package:tolet_bazar/components/account_menu.dart';
import 'package:tolet_bazar/components/account_page_background.dart';
import 'package:tolet_bazar/constants.dart';
import 'package:tolet_bazar/pages/create_post.dart';
import 'package:tolet_bazar/pages/my_posts.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              AccountPageBackground(
                  screenHeight: MediaQuery.of(context).size.height * .70),
              Container(
                height: MediaQuery.of(context).size.height * 0.38,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProfileAvatar(
                      "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg",
                      borderWidth: 6.0,
                      radius: 80.0,
                      cacheImage: true,
                    ),
                    Text(
                      "John Doe",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "example@gmail.com",
                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Positioned(
                  top: 42.0,
                  right: -5,
                  child: RaisedButton(
                    color: accentColor,
                    padding: EdgeInsets.all(12.0),
                    shape: CircleBorder(),
                    onPressed: () {},
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyPosts()));
                  },
                  child: AccountCounter(
                    title: "My Posts",
                    value: "68",
                  ),
                ),
                AccountCounter(value: "235", title: "Folower"),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreatePost()));
                      },
                      child: AccountMenu(
                        icon: Icons.edit,
                        title: "Create New Post",
                      ),
                    ),
                    AccountMenu(
                      icon: Icons.location_pin,
                      title: "Preferred Area",
                    ),
                    AccountMenu(
                      icon: Icons.notifications,
                      title: "Notifications",
                    ),
                    AccountMenu(
                      icon: Icons.settings,
                      title: "Settings",
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
