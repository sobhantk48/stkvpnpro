import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

class SingboxFFI {
  static final SingboxFFI _instance = SingboxFFI._internal();
  factory SingboxFFI() => _instance;
  SingboxFFI._internal();

  DynamicLibrary? _lib;

  void loadLibrary() {
    if (_lib != null) return;
    try {
      if (Platform.isAndroid) {
        _lib = DynamicLibrary.open('libsingbox.so');
        print('✅ libsingbox.so بارگذاری شد');
      } else {
        throw Exception('پلتفرم پشتیبانی نمی‌شود');
      }
    } catch (e) {
      print('❌ خطا در بارگذاری libsingbox.so: $e');
      rethrow;
    }
  }

  int run(String config) {
    loadLibrary();
    try {
      final runFunc = _lib!.lookup<NativeFunction<Int32 Function(Pointer<Utf8>)>>('run');
      final run = runFunc.asFunction<int Function(Pointer<Utf8>)>();
      final configPtr = config.toNativeUtf8();
      final result = run(configPtr);
      calloc.free(configPtr);
      return result;
    } catch (e) {
      print('❌ خطا در اجرای sing-box: $e');
      rethrow;
    }
  }

  void stop() {
    loadLibrary();
    try {
      final stopFunc = _lib!.lookup<NativeFunction<Void Function()>>('stop');
      final stop = stopFunc.asFunction<void Function()>();
      stop();
      print('✅ sing-box متوقف شد');
    } catch (e) {
      print('❌ خطا در توقف sing-box: $e');
    }
  }

  String? getStatus() {
    loadLibrary();
    try {
      final statusFunc = _lib!.lookup<NativeFunction<Pointer<Utf8> Function()>>('status');
      final status = statusFunc.asFunction<Pointer<Utf8> Function()>();
      final ptr = status();
      if (ptr != nullptr) {
        final result = ptr.toDartString();
        calloc.free(ptr);
        return result;
      }
      return null;
    } catch (e) {
      print('❌ خطا در دریافت وضعیت: $e');
      return null;
    }
  }
}
