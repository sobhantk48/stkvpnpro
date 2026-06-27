import '../../vault/config_vault.dart';
import 'admin_dashboard_model.dart';
import 'device_manager.dart';
import 'subscription_manager.dart';

class AdminDashboardEngine {

  static AdminDashboardModel
      build() {

    return AdminDashboardModel(

      devices:
          DeviceManager
              .count(),

      configs:
          ConfigVault
              .count(),

      subscriptions:
          AdminSubscriptionManager
              .count(),
    );
  }
}
