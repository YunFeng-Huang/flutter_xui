import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../js/color_utils.dart';
import '../css.dart';
import '../../index.dart';

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
  // SelectTypeEntity? value;
  // Function? get onSelected => widget.onSelected;
  set value(v) {
    widget.onSelected!(v);
  }

  SelectTypeEntity? get value => widget.initialValue;

  List? get list => widget.list;
  double? get width => widget.width;
  double? get height => widget.height;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
  }

  @override
  Widget build(BuildContext context) {
    if (value == null) return SizedBox(height: 0, width: 0);
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
      ).background(width: width ?? 280.w, height: height ?? 36.w, radius: 3.w, borderColor: ThemeColor.border, border: 1.w),
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
  Map? data;

  toJson() {
    return 'name=$name,id=$id,select=$select,data=$data';
  }
}
