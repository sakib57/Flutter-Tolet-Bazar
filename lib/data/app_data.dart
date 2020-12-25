import 'package:flutter/cupertino.dart';
import 'package:tolet_bazar/models/Address.dart';
import 'dart:convert';

import 'package:tolet_bazar/models/Category.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class AppData extends ChangeNotifier {
  Address pickupLocation, dropOffLocation;
  List<Category> categories = List<Category>();

  Future<List<Category>> fetchCategories() async {
    String url = apiUrl + "get-categories";
    if (categories.isEmpty) {
      try {
        final response = await http.get(url);
        print("APi Called");
        if (response.statusCode == 200) {
          categories = (json.decode(response.body) as List)
              .map((data) => Category.fromJson(data))
              .toList();

          //print(categories);
          //return categories;
        } else {
          print(response);
          throw Exception("Failed to load data");
        }
      } catch (e) {}
    }
    return categories;
  }

  void updatePickupAddress(Address pickupAddress) {
    pickupLocation = pickupAddress;
    notifyListeners();
  }

  void updateDropOffAddress(Address dropOffAddress) {
    dropOffLocation = dropOffAddress;
    notifyListeners();
  }
}
