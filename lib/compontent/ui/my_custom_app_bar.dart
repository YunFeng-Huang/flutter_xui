import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xui/compontent/js/index.dart';
import 'package:xui/compontent/js/screem.dart';
import '../index.dart';
import 'css.dart';

// ignore: must_be_immutable
class XAppBar extends StatelessWidget implements PreferredSizeWidget {
  late String title;
  TextStyle? textStyle;
  Color? backgroundColor;
  Color? color;
  List<Widget>? actions;
  late Function leftCallback;
  XAppBar({
    required String title,
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? color,
    List<Widget>? actions,
    leftCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
      color: backgroundColor ?? Colors.transparent,
      height: 88.w + ScreenUtil().statusBarHeight,
      width: 750.w,
      child: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: isNotNull(leftCallback)
                ? leftCallback.call()
                : () {
                    Navigator.pop(context);
                  },
            child: Icon(
              Icons.chevron_left,
              color: color ?? ThemeColor.black,
            ).background(width: 88.w, height: 88.w),
          ).centerLeft.margin(left: 24.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 32.w,
              color: color ?? ThemeColor.black,
              fontWeight: FontWeight.bold,
            ),
            // font(32, color: color ?? '#010101', bold: true),
          ).center,
          if (isNotNull(actions?.length))
            Row(
              children: List.generate(
                actions!.length,
                (index) => Container(
                  child: actions![index],
                  width: 88.w,
                ),
              ),
            ).background(width: 88.w * actions!.length).centerRight.margin(right: 24.w),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
