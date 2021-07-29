import 'dart:async';

import 'package:flutter/services.dart';
export './compontent/ui/index.dart';

class Xui {
  static const MethodChannel _channel = const MethodChannel('xui');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
