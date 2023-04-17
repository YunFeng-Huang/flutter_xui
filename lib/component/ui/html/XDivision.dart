// ignore:non_constant_identifier_names
import 'package:flutter/cupertino.dart';
import '../../index.dart';
import '../css.dart';

// ignore: must_be_immutable
class XDivision extends StatelessWidget {
  double? width;
  double? height;
  XDivision({this.width, this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: themeColor.ffE0E4E8,
    );
  }
}
