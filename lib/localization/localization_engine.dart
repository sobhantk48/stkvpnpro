enum AppLanguage {

  fa,

  en,
}

class LocalizationEngine {

  static AppLanguage
      language =
      AppLanguage.fa;

  static void set(
    AppLanguage lang,
  ) {

    language =
        lang;
  }
}
