import 'dart:convert';

class ConfigValidator {
  static bool validate(String jsonStr) {
    try {
      final json = jsonDecode(jsonStr);
      return json["outbounds"] != null;
    } catch (_) {
      return false;
    }
  }
}
