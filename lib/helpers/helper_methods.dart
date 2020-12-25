import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tolet_bazar/data/app_data.dart';
import 'package:tolet_bazar/helpers/request_helper.dart';
import 'package:tolet_bazar/models/Address.dart';
import 'package:tolet_bazar/models/Direction.dart';

import '../config_maps.dart';

class HelperMethods {
  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String placeAddress = "";
    String st1, st2, st3, st4;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapApiKey2";

    var response = await RequestHelper.getRequest(url);

    if (response != "failed") {
      placeAddress = response["results"][0]["formatted_address"];
      // st1 = response["results"][0]["address_components"][3]["long_name"];
      // st2 = response["results"][0]["address_components"][4]["long_name"];
      // st3 = response["results"][0]["address_components"][5]["long_name"];
      // st4 = response["results"][0]["address_components"][6]["long_name"];

      // placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;

      Address userPickupAddress = new Address();
      userPickupAddress.lat = position.latitude;
      userPickupAddress.lng = position.longitude;
      userPickupAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updatePickupAddress(userPickupAddress);
    }

    return placeAddress;
  }

  static Future<Direction> drawDirectionOnMap(
      LatLng initialPoint, LatLng destinationPoint) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPoint.latitude},${initialPoint.longitude}&destination=${destinationPoint.latitude},${destinationPoint.longitude}&key=$mapApiKey2";
    var res = await RequestHelper.getRequest(url);
    if (res == "failed") {
      return null;
    }

    Direction direction = Direction();

    direction.distanceValue = res["routes"][0]["legs"][0]["distance"]["value"];
    direction.distanceText = res["routes"][0]["legs"][0]["distance"]["text"];
    direction.durationValue = res["routes"][0]["legs"][0]["duration"]["value"];
    direction.durationText = res["routes"][0]["legs"][0]["duration"]["text"];
    direction.encodedPoints = res["routes"][0]["overview_polyline"]["points"];

    return direction;
  }
}
