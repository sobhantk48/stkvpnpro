class PermissionEngine {

  static final Set<String>
      permissions = {};

  static void grant(
    String permission,
  ) {
    permissions.add(permission);
  }

  static bool has(
    String permission,
  ) {
    return permissions.contains(permission);
  }
}
