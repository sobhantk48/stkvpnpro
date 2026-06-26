import 'package:flutter/material.dart';
import '../core/network/core_controller.dart';
import '../core/config/config_service.dart';
import '../core/config/config_validator.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String status = "IDLE";
  String coreType = "singbox";
  String? activeConfig;

  List<Map<String, String>> configs = [];
  bool _loading = false;

  String logs = "";
  String traffic = "0 KB/s";

  @override
  void initState() {
    super.initState();
    _load();
    _listenLogs();
    _listenTraffic();
  }

  Future<void> _load() async {
    configs = await ConfigService.loadConfigs();
    activeConfig = await ConfigService.loadActiveConfig();
    setState(() {});
  }

  void _listenLogs() {
    CoreController.getLogs().listen((event) {
      if (!mounted) return;
      setState(() => logs = event);
    });
  }

  void _listenTraffic() {
    CoreController.getTraffic().listen((event) {
      if (!mounted) return;
      setState(() => traffic = event);
    });
  }

  Future<void> _connect() async {
    if (_loading) return;
    if (activeConfig == null) return;

    setState(() => _loading = true);

    try {
      final res = await CoreController.startCore(coreType, activeConfig!);

      if (!mounted) return;

      setState(() {
        status = res == "Started" ? "CONNECTED" : "ERROR";
      });
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _disconnect() async {
    await CoreController.stopCore();
    if (!mounted) return;
    setState(() => status = "DISCONNECTED");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("STK VPN PRO")),
      body: Column(
        children: [
          Text("Status: $status"),
          Text("Core: $coreType"),
          Text("Traffic: $traffic"),

          ElevatedButton(
            onPressed: _loading ? null : _connect,
            child: const Text("Connect"),
          ),

          ElevatedButton(
            onPressed: _disconnect,
            child: const Text("Disconnect"),
          ),

          Expanded(
            child: ListView(
              children: configs.map((c) {
                return ListTile(
                  title: Text(c["name"] ?? ""),
                  subtitle: Text(c["status"] ?? ""),
                  onTap: () async {
                    await ConfigService.saveActiveConfig(c["config"]);
                    setState(() => activeConfig = c["config"]);
                  },
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
