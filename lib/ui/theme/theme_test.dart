import 'theme_controller.dart';
import 'app_theme_mode.dart';

class ThemeTest {

  static bool run() {

    ThemeController
        .set(

      AppThemeMode.dark,
    );

    return

        ThemeController
            .current

        ==

        AppThemeMode.dark;
  }
}
