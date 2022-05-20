// ignore: non_constant_identifier_names
import 'package:flutter/material.dart';

import '../../index.dart';

Widget XAppBarWidget(
  context, {
  String? title,
  double? appbarHeight,
  // TextStyle? textStyle,
  Color? backgroundColor,
  double? fontSize,
  Color? color,
  List<Widget>? actions,
}) {
  double height = appbarHeight ?? 88.w;
  return Container(
    padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
    color: backgroundColor ?? Colors.transparent,
    height: height + ScreenUtil().statusBarHeight,
    child: Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
          child: BackButton(
            color: color ?? HexToColor('#010101'),
          ).background(width: height, height: height),
        ).centerLeft.margin(left: 24.w),
        Text(
          title ?? '',
          style: TextStyle(
            fontSize: fontSize ?? 32.w,
            color: color ?? HexToColor('#010101'),
            fontWeight: FontWeight.bold,
          ),
          // font(32, color: color ?? '#010101', bold: true),
        ).center,
        if (isNotNull(actions?.length))
          Row(
            children: List.generate(
              actions!.length,
              (index) => Container(
                child: actions[index],
                width: height,
              ),
            ),
          )
              .background(width: height * actions.length)
              .centerRight
              .margin(right: 24.w),
      ],
    ),
  );
}
