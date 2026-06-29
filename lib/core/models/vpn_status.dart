/// وضعیت VPN
enum VpnStatus {
  disconnected,
  connecting,
  connected,
  reconnecting,
  disconnecting,
  error,
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

  bool get isActive => 
      this == VpnStatus.connected || 
      this == VpnStatus.connecting;
}