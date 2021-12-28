import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../css.dart';
import '../../index.dart';

// ignore: must_be_immutable
class XSelectDateTime extends StatefulWidget {
  Function? onConfirm;
  Function? onChanged;
  double? width;
  double? height;
  String? currentTime;
  DateTime? minTime;
  DateTime? maxTime;
  CupertinoDatePickerMode? mode;
  String? format;
  TextAlign? textAlign;
  bool? showIcon;
  TextStyle? style;
  Widget? child;
  XSelectDateTime(
      {this.currentTime,
      this.format = 'yyyy-MM-dd HH:mm',
      this.style,
      this.onConfirm,
      this.onChanged,
      this.maxTime,
      this.minTime,
      this.textAlign,
      this.height,
      this.mode,
      this.showIcon = true,
      this.child,
      this.width});
  @override
  _XSelectDateTimeState createState() => _XSelectDateTimeState();
}

class _XSelectDateTimeState extends State<XSelectDateTime> {
  TextStyle? get style => widget.style;
  Function? get onConfirm => widget.onConfirm;
  Function? get onChanged => widget.onChanged;
  double? get width => widget.width;
  double? get height => widget.height;
  DateTime? get minTime => widget.minTime;
  DateTime? get maxTime => widget.maxTime;
  CupertinoDatePickerMode? get mode => widget.mode;
  String? get currentTime =>
      widget.currentTime == null ? null : widget.currentTime!;
  TextAlign? get textAlign => widget.textAlign;
  bool? get showIcon => widget.showIcon;
  // DateTime? get value => DateTime.parse(widget.currentTime!);
  DateTime? _dateTime;
  Widget? get child => widget.child;

  @override
  void initState() {
    super.initState();
    // print(widget.currentTime);
    _dateTime =
        widget.currentTime == null ? null : DateTime.parse(widget.currentTime!);
  }

  @override
  Widget build(BuildContext context) {
    _cupertinoDatePickerWidget() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              XButton(
                text: '取消',
                callback: () {
                  Navigator.pop(context);
                },
              ),
              XButton(
                text: '确定',
                callback: () {
                  onConfirm?.call(
                      DateUtil.formatDate(_dateTime, format: widget.format));
                },
              ),
            ],
          )
              .padding(horizontal: 24.w)
              .background(colorA: Colors.white, height: 100.w),
          Container(
            color: Colors.white,
            height: 600.w,
            child: CupertinoDatePicker(
              initialDateTime: _dateTime,
              minimumDate: minTime,
              maximumDate: maxTime,
              mode: mode ?? CupertinoDatePickerMode.dateAndTime,
              use24hFormat: true,
              onDateTimeChanged: (DateTime dateTime) {
                _dateTime = dateTime;
                onChanged?.call(_dateTime);
                setState(() {});
              },
            ),
          )
        ],
      ).background(height: 700.w);
    }

    return GestureDetector(
      onTap: () async {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => _cupertinoDatePickerWidget(),
        );
      },
      child: child ??
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  currentTime ?? '请选择日期',
                  style: style ?? font(28, color: '#999999'),
                  textAlign: textAlign ?? TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (showIcon!)
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 12,
                ).margin(right: 10.w),
            ],
          ),
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


//  Future showDateSelect(context) async {
//   //获取当前的时间
//   DateTime start = DateTime.now();
//   //在当前的时间上多添加4天
//   DateTime end = DateTime(start.year, start.month, start.day + 4);

//   //显示时间选择器
//   DateTimeRange? selectTimeRange = await showDateRangePicker(
//     context: context,
//     //开始时间
//     firstDate: DateTime(2020, 1),
//     //结束时间
//     lastDate: DateTime(2022, 1),
//     cancelText: "取消",
//     confirmText: "确定",
//     //初始的时间范围选择
//     initialDateRange: DateTimeRange(start: start, end: end),
//   );
//   // //结果
//   // _dateSelectText = selectTimeRange.toString();
//   //选择结果中的开始时间
//   DateTime selectStart = selectTimeRange!.start;
//   //选择结果中的结束时间
//   DateTime selectEnd = selectTimeRange.end;
//   Log.d(selectStart, selectEnd);
//   String startTime =
//       DateUtil.formatDate(selectStart, format: 'yyyy/MM/dd HH:mm:ss');
//   String endTime =
//       DateUtil.formatDate(selectEnd, format: 'yyyy/MM/dd HH:mm:ss');
//   setState(() {
//     searchTime = '$startTime - $endTime';
//   });
// }
