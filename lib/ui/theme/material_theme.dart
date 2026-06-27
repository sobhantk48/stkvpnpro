import 'package:flutter/material.dart';

class MaterialTheme {

  static ThemeData light() {

    return ThemeData(

      useMaterial3: true,
    );
  }

  static ThemeData dark() {

    return ThemeData(

      brightness:
          Brightness.dark,

      useMaterial3: true,
    );
  }
}
