import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation oriantation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    oriantation = _mediaQueryData.orientation;

    defaultSize = oriantation == Orientation.landscape
        ? screenHeight * 0.024
        : screenWidth * 0.024;
  }
}
