import 'package:flutter/material.dart';

import '../index.dart';

AppBar XAppBar(
  context, {
  String? title,
  PreferredSizeWidget? bottom,
  Widget? subTitle,
  Widget? titleWidget,
  double? tWidth,
  double? tHeight,
  Function? willPopFn,
  Widget? backWidget,
  Function? backWidgetFn,
  List<Widget>? actions,
      Color?  backgroundColor,
  bool? elevation,
      double? toolbarHeight,
      String?   theme= "light",
      bool automaticallyImplyLeading = true,
}) {
  onPressed() async {
    if (backWidgetFn == null) {
      var pop = await willPopFn?.call();
      var canPop = pop == null || pop;
      if (Navigator.canPop(context) && canPop) {
        Navigator.pop(context);
      } else {
        if (canPop) {
          XUtil.flutterPop();
        }
      }
    } else {
      backWidgetFn.call();
    }
  }

  return AppBar(
    automaticallyImplyLeading:automaticallyImplyLeading,
    backgroundColor:backgroundColor??(theme == 'light'? themeColor.ffFFFFFF : themeColor.primary),
    title: titleWidget ??
        (Stack(
          alignment: AlignmentDirectional.center,
          children: [
            subTitle ?? const SizedBox(width: 0, height: 0),
            Text(
              '$title',
              style: TextStyle(fontSize: 36.w).copyWith(color:theme == 'light'?  themeColor.ff0E1424:themeColor.ffFFFFFF, fontWeight: FontWeight.w500),
            ),
          ],
        ).background(width: tWidth, height: tHeight)),
    centerTitle: titleWidget == null ? true : false,
    elevation: elevation ?? false ? 1.w : 0,
    toolbarHeight:toolbarHeight??( bottom == null ? 44 : 88),
    leading:automaticallyImplyLeading==false?null:(backWidget == null
        ? IconButton(
      color:theme == 'light'?  Colors.black:themeColor.ffFFFFFF,
      icon: Icon(
        Icons.arrow_back_ios,
        size: 20,
      ),
      onPressed: onPressed,
    )
        : XButton(
      callback: backWidgetFn ?? onPressed,
      child: backWidget,
    )),
    actions: actions ??(automaticallyImplyLeading==false?null: [const SizedBox(width: 44)]),
    bottom: bottom,
  );
}
