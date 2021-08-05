import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xui/generated/json/base/json_convert_content.dart';
import '../color_utils.dart';
import '../css.dart';

// ignore: must_be_immutable
class XSelectInput extends StatefulWidget {
  SelectTypeEntity? initialValue;
  Function? onSelected;
  List? list;
  double? width;
  double? height;
  XSelectInput({this.initialValue, required this.onSelected, required this.list, this.height, this.width});
  @override
  _XSelectInputState createState() => _XSelectInputState();
}

class _XSelectInputState extends State<XSelectInput> {
  SelectTypeEntity? value;
  Function? get onSelected => widget.onSelected;
  List? get list => widget.list;
  double? get width => widget.width;
  double? get height => widget.height;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      initialValue: value,
      onSelected: (c) {
        value = c as SelectTypeEntity;
        setState(() {});
        print(c);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '${value?.name}',
            style: font(14, color: '#999999'),
          ).margin(left: 10.w),
          Icon(
            Icons.keyboard_arrow_down,
            size: 12,
          ).margin(right: 10.w),
        ],
      ).background(width: width ?? 280.w, height: height ?? 36.w, radius: 3.w, borderColor: ThemeColor.line, border: 1.w),
      itemBuilder: (context) => list!
          .map(
            (c) => PopupMenuItem(
              value: c,
              child: Text(c.name!),
              textStyle: font(14, color: '#262626'),
              height: 36.w,
            ),
          )
          .toList(),
    );
  }
}

class SelectTypeEntity {
  String? name;
  int? id;
  bool? select;
}
