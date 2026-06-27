import 'package:flutter/material.dart';
import '../dashboard/dashboard_controller.dart';
import '../dashboard/dashboard_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardState _state = DashboardController.state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('STK VPN Pro')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('وضعیت: ${_state.status}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text('پینگ: ${_state.ping} ms'),
            Text('آپلود: ${_state.upload} | دانلود: ${_state.download}'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              child: const Text('اتصال'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('قطع اتصال'),
            ),
          ],
        ),
      ),
    );
  }
}
