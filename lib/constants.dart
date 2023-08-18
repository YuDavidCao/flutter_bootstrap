import 'package:flutter/material.dart';

const double globalEdgePadding = 20.0;

const double globalMarginPadding = 10.0;

const double defaultBottomAppBarHeight = 76.0;

const Color sixtyUIColor = Colors.white;

const Color thirtyUIColor = Colors.amber;

const Color tenUIColor = Colors.amber;

const TextStyle titleTextStyle = TextStyle(fontSize: 25);

const TextStyle ctaButtonStyle = TextStyle(fontSize: 18, color: Colors.white);

RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

const LinearGradient goldLinearGradient = LinearGradient(
  begin: Alignment(0, -1),
  end: Alignment(0, 1),
  colors: [
    Color(0xFFFFFF00),
    Color.fromRGBO(230, 188, 107, 1),
  ],
);

const LinearGradient blueLinearGradient = LinearGradient(
  begin: Alignment(0, -1),
  end: Alignment(0, 1),
  colors: [
    Color(0xFF0f2f7b),
    Color(0xFF0b1f41),
  ],
);
