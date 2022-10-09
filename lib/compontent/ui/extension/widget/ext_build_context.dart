import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  /// 获取当前组件的 RenderBox
  RenderBox? renderBox() {
    return this.findRenderObject() is RenderBox
        ? (this.findRenderObject() as RenderBox)
        : null;
  }

  /// 获取当前组件的 position
  Offset? position({Offset offset = Offset.zero}) {
    return this.renderBox()?.localToGlobal(offset);
  }
}

extension GlobalKeyExt on GlobalKey {
  /// 获取当前组件的 RenderBox
  RenderBox? renderBox() => this.currentContext?.renderBox();

  /// 获取当前组件的 position
  Offset? position({Offset offset = Offset.zero}) =>
      this.currentContext?.position(offset: offset);

  /// 获取当前组件的 Size
  Size? get size => this.currentContext?.size;
}
