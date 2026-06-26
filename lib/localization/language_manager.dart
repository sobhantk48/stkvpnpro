import 'app_language.dart';

class LanguageManager {

  static AppLanguage current =
      AppLanguage.persian;

  static void set(
    AppLanguage language,
  ) {
    current = language;
  }
}
