import 'split_model.dart';

class SplitEngine {

  static final List<SplitModel>
      rules = [];

  static void addRule(
    SplitModel model,
  ) {

    rules.add(model);
  }

  static bool shouldUseVpn(
    String package,
  ) {

    for (final rule in rules) {

      if (rule.packageName == package) {

        return rule.useVpn;
      }
    }

    return true;
  }
}
