import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huanhu/compontent/js/index.dart';
import 'package:flutter_huanhu/compontent/ui/color_utils.dart';
import '../index.dart';

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
  List<TableColumn> tableColumn;
  TableConfig? config;
  XTable({required this.data, required this.tableColumn, this.config});
  @override
  _XTableState createState() => _XTableState();
}

class _XTableState extends State<XTable> {
  List get data => widget.data;
  List<TableColumn> get list => widget.tableColumn;
  TableConfig? get config => widget.config;
  String? get headerBackground => config?.headerBackground;

  // var headerBackground = '#FAFAFA';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // headerBackground = widget.config?.headerBackground ?? headerBackground;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                .padding(
                  top: 10.w,
                  bottom: 10.w,
                  right: 20.w,
                  left: 20.w,
                ),
          ),
        ).background(
          color: HexToColor(headerBackground!),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
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
                      _widget = element.widget!;
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
                        right: 20.w,
                        left: 20.w,
                      )
                      .background(
                        borderBottom: 1.w,
                        borderColor: index == data.length - 1 ? null : HexToColor('#E9E9E9'),
                      );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}

class TableColumn {
  String? prop;
  String? label;
  double? width;
  int? maxLines;
  Widget? widget;
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
