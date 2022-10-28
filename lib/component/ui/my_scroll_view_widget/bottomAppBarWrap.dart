// ignore: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:xui/component/index.dart';

XBottomAppBarWrap({child, color, height, boxShadow, heightAuto}) {
  return Container(
    height: heightAuto ? null : height,
    decoration: BoxDecoration(
        color: color ?? Colors.white,
        border: Border(
          top: BorderSide(
            color: themeColor.ffDEDFDE!,
            width: 1.w,
          ),
          bottom: BorderSide.none,
        )),
    child: child,
  );
}
