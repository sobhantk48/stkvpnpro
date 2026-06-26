import 'dart:convert';

class ConfigValidator {
  static bool validate(String jsonStr) {
    try {
      final json = jsonDecode(jsonStr);

      if (json["outbounds"] == null) return false;
      if (json["inbounds"] == null && json["log"] == null) return false;

      return true;
    } catch (_) {
      return false;
    }
  }
}
