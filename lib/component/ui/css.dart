import 'dart:core';

import 'package:flutter/material.dart';

import '../index.dart';
import '../js/color_utils.dart';

ThemeColor themeColor = ThemeColor();

class ThemeColor {
  ///字体颜色
  Color? primary;
  Color? ff3D3B48;
  Color? ff6C7480;
  Color? ff9EA6AE;
  Color? ffC1C6CB;
  Color? ffFF4300;
  Color? ffFF9538;
  Color? ffFE424A;
  Color? ffFFFFFF;
  Color? ff0E1424;
  Color? ff11BB70;
  Color? ff4480FF;
  Color? ff54C6EF;
  Color? ff846BF8;
  Color? ffDEDFDE;
  Color? ffF3F6F9;
  ThemeColor({this.primary, this.ff3D3B48, this.ff6C7480, this.ff9EA6AE, this.ffC1C6CB, this.ffFF4300, this.ffFF9538, this.ffFE424A, this.ffFFFFFF, this.ff0E1424, this.ff11BB70, this.ff4480FF, this.ff54C6EF, this.ff846BF8, this.ffDEDFDE, this.ffF3F6F9}) {
    primary = this.primary ?? Color(0xff0E0D15);
    ff3D3B48 = this.ff3D3B48 ?? Color(0xFF3D3B48);
    ff6C7480 = this.ff6C7480 ?? Color(0xFF6C7480);
    ff9EA6AE = this.ff9EA6AE ?? Color(0xFF9EA6AE);
    ffC1C6CB = this.ffC1C6CB ?? Color(0xFFC1C6CB);
    ffFF4300 = this.ffFF4300 ?? Color(0xFFFF4300);
    ffFF9538 = this.ffFF9538 ?? Color(0xFFFF9538);
    ffFE424A = this.ffFE424A ?? Color(0xFFFE424A);
    ffFFFFFF = this.ffFFFFFF ?? Color(0xFFFFFFFF);
    ff0E1424 = this.ff0E1424 ?? Color(0xFF0E1424);
    ff11BB70 = this.ff11BB70 ?? Color(0xFFFF11BB70);
    ff4480FF = this.ff4480FF ?? Color(0xFFFF4480FF);
    ff54C6EF = this.ff54C6EF ?? Color(0xFFFF54C6EF);
    ff846BF8 = this.ff846BF8 ?? Color(0xFFFF846BF8);
    ffDEDFDE = this.ffDEDFDE ?? Color(0xFFDEDFDE);
    ffF3F6F9 = this.ffF3F6F9 ?? Color(0xFFF3F6F9);
  }
}

TextStyle font(double value, {FontWeight? weight, color = "#666666", colorA, height, lineThrough = false, letterSpacing = false, fontFamily}) {
  if (globalConfig.addFont! > 0) value = value + globalConfig.addFont;
  return TextStyle(
    fontWeight: weight ?? globalConfig.fontWeight,
    fontSize: value.w,
    fontFamily: fontFamily,
    color: colorA ?? (color != null ? HexToColor(color) : null),
    decoration: lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    letterSpacing: letterSpacing ? -1 : 0,
    height: height ?? 1.2,
  );
}
