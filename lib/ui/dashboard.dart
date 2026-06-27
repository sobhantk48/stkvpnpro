import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/core_supervisor.dart';
import '../providers/vpn_provider.dart';   // بعداً می‌سازیم

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // شروع نظارت بر هسته
    CoreSupervisor.startMonitor(
      restartCallback: () async => "Started", // بعداً واقعی می‌کنیم
      onCriticalFailure: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('خطای بحرانی! لطفاً مجوزها را چک کنید')),
        );
      },
    );
  }

  @override
  void dispose() {
    // CoreSupervisor.dispose();  // فعلاً کامنت — بعداً مدیریت می‌کنیم
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vpnProvider = Provider.of<VPNProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('STK VPN Pro'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigator to settings
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // وضعیت اتصال
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    ValueListenableBuilder<String>(
                      valueListenable: CoreSupervisor.statusNotifier,
                      builder: (context, status, child) {
                        final isConnected = status == 'Connected';
                        return Column(
                          children: [
                            Icon(
                              isConnected ? Icons.shield : Icons.shield_outlined,
                              size: 80,
                              color: isConnected ? Colors.green : Colors.grey,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              status == 'Connected' ? 'متصل' : 'قطع',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              'پروتکل: ${vpnProvider.currentProtocol}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // آمار ترافیک
            ValueListenableBuilder<Map<String, dynamic>>(
              valueListenable: CoreSupervisor.trafficNotifier,
              builder: (context, traffic, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStat('دانلود', '${traffic['download']} KB/s', Icons.download),
                    _buildStat('آپلود', '${traffic['upload']} KB/s', Icons.upload),
                    _buildStat('پینگ', '${traffic['ping']} ms', Icons.timer),
                  ],
                );
              },
            ),

            const Spacer(),

            // دکمه‌های اصلی
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: vpnProvider.connect,
                    icon: const Icon(Icons.power_settings_new),
                    label: const Text('اتصال'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: vpnProvider.disconnect,
                    icon: const Icon(Icons.power_settings_new_outlined),
                    label: const Text('قطع'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // سرور فعلی
            ListTile(
              leading: const Icon(Icons.public),
              title: const Text('سرور فعلی'),
              subtitle: Text(vpnProvider.currentServer ?? 'انتخاب نشده'),
              trailing: TextButton(
                onPressed: () {}, // TODO: Server list
                child: const Text('تغییر'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}