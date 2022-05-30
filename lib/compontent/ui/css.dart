import 'dart:core';
import 'package:flutter/material.dart';
import '../js/color_utils.dart';
import '../index.dart';

ThemeColor themeColor = ThemeColor();

class ThemeColor {
  Color? disable;
  Color? active;
  Color? black;
  Color? red;
  Color? white;
  Color? gray;
  Color? background;
  Color? line;
  Color? border;
  Color? primary;
  ThemeColor({
    this.disable,
    this.active,
    this.black,
    this.red,
    this.white,
    this.background,
    this.line,
    this.border,
    this.gray,
  }) {
    disable = disable ?? Color(0xFFC4C4C4);
    active = active ?? Color(0xFF3399FF);
    black = black ?? Color(0x010101);
    red = red ?? Color(0xFFFFC4F32);
    primary = primary ?? Color(0xFFFF4300);
    gray = gray ?? Color(0xFF6C7480);
    white = white ?? Color(0xFFFFFFFF);
    background = background ?? Color(0xFFEEEFF3);
    line = line ?? Color(0xFFD9D9D9);
    border = border ?? Color(0xFFD9D9D9);
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
