class Category {
  final int id;
  final String categoryName;

  Category({this.id, this.categoryName});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json["id"], categoryName: json["category_name"]);
  }
}
