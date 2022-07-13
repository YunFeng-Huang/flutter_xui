import 'dart:core';
import 'package:flutter/material.dart';
import '../js/color_utils.dart';
import '../index.dart';

ThemeColor themeColor = ThemeColor();

class ThemeColor {
  ///字体颜色
  Color? headline1 = Color(0xFF0E0D15);
  Color? headline2 = Color(0xFF3D3B48);
  Color? headline3 = Color(0xFF6C7480);
  Color? headline4 = Color(0xFF9EA6AE);
  Color? headline5 = Color(0xFFC1C6CB);
  Color? primary = Color(0xFFFF4300);
  Color? primary1 = Color(0xFFFF9538);
  Color? primary2 = Color(0xFFFE424A);
  Color? white = Color(0xFFFFFFFF);
  Color? black = Color(0xFF0E1424);
  Color? green = Color(0xFFFF11BB70);
  Color? blue = Color(0xFFFF4480FF);
  Color? lightBlue = Color(0xFFFF54C6EF);
  Color? purple = Color(0xFFFF846BF8);
  Color? divider = Color(0xFFDEDFDE);
  ThemeColor({
    this.headline1,
    this.headline2,
    this.headline3,
    this.headline4,
    this.headline5,
    this.primary,
    this.primary1,
    this.primary2,
    this.white,
    this.black,
    this.green,
    this.blue,
    this.lightBlue,
    this.purple,
    this.divider,
  });
}

TextStyle font(double value,
    {FontWeight? weight,
    color = "#666666",
    colorA,
    height,
    lineThrough = false,
    letterSpacing = false,
    fontFamily}) {
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
