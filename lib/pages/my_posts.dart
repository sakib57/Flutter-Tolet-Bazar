import 'package:flutter/material.dart';
import 'package:tolet_bazar/components/post_tile.dart';

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
            //labelColor: Colors.black,
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
            // ====== Upcoming Posts =======
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  PostTile(
                    image: "assets/dd.jpg",
                    targetMonth: "January 2021",
                    category: "Family",
                    location: "Chourhash Kushtia",
                    rent: "37000",
                    bed: "4",
                  ),
                  PostTile(
                    image: "assets/ee.jpg",
                    targetMonth: "February 2021",
                    category: "Bachelor",
                    location: "Mojompur Kushtia",
                    rent: "23000",
                    bed: "2",
                  ),
                ],
              ),
            ),
            // ====== Previous Posts =======
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  PostTile(
                    image: "assets/ee.jpg",
                    targetMonth: "February 2021",
                    category: "Bachelor",
                    location: "Mojompur Kushtia",
                    rent: "23000",
                    bed: "2",
                  ),
                  PostTile(
                    image: "assets/dd.jpg",
                    targetMonth: "January 2021",
                    category: "Family",
                    location: "Chourhash Kushtia",
                    rent: "37000",
                    bed: "4",
                  ),
                ],
              ),
            ),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
