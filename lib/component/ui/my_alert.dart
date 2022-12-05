import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../index.dart';

class XAlert {
 late BuildContext context;
  Color barrierColor = CupertinoDynamicColor.withBrightness(
    color: Color.fromRGBO(0, 0, 0, 0.5),
    darkColor: Color.fromRGBO(0, 0, 0, 0.4),
  );
  XAlert(this.context);

  /// 底部弹出提示框
  showBottomAlertCustom({required list, callback, title}) {
    return showCupertinoModalPopup(
      barrierColor: barrierColor,
      context: context,
      builder: (context) {
        return showBottomAlertCustomWidget(callback, list, title);
      },
    );
  }

  /// 底部弹出提示框
  showBottomAlertIos({required list, callback, title}) {
    return showCupertinoModalPopup(
      barrierColor: barrierColor,
      context: context,
      builder: (context) {
        return ShowCustomAlterWidget(callback, list, title);
      },
    );
  }

  /// 底部弹出提示框
  showBottomAlertAndroid({required list, callback, title}) {
    return showCupertinoModalPopup(
      barrierColor: barrierColor,
      context: context,
      builder: (context) {
        return XButton(
          callback: () {
            Navigator.pop(context);
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Column(
                children: [
                  Column(
                    children: List.generate(
                      list.length,
                      (index) => XButton(
                        callback: () {
                          Navigator.pop(context);
                          callback(index);
                        },
                        child: Text(list[index],
                                style: font(32, colorA: themeColor.primary))
                            .center
                            .background(
                                height: 112.w, borderTop: index == 0 ? 0 : 1.w),
                      ),
                    ),
                  ),
                  Container(
                    height: 20.w,
                    color: themeColor.ffF3F6F9,
                  ),
                  XButton(
                    callback: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '取消',
                      style: font(32, colorA: themeColor.primary),
                    ).center.background(height: 110.w),
                  )
                ],
              )
                  .background(
                      color: themeColor.ffFFFFFF, topRight: 16.w, topLeft: 16.w)
                  .bottomCenter
            ]),
          ),
        );
      },
    );
  }

  /// 中间弹出提示框
  showCenterTipsAlter(
      { Function? callback,
      title,
      info,
      cancelText,
      sureText,
      width,
      height,
      bool sureBtn = true,
      bool cancelBtn = true,
      heightAuto,
      elevation,
      minHeight,
      maxHeight, barrierDismissible:false,
      child}) {
    return showDialog(
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      context: context,
      builder: (BuildContext context) {
        return TipsAlterHeightAutoWidget(
          callback,
          cancelText,
          sureText,
          width,
          height,
          sureBtn,
          cancelBtn,
          child: child,
          info: info,
          title: title,
          minHeight: minHeight,
          elevation: elevation,
          maxHeight: maxHeight,
        );
      },
    );
  }
}

//用法 showLoading('加载中，请等待... ...')
showLoading(context, [String text = "加载中，请等待..."]) {
  return showCupertinoModalPopup(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
              color: themeColor.ffFFFFFF,
              borderRadius: BorderRadius.circular(20.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.w,
                )
              ]),
          padding: EdgeInsets.all(20.w),
          // margin: EdgeInsets.all(.w),
          // constraints: BoxConstraints(minHeight: 220.w, minWidth: 220.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Loading(text: text),
            ],
          ),
        ),
      );
    },
  );
}

Future<dynamic>? showConfirmDialog(
  BuildContext context,
  String text, {
  Function? confirmCallback,
  submitTitle = '确定',
  cancelTitle = "取消",
  title = '温馨提示',
}) {
  return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Container(
            height: 80.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromRGBO(235, 236, 236, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.w),
                topRight: Radius.circular(20.w),
              ),
            ),
            child: Text(
              title,
              style: font(30, color: '#3e3e3e'),
            ),
          ),
          titlePadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.all(0),
          backgroundColor: themeColor.ffFFFFFF,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.w),
            ),
          ),
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 56.w, horizontal: 42.w),
              child: Text(
                text,
                style: font(26, color: '#030303'),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.w),
                  bottomRight: Radius.circular(20.w),
                ),
              ),
              child: Row(
                children: [
                  if (cancelTitle != null)
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 76.w,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(235, 236, 236, 1),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.w),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(cancelTitle),
                        ),
                      ),
                    ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        confirmCallback?.call();
                        if (confirmCallback != null) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        // width: 340.w,
                        height: 76.w,
                        // decoration: BoxDecoration(
                        //   image: DecorationImage(
                        //     image: NetworkImage(telIcon),
                        //     fit: BoxFit.fill,
                        //     alignment: AlignmentDirectional.topStart,
                        //   ),
                        // ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(253, 100, 79, 1),
                              Color.fromRGBO(241, 141, 39, 1),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.w),
                            bottomLeft: Radius.circular(
                                cancelTitle != null ? 0.w : 20.w),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          submitTitle,
                          style: font(28, color: '#ffffff'),
                        ).background(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      });
}
