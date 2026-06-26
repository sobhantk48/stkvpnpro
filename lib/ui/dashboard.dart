import 'package:flutter/material.dart';
import 'package:v2ray_stk/core/controller.dart';
import 'package:v2ray_stk/services/config_service.dart';
import 'dart:convert';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String status = 'IDLE';
  String coreType = 'singbox';
  String? activeConfig;
  bool _isLoading = false;

  List<Map<String, String>> configs = [];

  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _subController = TextEditingController();

  String _logs = '';
  String _traffic = '0 KB/s / 0 KB/s';

  @override
  void initState() {
    super.initState();
    _loadConfigs();
    _listenToLogs();
    _listenToTraffic();
  }

  Future<void> _loadConfigs() async {
    final loaded = await ConfigService.loadConfigs();
    final active = await ConfigService.loadActiveConfig();

    if (!mounted) return;

    setState(() {
      configs = loaded;
      activeConfig = active;
    });
  }

  void _listenToLogs() {
    CoreController.getLogs().listen((log) {
      if (!mounted) return;
      setState(() => _logs = log);
    });
  }

  void _listenToTraffic() {
    CoreController.getTraffic().listen((data) {
      if (!mounted) return;
      setState(() => _traffic = data);
    });
  }

  Future<void> _connect() async {
    if (_isLoading) return;
    if (activeConfig == null) return;

    setState(() => _isLoading = true);

    try {
      final res = await CoreController.startCore(coreType, activeConfig!);

      if (!mounted) return;

      if (res == "Started") {
        setState(() => status = "CONNECTED");
      } else {
        setState(() => status = "ERROR");
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _disconnect() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      await CoreController.stopCore();

      if (!mounted) return;

      setState(() => status = "DISCONNECTED");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('V2RAY STK'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Status: $status"),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _isLoading ? null : _connect,
              child: const Text("Connect"),
            ),

            ElevatedButton(
              onPressed: _isLoading ? null : _disconnect,
              child: const Text("Disconnect"),
            ),
          ],
        ),
      ),
    );
  }
}
