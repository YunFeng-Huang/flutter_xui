import 'package:flutter/material.dart';

///Align布局位置扩展
extension ExtAlign on Widget {
  Align get topLeft => Align(alignment: Alignment.topLeft, child: this);

  Align get topCenter => Align(alignment: Alignment.topCenter, child: this);

  Align get topRight => Align(alignment: Alignment.topRight, child: this);

  Align get bottomLeft => Align(alignment: Alignment.bottomLeft, child: this);

  Align get bottomCenter => Align(alignment: Alignment.bottomCenter, child: this);

  Align get bottomRight => Align(alignment: Alignment.bottomRight, child: this);

  Align get centerLeft => Align(alignment: Alignment.centerLeft, child: this);

  Align get center => Align(alignment: Alignment.center, child: this);

  Align get centerRight => Align(alignment: Alignment.centerRight, child: this);
}
