import 'package:flutter/material.dart';
import 'ui/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'STK VPN PRO',
      theme: ThemeData.dark(),
      home: const DashboardScreen(),
    );
  }
}
