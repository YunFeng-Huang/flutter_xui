import 'dart:core';
import 'package:flutter/material.dart';
import '../js/color_utils.dart';
import '../index.dart';

ThemeColor themeColor = ThemeColor();

class ThemeColor {
  ///字体颜色
  Color? headline1;
  Color? headline2;
  Color? headline3;
  Color? headline4;
  Color? headline5;
  Color? primary;
  Color? primary1;
  Color? primary2;
  Color? white;
  Color? black;
  Color? green;
  Color? blue;
  Color? lightBlue;
  Color? purple;
  Color? divider;
  Color? background;
  ThemeColor(
      {this.headline1,
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
      this.background}) {
    headline1 = this.headline1 ?? Color(0xFF0E0D15);
    headline2 = this.headline2 ?? Color(0xFF3D3B48);
    headline3 = this.headline3 ?? Color(0xFF6C7480);
    headline4 = this.headline4 ?? Color(0xFF9EA6AE);
    headline5 = this.headline5 ?? Color(0xFFC1C6CB);
    primary = this.primary ?? Color(0xFFFF4300);
    primary1 = this.primary1 ?? Color(0xFFFF9538);
    primary2 = this.primary2 ?? Color(0xFFFE424A);
    white = this.white ?? Color(0xFFFFFFFF);
    black = this.black ?? Color(0xFF0E1424);
    green = this.green ?? Color(0xFFFF11BB70);
    blue = this.blue ?? Color(0xFFFF4480FF);
    lightBlue = this.lightBlue ?? Color(0xFFFF54C6EF);
    purple = this.purple ?? Color(0xFFFF846BF8);
    divider = this.divider ?? Color(0xFFDEDFDE);
    background = this.background ?? Color(0xFFF3F6F9);
  }
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
