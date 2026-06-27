import 'package:flutter/material.dart';

import 'app_theme_mode.dart';
import 'material_theme.dart';
import 'theme_controller.dart';

class ThemeProvider {

  static ThemeData
      current() {

    switch (

      ThemeController
          .current

    ) {

      case AppThemeMode.dark:

        return MaterialTheme
            .dark();

      case AppThemeMode.light:

        return MaterialTheme
            .light();

      default:

        return MaterialTheme
            .light();
    }
  }
}
