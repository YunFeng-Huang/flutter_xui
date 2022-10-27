import 'package:flutter/cupertino.dart';
import '../index.dart';

class XMyEmpty extends StatelessWidget {
  const XMyEmpty({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('暂无数据'),
    ).background(minHeight: 400.w);
  }
}