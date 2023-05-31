import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    XImageType.avatar:'',
  };
  ThemeData theme = ThemeData();
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




class SystemUiStyle {
  static SystemUiOverlayStyle light  = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor:  Color(0xFFFFFFFF),
  systemNavigationBarIconBrightness: Brightness.light, //虚拟按键图标色
  systemNavigationBarDividerColor: Colors.transparent,
  statusBarBrightness: Brightness.light,
);


static SystemUiOverlayStyle dark  = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarColor:  Color(0xFFFFFFFF),
  systemNavigationBarIconBrightness: Brightness.dark,
  //虚拟按键图标色
  systemNavigationBarDividerColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
);
}