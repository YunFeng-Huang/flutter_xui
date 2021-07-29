import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../css.dart';

// ignore: must_be_immutable
class XSelectDateTime extends StatefulWidget {
  String? initialValue;
  Function? onConfirm;
  Function? onChanged;
  List? list;
  double? width;
  double? height;

  XSelectDateTime({this.initialValue, this.onConfirm, this.onChanged, this.height, this.width});
  @override
  _XSelectDateTimeState createState() => _XSelectDateTimeState();
}

class _XSelectDateTimeState extends State<XSelectDateTime> {
  String? get value => widget.initialValue;
  Function? get onConfirm => widget.onConfirm;
  Function? get onChanged => widget.onChanged;
  List? get list => widget.list;
  double? get width => widget.width;
  double? get height => widget.height;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DatePicker.showDateTimePicker(context, showTitleActions: true, onChanged: (date) {
          print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
          onChanged?.call(date);
        }, onConfirm: (date) {
          print('confirm $date');
          onConfirm?.call(date);
        }, locale: LocaleType.zh);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            value ?? '',
            style: font(14, color: '#999999'),
          ).margin(left: 10.w),
          Icon(
            Icons.keyboard_arrow_down,
            size: 12,
          ).margin(right: 10.w),
        ],
      ).background(width: width ?? 280.w, height: height ?? 36.w, radius: 3.w, borderColor: ThemeColor.line, border: 1.w),
    );
  }
}

class SelectDateTimeEntity {
  String? time;
  int? id;
}

// TextButton(
//   onPressed: () {

//   },
//   child: Text(
//     'show date time picker (Chinese)',
//     style: TextStyle(color: Colors.blue),
//   ),
// ),
