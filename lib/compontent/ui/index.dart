import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

GlobalConfig globalConfig = GlobalConfig();

class GlobalConfig {
  dynamic addFont;
  FontWeight? fontWeight;
  String defaultImg =
      'https://lanhu.oss-cn-beijing.aliyuncs.com/SketchPngd258a686af28f6de78df86221ed0ccc3161fd7489c4336fd1dcc49789abf9eb3';
  Widget? smartRefresherCustomHeader;
  static Timer? timerCancel;
  GlobalConfig({
    this.addFont,
    this.fontWeight,
    this.smartRefresherCustomHeader,
  }) {
    addFont = addFont ?? 0;
    fontWeight = fontWeight ?? FontWeight.w400;
  }
}
