import 'package:flutter/material.dart';

class HomePostCard extends StatelessWidget {
  const HomePostCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Colors.blueGrey,
                blurRadius: 3.0,
                spreadRadius: 0.5,
                offset: Offset(0.3, 1.5))
          ]),
      margin: EdgeInsets.symmetric(horizontal: 7.0, vertical: 13.0),
      width: 160.0,
      //height: 240.0,
      child: Column(
        children: [
          SizedBox(
            height: 3.0,
          ),
          Text(
            "January 2021",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          SizedBox(
            height: 2.0,
          ),
          Image.asset(
            "assets/dd.jpg",
            width: double.infinity,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 5.0,
          ),
          // For Category
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
            child: Row(
              children: [
                Icon(
                  Icons.category_sharp,
                  size: 18.0,
                ),
                SizedBox(
                  width: 3.0,
                ),
                Flexible(
                  child: Text(
                    "Bachelor",
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          // For Location
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
            child: Row(
              children: [
                Icon(
                  Icons.location_pin,
                  size: 18.0,
                ),
                SizedBox(
                  width: 3.0,
                ),
                Flexible(
                  child: Text(
                    "Chourhash Kushtia Bangladesh",
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          // For Specification
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
            child: Row(
              children: [
                Icon(
                  Icons.location_city,
                  size: 18.0,
                ),
                SizedBox(
                  width: 3.0,
                ),
                Flexible(
                  child: Text(
                    "3",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Icon(
                  Icons.local_hotel,
                  size: 18.0,
                ),
                SizedBox(
                  width: 3.0,
                ),
                Flexible(
                  child: Text(
                    "3",
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          // For Rent
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
            child: Row(
              children: [
                Icon(
                  Icons.local_atm,
                  size: 18.0,
                ),
                SizedBox(
                  width: 3.0,
                ),
                Flexible(
                  child: Text(
                    "17000 / month",
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          )
        ],
      ),
    );
  }
}
