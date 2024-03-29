import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide PopupMenuItem, PopupMenuButton;
import 'package:xui/component/ui/default/popup_menu.dart';
import 'package:xui/component/ui/extension/widget/ext_size.dart';

import '../../index.dart';

// ignore: must_be_immutable
class XSelectInput extends StatefulWidget {
  SelectTypeEntity? initialValue;
  Function? onSelected;
  List<SelectTypeEntity>? list;
  Widget child;
  Function itemBuilder;
  bool? hiddenDivider;
  Offset? offset;
  ArrowDropUpOffset? arrowDropUpOffset;
  XSelectInput({this.initialValue, required this.onSelected, required this.list, required this.child, required this.itemBuilder, this.hiddenDivider, this.offset, this.arrowDropUpOffset});
  @override
  _XSelectInputState createState() => _XSelectInputState();
}

class _XSelectInputState extends State<XSelectInput> {
  // SelectTypeEntity? value;
  // Function? get onSelected => widget.onSelected;
  // set value(v) {
  //   widget.onSelected!(v);
  //   // widget.initialValue = v;
  // }

  // SelectTypeEntity? get value => widget.initialValue;

  List<SelectTypeEntity>? get list => widget.list;
  Widget get child => widget.child;
  Function get itemBuilder => widget.itemBuilder;
  bool get hiddenDivider => widget.hiddenDivider ?? false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (value == null) return SizedBox(height: 0, width: 0);
    return Theme(
      data: Theme.of(context).copyWith(
        cardColor: themeColor.ffFFFFFF,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: PopupMenuButton(
        arrowDropUpOffset: widget.arrowDropUpOffset,
        offset: widget.offset ?? Offset.zero,
        initialValue: widget.initialValue,
        onSelected: (c) {
          // value = c as SelectTypeEntity;
          widget.initialValue = c as SelectTypeEntity;
          widget.onSelected!(c);
          setState(() {});
        },
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: themeColor.ffFFFFFF!),
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: child,
        itemBuilder: (context) => List.generate(list?.length ?? 0, (index) {
          SelectTypeEntity c = list![index];
          return PopupMenuItem(
            value: c,
            child: Container(
              child: itemBuilder(c),
              decoration: BoxDecoration(
                border: Border(
                  top: index == 0 || hiddenDivider
                      ? BorderSide.none
                      : BorderSide(
                          color: themeColor.ffDEDFDE!,
                          width: 1.w,
                        ),
                ),
              ),
            ),
            padding: EdgeInsets.all(0),
            height: 0,
          );
        }),
      ),
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
