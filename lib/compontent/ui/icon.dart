import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_utils.dart';

Icon icon(IconData type, {size = 18.0, color = "#010101"}) {
  return Icon(
    type,
    size: size.toDouble(),
    color: HexToColor(color),
  );
}

Widget iconAccount = const Icon(IconData(0xe61e, fontFamily: 'iconfont'), color: Color(0xFF000000), size: 20.0);
Widget iconPassword = const Icon(IconData(0xe61d, fontFamily: 'iconfont'), color: Color(0xFF000000), size: 20.0);
Widget collect(bool) {
  if (bool) return const Icon(IconData(0xe615, fontFamily: 'iconfont'), color: Colors.orange);
  return const Icon(IconData(0xe615, fontFamily: 'iconfont'), color: Color(0xFF333333));
}

Widget selected(bool, {color}) {
  if (bool)
    return Container(
      width: 28,
      height: 28,
      child: Icon(IconData(0xe616, fontFamily: 'iconfont'), size: 28, color: color != null ? HexToColor(color) : Color.fromRGBO(255, 176, 3, 1)),
    );
  return Container(
    width: 28,
    height: 28,
    child: Center(
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: HexToColor('#F2F2F2'),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}

// Icon IconAdd(b) {
//   return b ? const Icon(IconData(0xe61c, fontFamily: 'iconfont'), color: Color(0xFF999999)) : const Icon(IconData(0xe61c, fontFamily: 'iconfont'), color: Color(0xFF2EABFF));
// }
// ignore: non_constant_identifier_names
// Icon IconRemove(b) {
//   return b ? const Icon(IconData(0xe61b, fontFamily: 'iconfont'), color: Color(0xFF999999)) : const Icon(IconData(0xe61b, fontFamily: 'iconfont'), color: Color(0xFF2EABFF));
// }

Widget rightIcon() {
  return icon(
    Icons.chevron_right,
    color: '#909090',
    size: 14,
  );
}
