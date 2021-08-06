import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xui/compontent/js/index.dart';

import '../../js/color_utils.dart';
import '../../index.dart';

// var data = [
//   {'date': '2016-05-02', 'name': '王小虎', 'address': '区金沙江路 1518 弄'},
//   {'date': '2016-05-02', 'name': '王小', 'address': '上海市 弄'},
//   {'date': '2016-05-02', 'name': '王小虎王小虎王小虎', 'address': '上海市普陀区金沙江普陀区金沙江路 1518 弄'},
//   {'date': '2016-05-02', 'name': '王小王小虎虎', 'address': '上海市普普陀区金沙江普陀区金沙江陀区金沙江路 1518 弄'},
//   {'date': '2016-05-02', 'name': '王小虎', 'address': '上海市普陀区金沙江路 1518 弄'},
//   {'date': '2016-05-02', 'name': '王王小虎王小虎小虎', 'address': '上海市普陀区普陀区金沙江金沙江路 1518 弄'},
//   {'date': '2016-05-02', 'name': '王小虎', 'address': '上海市普陀区金沙江路 1518 弄'},
//   {'date': '2016-05-02', 'name': '王小虎', 'address': '上海市普陀区金沙江路 1518 弄'},
//   {'date': '2016-05-02', 'name': '王小虎', 'address': '上海市普陀区金沙江路 1518 弄'},
// ];
// List<TableColumn> tableColumn = [
//   TableColumn(prop: 'date', label: '日期'),
//   TableColumn(prop: 'name', label: '名字'),
//   TableColumn(prop: 'address', label: '地址', width: 300.w, maxLines: 3, alignment: Alignment.centerLeft),
//   TableColumn(
//     prop: 'btn',
//     label: '操作',
//     maxLines: 3,
//     widget: Container(
//       child: Text(
//         '详情',
//         style: font(14, color: '#3399FF', weight: FontWeight.w400),
//       ),
//     ),
//   )
// ];
// XTable(
// data: data,
// tableColumn: tableColumn,
// config: TableConfig()
// ..style = font(14, colorA: Color.fromRGBO(0, 0, 0, 0.65), weight: FontWeight.w400)
// ..headerStyle = font(14, colorA: Color.fromRGBO(0, 0, 0, 0.65), weight: FontWeight.w500),
// ).paddingAll(20.w)
// ignore: must_be_immutable
class XTable extends StatefulWidget {
  List data;
  bool? expanded;
  Function? onRefresh;
  Function? onLoading;
  List<TableColumn> tableColumn;
  TableConfig? config;
  XTable({required this.data, required this.tableColumn, this.config, this.onLoading, this.onRefresh, this.expanded});
  @override
  _XTableState createState() => _XTableState();
}

class _XTableState extends State<XTable> {
  List get data => widget.data;
  List<TableColumn> get list => widget.tableColumn;
  TableConfig? get config => widget.config;
  String? get headerBackground => config?.headerBackground;
  bool? get expanded => widget.expanded ?? true;
  Function? get onRefresh => widget.onRefresh;
  Function? get onLoading => widget.onLoading;
  // var headerBackground = '#FAFAFA';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // headerBackground = widget.config?.headerBackground ?? headerBackground;
  }

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await onRefresh?.call();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await onLoading?.call();
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            list.length,
            (index) => Text(
              '${list[index].label}',
              style: config?.headerStyle,
            )
                .background(
                  width: list[index].width,
                  alignment: list[index].alignment,
                )
                .margin(
                  top: 10.w,
                  bottom: 10.w,
                ),
          ),
        ).padding(horizontal: 10.w).background(
              color: HexToColor(headerBackground!),
            ),
        data.length == 0
            ? Center(
                child: Text('暂无数据'),
              ).background(minHeight: 300.w)
            : Column(
                children: List.generate(
                  data.length,
                  (index) {
                    List<Widget> itemList = [];
                    var item = data[index];
                    list.forEach((element) {
                      var _pop = item[element.prop];
                      var _maxLines = element.maxLines;
                      var _width = element.width;
                      Widget _widget;
                      if (isNotNull(element.widget)) {
                        _widget = element.widget!.call(index);
                      } else {
                        _widget = Text(
                          '$_pop',
                          style: config?.style,
                          maxLines: _maxLines,
                          overflow: TextOverflow.ellipsis,
                        );
                      }
                      itemList.add(_widget.background(
                        alignment: element.alignment,
                        width: _width,
                      ));
                    });
                    return Row(children: itemList, mainAxisAlignment: MainAxisAlignment.spaceBetween)
                        .padding(
                          top: 10.w,
                          bottom: 10.w,
                        )
                        .background(
                          borderBottom: 1.w,
                          borderColor: HexToColor('#E9E9E9'),
                        );
                  },
                ),
              ).padding(horizontal: 10.w)
      ]),
    );
    return isNotNull(onRefresh)
        ? SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView(
              children: [child],
            ),
          )
        : child;
  }
}

class TableColumn {
  String? prop;
  String? label;
  double? width;
  int? maxLines;
  Function? widget;
  Alignment? alignment;
  TableColumn({this.prop, this.label, this.width, this.widget, this.maxLines, this.alignment}) {
    width = this.width ?? 150.w;
    alignment = this.alignment ?? Alignment.center;
  }
}

class TableConfig {
  String? headerBackground;
  TextStyle? style;
  TextStyle? headerStyle;
  TableConfig({this.headerBackground, this.style, this.headerStyle}) {
    headerBackground = this.headerBackground ?? '#FAFAFA';
  }
}
