/// وضعیت یکپارچه VPN
enum VpnStatus {
  disconnected,      // قطع شده
  connecting,        // در حال اتصال
  connected,         // متصل
  reconnecting,      // بازاتصال
  disconnecting,     // در حال قطع
  error,            // خطا
}

extension VpnStatusExtension on VpnStatus {
  String get displayName {
    switch (this) {
      case VpnStatus.disconnected:
        return 'قطع شده';
      case VpnStatus.connecting:
        return 'در حال اتصال...';
      case VpnStatus.connected:
        return 'متصل';
      case VpnStatus.reconnecting:
        return 'بازاتصال...';
      case VpnStatus.disconnecting:
        return 'در حال قطع...';
      case VpnStatus.error:
        return 'خطا';
    }
  }
}