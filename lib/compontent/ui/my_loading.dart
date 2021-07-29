import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './index.dart';
import 'css.dart';

class LoadingConfig {
  static String? text;
  static bool? type;
  static void init() {
    text = null;
    type = false;
  }
}

// ignore: must_be_immutable
class Loading extends StatefulWidget {
  String text;
  Loading({this.text = '正在加载'});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String? str;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (LoadingConfig.type ?? false) startTimer();
  }

  void startTimer() {
    const period = const Duration(microseconds: 500);
    _timer = Timer.periodic(period, (timer) {
      setState(() {
        str = LoadingConfig.text;
      });
    });
  }

  void cancelTimer() {
    if (LoadingConfig.type ?? false) _timer.cancel();
    _timer = null as Timer;
  }

  @override
  void dispose() {
    cancelTimer();
    LoadingConfig.init();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          // backgroundColor: Colors.orange[100],
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
          // value: _value/ 190,
          strokeWidth: 2.w,
        ),
        Container(
          child: Text(
            str ?? widget.text,
            style: font(24),
          ),
          margin: EdgeInsets.only(top: 10.0),
        )
      ],
    );
  }
}
