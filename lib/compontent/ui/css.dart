import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:xui/compontent/js/index.dart';
import 'package:xui/compontent/ui/color_utils.dart';
import 'package:xui/compontent/ui/index.dart';
import 'package:xui/compontent/ui/my_toast.dart';

import 'html/XInput.dart';
export './index.dart';

class ThemeColor {
  static get disable => Color(0xFFC4C4C4);
  static get active => Color(0xFF3399FF);
  static get black => Color(0x010101);
  static get red => Color(0xFFFFC4F32);
  static get white => Color(0xFFFFFFFF);
  static get background => Color(0xFFEEEFF3);
  static get line => Color(0xFFD9D9D9);
  static get border => Color(0xFFD9D9D9);
  static get addFont => 6.w;
}

TextStyle font(double value, {bool bold = false, FontWeight? weight, color = "#666666", colorA, height, lineThrough = false, letterSpacing = false}) {
  if (ThemeColor.addFont > 0) value = value + ThemeColor.addFont;
  return TextStyle(
    fontWeight: weight ?? (bold ? FontWeight.bold : FontWeight.normal),
    fontSize: value.w,
    color: colorA ?? (color != null ? HexToColor(color) : null),
    decoration: lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    letterSpacing: letterSpacing ? -1 : 0,
    height: height,
  );
}
