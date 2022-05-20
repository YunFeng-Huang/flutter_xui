import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../xui.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  double offset = 0.00;
  double height = 120.w;
  double get opacity {
    var diff = offset / height;
    if (diff > 0) {
      return diff > 1 ? 1 : diff;
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime newTime = DateTime.now();
    return CustomHeader(
        builder: (BuildContext context, RefreshStatus? mode) {
          String text = '';
          switch (mode) {
            case RefreshStatus.refreshing:
              text = "更新中";
              break;
            case RefreshStatus.completed:
              text = "更新成功";
              break;
            case RefreshStatus.failed:
              text = "更新失败";
              break;
            default:
              text =
                  '释放刷新 最后更新 ${newTime.hour}:${newTime.minute > 9 ? newTime.minute : ('0${newTime.minute}')}:${newTime.second}';
              break;
          }
          return Opacity(
            opacity: opacity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                XImage(
                  image: globalConfig.defaultImg,
                  width: 28.w,
                  height: 22.w,
                )
                    .center
                    .padding(top: 4.w)
                    .background(
                      border: 2.w,
                      borderColor: HexToColor('#FF4300'),
                      radius: 100.w,
                      width: 44.w,
                      height: 44.w,
                    )
                    .margin(vertical: 15.w),
                Text(text, style: font(24, color: '#9EA6AE')),
              ],
            ).center,
          );
        },
        onOffsetChange: (double value) {
          setState(() {
            offset = value;
          });
        },
        height: height);
  }
}
