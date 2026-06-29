import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/core_supervisor.dart';
import 'ui/dashboard.dart';
import 'providers/vpn_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Lock orientation to portrait
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  runApp(const STKVPNApp());
}

class STKVPNApp extends StatelessWidget {
  const STKVPNApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VPNProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'STK VPN Pro',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            brightness: Brightness.dark,
          ),
        ),
        home: const DashboardScreen(),
      ),
    );
  }
}