import 'dart:async';
import 'package:flutter/services.dart';

class CoreController {
  static final CoreController _instance = CoreController._internal();
  
  factory CoreController() => _instance;
  CoreController._internal();

  static const MethodChannel _channel = MethodChannel('core_channel');
  static const EventChannel _logChannel = EventChannel('core_logs');
  static const EventChannel _trafficChannel = EventChannel('core_traffic');

  StreamSubscription<dynamic>? _logSub;
  StreamSubscription<dynamic>? _trafficSub;

  final _logController = StreamController<String>.broadcast();
  final _trafficController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<String> get logs => _logController.stream;
  Stream<Map<String, dynamic>> get traffic => _trafficController.stream;

  void startListening() {
    // گوش دادن به لاگ‌ها
    _logSub?.cancel();
    _logSub = _logChannel.receiveBroadcastStream().listen(
      (event) {
        _logController.add(event.toString());
      },
      onError: (error) {
        _logController.addError(error);
      },
    );

    // گوش دادن به ترافیک
    _trafficSub?.cancel();
    _trafficSub = _trafficChannel.receiveBroadcastStream().listen(
      (event) {
        if (event is Map) {
          _trafficController.add(Map<String, dynamic>.from(event));
        }
      },
      onError: (error) {
        _trafficController.addError(error);
      },
    );
  }

  Future<String> startCore(String type, String config) async {
    try {
      final result = await _channel.invokeMethod('startCore', {
        'type': type,
        'config': config,
      });
      return result.toString();
    } on PlatformException catch (e) {
      return 'Error: ${e.message}';
    }
  }

  Future<String> stopCore() async {
    try {
      final result = await _channel.invokeMethod('stopCore');
      return result.toString();
    } on PlatformException catch (e) {
      return 'Error: ${e.message}';
    }
  }

  void dispose() {
    _logSub?.cancel();
    _trafficSub?.cancel();
    _logController.close();
    _trafficController.close();
  }
}