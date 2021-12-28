import 'package:flutter/material.dart';

extension ExtSpace on Widget {
  Padding padding(
          {double left: 0,
          double top: 0,
          double right: 0,
          double bottom: 0,
          vertical,
          horizontal}) =>
      Padding(
        padding: vertical != null || horizontal != null
            ? EdgeInsets.symmetric(
                vertical: vertical ?? 0, horizontal: horizontal ?? 0)
            : EdgeInsets.only(
                left: left, top: top, right: right, bottom: bottom),
        child: this,
      );

  Padding paddingAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);

  Container margin(
          {double left: 0,
          double top: 0,
          double right: 0,
          double bottom: 0,
          vertical,
          horizontal}) =>
      Container(
        margin: vertical != null || horizontal != null
            ? EdgeInsets.symmetric(
                vertical: vertical ?? 0, horizontal: horizontal ?? 0)
            : EdgeInsets.only(
                left: left, top: top, right: right, bottom: bottom),
        child: this,
      );
  Container borderAll(double padding) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(padding),
      ),
      child: this);

  Container border(
          {double topLeft: 10.0,
          double topRight: 10.0,
          double bottomLeft: 10.0,
          double bottomRight: 10.0}) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft),
            topRight: Radius.circular(topRight),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight),
          ),
        ),
        child: this,
      );
  Container marginAll(double margin) =>
      Container(margin: EdgeInsets.all(margin), child: this);
}
