import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:v2ray_stk/services/preferences_service.dart';
import 'package:v2ray_stk/services/vpn_service.dart';
import 'package:v2ray_stk/services/config_service.dart';
import 'package:v2ray_stk/services/notification_service.dart';
import 'dart:convert';
import 'dart:core';
=======
import 'package:v2ray_stk/ui/dashboard.dart';
>>>>>>> production-architecture

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'V2RAY stk',
<<<<<<< HEAD
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SettingsPage(),
    const AdminWrapper(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'خانه'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'تنظیمات'),
          BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: 'ادمین'),
        ],
      ),
    );
  }
}

// ========== صفحه خانه ==========
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final VpnService _vpnService = VpnService();
  bool _isLoading = false;
  bool _isInitializing = true;
  String? _activeConfig;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await _vpnService.initialize();
      _activeConfig = await ConfigService.loadActiveConfig();
      _isConnected = await _vpnService.isConnected;
    } catch (e) {
      print('خطا: $e');
    } finally {
      if (mounted) setState(() => _isInitializing = false);
    }
  }

  Future<void> _toggleConnection() async {
    if (_isLoading || _isInitializing) return;
    if (_activeConfig == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لطفاً ابتدا یک کانفیگ فعال را در پنل ادمین انتخاب کنید')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _vpnService.toggleVpn(_activeConfig!);
      _isConnected = await _vpnService.isConnected;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطا: ${e.toString()}')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (_isInitializing) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('V2RAY stk'),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('V2RAY stk'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        actions: [
          if (_activeConfig != null)
            IconButton(
              icon: const Icon(Icons.check_circle, color: Colors.green),
              onPressed: null,
              tooltip: 'کانفیگ فعال است',
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading) const CircularProgressIndicator() else const SizedBox(height: 80),
            Icon(
              _isConnected ? Icons.vpn_lock : Icons.vpn_key,
              size: 80,
              color: _isConnected ? Colors.green : colorScheme.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 20),
            Text(
              _isConnected ? '✅ وصل شده' : '❌ قطع است',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _isConnected ? Colors.green : colorScheme.error,
              ),
            ),
            if (_activeConfig != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'کانفیگ فعال: ${_activeConfig!.length > 30 ? _activeConfig!.substring(0, 30) + '...' : _activeConfig!}',
                  style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withOpacity(0.6)),
                ),
              ),
            const SizedBox(height: 40),
            FilledButton.icon(
              onPressed: (_isLoading || _isInitializing) ? null : _toggleConnection,
              icon: Icon(_isConnected ? Icons.stop : Icons.play_arrow),
              label: Text(
                _isConnected ? 'قطع اتصال' : 'اتصال',
                style: const TextStyle(fontSize: 18),
              ),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: _isConnected ? colorScheme.error : colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ========== بقیه صفحات (تنظیمات، ادمین، مدیریت کانفیگ) ==========
// (همان کدهای قبلی که بدون تغییر می‌مانند - برای جلوگیری از طولانی شدن، حذف شده‌اند)
// اما برای کامل بودن، ادامه داده می‌شود ...
=======
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DashboardScreen(),
    );
  }
}
>>>>>>> production-architecture
