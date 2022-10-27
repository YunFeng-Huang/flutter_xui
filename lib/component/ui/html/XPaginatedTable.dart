import 'package:flutter/cupertino.dart';
import 'package:xui/compontent/index.dart';

// ignore: must_be_immutable
class XPaginatedTable extends StatefulWidget {
  int? totalNum;
  String? pageIndexKey;
  String pageSizeKey;
  Function onChange;
  Function? api;
  Map? params;
  XPaginatedTable({required this.onChange, this.api, this.params, this.totalNum, required this.pageIndexKey, required this.pageSizeKey});
  @override
  _XPaginatedTableState createState() => _XPaginatedTableState();
}

class _XPaginatedTableState extends State<XPaginatedTable> {
  set pageIndex(v) {
    widget.params![widget.pageIndexKey] = v;
  }

  int get pageIndex => widget.params![widget.pageIndexKey];
  int get pageSize => widget.params![widget.pageSizeKey];
  int? get totalNum => widget.totalNum;
  @override
  Widget build(BuildContext context) {
    Log.d(widget.params, 'widget.params');
    if (totalNum == null) return Container();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isNotNull(totalNum)) Text('共${(totalNum! / pageSize).ceil()}页 $totalNum 条数据 , 当前在第 $pageIndex 页'),
        SizedBox(width: 50.w),
        XButton(
          text:  '上一页',
          type: XButtonType.text,
          // params: widget.params,
          // api: widget.api,
          disabled: widget.params![widget.pageIndexKey] == 1,
          callback: () async {
            if (widget.params![widget.pageIndexKey] > 1) {
              pageIndex--;
            } else {
              pageIndex = 1;
            }
            var data = await widget.api!(widget.params);
            widget.onChange.call(data, pageIndex);
            setState(() {});
          },
        ),
        SizedBox(width: 20.w),
        XButton(
          text:  '下一页',
          type: XButtonType.text,
          // params: widget.params,
          // api: widget.api,
          disabled: (totalNum! / pageSize).ceil() <= pageIndex,
          callback: () async {
            if ((totalNum! / pageSize).ceil() > pageIndex) {
              pageIndex++;
            } else {
              pageIndex = (totalNum! / pageSize).ceil();
            }
            var data = await widget.api!(widget.params);
            widget.onChange.call(data, pageIndex);
            setState(() {});
          },
        ),
      ],
    ).padding(right: 10.w);
  }
}
