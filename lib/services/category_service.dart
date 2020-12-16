import 'dart:convert';

import '../constants.dart';
import '../models/Category.dart';
import 'package:http/http.dart' as http;

// Fetch Categories from API
Future<List<Category>> fetchCategories() async {
  String url = apiUrl + "get-categories";

  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<Category> categories = (json.decode(response.body) as List)
        .map((data) => Category.fromJson(data))
        .toList();
    return categories;
  } else {
    print(response);
    throw Exception("Failed to load data");
  }
}
