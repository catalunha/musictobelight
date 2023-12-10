import 'package:flutter/material.dart';

sealed class AppColors {
  static const white = Colors.white;
  static const black = Colors.black;
  static const red = Colors.red;
  static const yellow = Colors.yellow;
  static const green = Colors.green;
  static const blue = Colors.blue;
}

sealed class AppFontFamily {
  static const fontFamily1 = 'Poppins';
}

sealed class AppFontSize {
  static const fontSizeSmall = 12.0;
  static const fontSizeMedium = 17.0;
  static const fontSizeLarge = 27.0;
}

sealed class AppAssetImage {
  static const logo = '';
}
