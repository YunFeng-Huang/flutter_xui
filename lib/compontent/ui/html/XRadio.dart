import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../index.dart';

// ignore: must_be_immutable
class XRadio extends StatefulWidget {
  radio type;
  radioParams data;
  Function callback;
  XRadio({required this.type, required this.callback, required this.data});
  @override
  _XRadioState createState() => _XRadioState();
}

class _XRadioState extends State<XRadio> {
  radio get type => widget.type;
  radioParams get data => widget.data;
  Function get callback => widget.callback;
  String _newValue = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newValue = data.defaultValue!;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = data.list!
        .map<Widget>(
          (radioParamsValue e) => Expanded(
            child: RadioListTile<String>(
              value: e.value!,
              title: Container(
                transform: Matrix4.translationValues(-28.w, -1.w, 0),
                child: Text(
                  e.title!,
                  style: e.style ?? font(14, color: '#333333', weight: FontWeight.w400),
                ),
              ),
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              groupValue: _newValue,
              onChanged: (value) {
                setState(() {
                  _newValue = value!;
                  callback.call(value);
                });
              },
            ),
          ),
        )
        .toList();
    // TODO: implement build
    return type == radio.row ? Row(children: _list) : Column(children: _list);
  }
}

enum radio { row, column }

// ignore: camel_case_types
class radioParams {
  String? defaultValue;
  List<radioParamsValue>? list;
  radioParams({this.defaultValue, this.list});
}

// ignore: camel_case_types
class radioParamsValue {
  String? value;
  String? title;
  TextStyle? style;
}
