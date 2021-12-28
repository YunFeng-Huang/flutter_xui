import 'package:flutter/cupertino.dart';
import 'package:xui/compontent/js/index.dart';
import '../index.dart';
import '../js/color_utils.dart';
import 'css.dart';

class XLabelConfig {
  Color? border;
  Color? color;
  TextStyle? style;
  XLabelConfig({this.border, this.color, this.style});
}

// ignore: must_be_immutable
class XLabel extends StatelessWidget {
  List labelList;
  XLabelConfig? config;
  XLabel(this.labelList, {this.config});
  Color get border => config?.border ?? themeColor.line!;
  Color get color => config?.color ?? HexToColor('#F5F5F5');
  TextStyle get style => config?.style ?? font(20, color: '#2D2D2D');
  @override
  Widget build(BuildContext context) {
    if (!isNotNull(labelList)) return Container(height: 0);
    return Row(
      children: labelList.map<Widget>((e) {
        return Container(
          margin: EdgeInsets.only(right: 10.0),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.w),
          decoration: BoxDecoration(
            border: Border.all(color: border, width: 1.w),
            borderRadius: BorderRadius.circular(4),
            color: color,
          ),
          child: Text(e, style: style),
        );
      }).toList(),
    );
  }
}
