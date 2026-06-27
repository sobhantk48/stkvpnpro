import 'app_theme_mode.dart';

class ThemeController {

  static AppThemeMode
      current =
      AppThemeMode.system;

  static void set(
    AppThemeMode mode,
  ) {

    current = mode;
  }
}
