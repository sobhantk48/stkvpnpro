import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/core_supervisor.dart';
import '../core/models/vpn_status.dart';
import '../provider/vpn_provider.dart';

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
      _setupMonitoring();
    } catch (e) {
      _showError('خطا: $e');
    }
  }

  void _setupMonitoring() {
    supervisor.startHealthMonitoring(
      statusCheck: () async => vpnProvider.status,
      onError: (e) async => _showError(e),
    );

    supervisor.startTrafficMonitoring(
      trafficFetcher: () async => vpnProvider.trafficData,
    );
  }

  void _showError(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      supervisor.stopHealthMonitoring();
    } else if (state == AppLifecycleState.resumed) {
      _setupMonitoring();
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
      ),
      body: Consumer<VPNProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // وضعیت
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: ValueListenableBuilder<VpnStatus>(
                      valueListenable: supervisor.statusNotifier,
                      builder: (context, status, _) {
                        return Column(
                          children: [
                            Icon(
                              status == VpnStatus.connected 
                                  ? Icons.shield 
                                  : Icons.shield_outlined,
                              size: 80,
                              color: status == VpnStatus.connected 
                                  ? Colors.green 
                                  : Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              status.displayName,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            if (provider.currentProtocol != null)
                              Text('پروتکل: ${provider.currentProtocol}'),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ترافیک
                ValueListenableBuilder<Map<String, dynamic>>(
                  valueListenable: supervisor.trafficNotifier,
                  builder: (context, traffic, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStat('دانلود', 
                          '${(traffic['download'] as num?)?.toStringAsFixed(2) ?? "0"} KB/s',
                          Icons.download, Colors.blue),
                        _buildStat('آپلود',
                          '${(traffic['upload'] as num?)?.toStringAsFixed(2) ?? "0"} KB/s',
                          Icons.upload, Colors.orange),
                        _buildStat('پینگ',
                          '${traffic['ping'] ?? 0} ms',
                          Icons.timer, Colors.purple),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 24),

                // دکمه‌ها
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: provider.selectedConfigId != null &&
                                provider.status != VpnStatus.connecting
                            ? () => provider.connect(provider.selectedConfigId!)
                            : null,
                        icon: const Icon(Icons.power_settings_new),
                        label: const Text('اتصال'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: provider.status == VpnStatus.connected
                            ? () => provider.disconnect()
                            : null,
                        icon: const Icon(Icons.power_settings_new_outlined),
                        label: const Text('قطع'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // لیست
                if (provider.configs.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('پروفایل‌ها:'),
                      const SizedBox(height: 12),
                      ...provider.configs.map((config) {
                        return Card(
                          color: config.id == provider.selectedConfigId
                              ? Colors.blue.shade100
                              : null,
                          child: ListTile(
                            title: Text(config.name),
                            subtitle: Text(config.protocol),
                            onTap: () => provider.connect(config.id),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => provider.deleteConfig(config.id),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),

                if (provider.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      color: Colors.red.shade100,
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

  Widget _buildStat(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(label, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}