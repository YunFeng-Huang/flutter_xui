// ignore: non_constant_identifier_names
import 'package:flutter/material.dart';

XBottomAppBarWrap({child, color, height, boxShadow, heightAuto}) {
  return Container(
    height: heightAuto ? null : height,
    decoration: BoxDecoration(
      color: color ?? Colors.white,
      boxShadow: boxShadow ??
          [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05), //底色,阴影颜色
              blurRadius: 1, // 阴影模糊层度
              spreadRadius: 1, //阴影模糊大小
            )
          ],
    ),
    child: child,
  );
}
