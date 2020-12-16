import 'package:flutter/material.dart';

class MyPosts extends StatefulWidget {
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Posts"),
          centerTitle: true,
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            //labelColor: Colors.bl,
            tabs: [
              Tab(
                child: Text("Upcomming"),
              ),
              Tab(
                child: Text("Previous"),
              )
            ],
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          bottomOpacity: 1,
        ),
        body: TabBarView(
          children: [
            Center(child: Text("Call Tab Bar View")),
            Center(child: Text("Chats Tab Bar View")),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
