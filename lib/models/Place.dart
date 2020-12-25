class Place {
  String placeId;
  String mainText;
  String secondaryText;

  Place({this.placeId, this.mainText, this.secondaryText});

  Place.fromJson(Map<String, dynamic> json) {
    placeId = json["place_id"];
    mainText = json["structured_formatting"]["main_text"];
    secondaryText = json["structured_formatting"]["secondary_text"];
  }
}
