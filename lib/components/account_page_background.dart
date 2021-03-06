import 'package:flutter/material.dart';
import 'package:tolet_bazar/constants.dart';

class AccountPageBackground extends StatelessWidget {
  final screenHeight;

  const AccountPageBackground({Key key, @required this.screenHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomShapeClipper(),
      child: Container(
        height: screenHeight * 0.5,
        color: primaryColor,
      ),
    );
  }
}

class BottomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //Offset curveStartPoint = Offset(0, size.height * 0.85);
    //Offset curveEndPoint = Offset(size.width, size.height * 0.85);
    //path.lineTo(curveStartPoint.dx, curveStartPoint.dy);
    //path.quadraticBezierTo(-10, 250, 400, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 160);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
