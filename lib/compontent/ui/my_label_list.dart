import 'package:flutter/cupertino.dart';
import 'package:xui/compontent/js/index.dart';
import './index.dart';
import 'color_utils.dart';
import 'css.dart';

// ignore: must_be_immutable
class XLabel extends StatelessWidget {
  List labelList;
  XLabel(this.labelList);

  @override
  Widget build(BuildContext context) {
    if (!isNotNull(labelList)) return Container();
    return Row(
      children: labelList.map<Widget>((e) {
        return Container(
          margin: EdgeInsets.only(right: 10.0),
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1.w),
          decoration: BoxDecoration(
            border: Border.all(color: HexToColor('#E8E8E8'), width: 1.w),
            borderRadius: BorderRadius.circular(4),
            color: HexToColor('#F5F5F5'),
          ),
          child: Text(
            e,
            style: font(20, color: '#2D2D2D'),
          ),
        );
      }).toList(),
    );
  }
}
