import 'package:flutter/material.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color yelloClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primryClr = bluishClr;
const Color darkGrayClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light =
      ThemeData(primaryColor: primryClr, brightness: Brightness.light,backgroundColor: white);

  static final dark =
      ThemeData(primaryColor: darkGrayClr, brightness: Brightness.dark,backgroundColor: darkGrayClr);
}
