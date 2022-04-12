import 'dart:async';
import 'package:flutter/material.dart';
import 'package:xui/xui.dart';

GlobalConfig globalConfig = GlobalConfig();

class GlobalConfig {
  dynamic addFont;
  FontWeight? fontWeight;
  String defaultImg =
      'https://lanhu.oss-cn-beijing.aliyuncs.com/SketchPngd258a686af28f6de78df86221ed0ccc3161fd7489c4336fd1dcc49789abf9eb3';
  Widget? smartRefresherCustomHeader;
  Map imgList = {
    XImageType.general: Icon(null, color: HexToColor('#C1C6CB')),
    XImageType.avatar: Icon(null, color: HexToColor('#C1C6CB')),
  };
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
