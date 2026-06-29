import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/core_supervisor.dart';
import '../providers/vpn_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with WidgetsBindingObserver {
  late VPNProvider vpnProvider;
  late CoreSupervisor supervisor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    vpnProvider = Provider.of<VPNProvider>(context, listen: false);
    supervisor = CoreSupervisor();
    
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await supervisor.initialize();
      await vpnProvider.initialize();
      _setupHealthMonitoring();
      _restoreLastProfile();
    } catch (e) {
      if (mounted) {
        _showError('خطا در مقداردهی: $e');
      }
    }
  }

  void _setupHealthMonitoring() {
    supervisor.startHealthMonitoring(
      checkInterval: const Duration(seconds: 5),
      statusCheck: () async => vpnProvider.status,
      onError: (error) async {
        if (mounted) {
          _showError('خطا در نظارت: $error');
        }
      },
    );

    supervisor.startTrafficMonitoring(
      updateInterval: const Duration(seconds: 1),
      trafficFetcher: () async => vpnProvider.trafficData,
    );
  }

  Future<void> _restoreLastProfile() async {
    if (vpnProvider.selectedProfileId != null) {
      await vpnProvider.connect(vpnProvider.selectedProfileId!);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      supervisor.stopHealthMonitoring();
    } else if (state == AppLifecycleState.resumed) {
      _setupHealthMonitoring();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    supervisor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STK VPN Pro'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Settings
            },
          ),
        ],
      ),
      body: Consumer<VPNProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // کارت وضعیت
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ValueListenableBuilder<VPNStatus>(
                      valueListenable: supervisor.statusNotifier,
                      builder: (context, status, _) {
                        final isConnected = status == VPNStatus.connected;
                        return Column(
                          children: [
                            Icon(
                              isConnected ? Icons.shield : Icons.shield_outlined,
                              size: 80,
                              color: isConnected ? Colors.green : Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            ValueListenableBuilder<String>(
                              valueListenable: supervisor.statusTextNotifier,
                              builder: (context, statusText, _) {
                                return Text(
                                  statusText,
                                  style: Theme.of(context).textTheme.headlineSmall,
                                );
                              },
                            ),
                            const SizedBox(height: 8),
                            if (provider.currentProtocol != null)
                              Text('پروتکل: ${provider.currentProtocol}'),
                            if (provider.currentServer != null)
                              Text('سرور: ${provider.currentServer}'),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // آمار ترافیک
                ValueListenableBuilder<Map<String, dynamic>>(
                  valueListenable: supervisor.trafficNotifier,
                  builder: (context, traffic, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatCard(
                          'دانلود',
                          '${(traffic['download'] as num?)?.toStringAsFixed(2) ?? '0'} KB/s',
                          Icons.download,
                          Colors.blue,
                        ),
                        _buildStatCard(
                          'آپلود',
                          '${(traffic['upload'] as num?)?.toStringAsFixed(2) ?? '0'} KB/s',
                          Icons.upload,
                          Colors.orange,
                        ),
                        _buildStatCard(
                          'پینگ',
                          '${traffic['ping'] ?? 0} ms',
                          Icons.timer,
                          Colors.purple,
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 24),

                // دکمه‌های اتصال
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: provider.selectedProfileId != null &&
                                provider.status != VPNStatus.connecting
                            ? () => provider.connect(provider.selectedProfileId!)
                            : null,
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
                        onPressed: provider.status == VPNStatus.connected
                            ? () => provider.disconnect()
                            : null,
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

                const SizedBox(height: 24),

                // لیست پروفایل‌ها
                if (provider.profiles.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('پروفایل‌های دردسترس:'),
                      const SizedBox(height: 12),
                      ...provider.profiles.map((profile) {
                        final isSelected = profile.id == provider.selectedProfileId;
                        return Card(
                          color: isSelected ? Colors.blue.shade100 : null,
                          child: ListTile(
                            leading: const Icon(Icons.public),
                            title: Text(profile.name),
                            subtitle: Text(profile.protocol),
                            onTap: () => provider.connect(profile.id),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => provider.deleteProfile(profile.id),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),

                // نمایش خطا
                if (provider.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        provider.errorMessage!,
                        style: TextStyle(color: Colors.red.shade900),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}