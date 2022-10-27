
import 'package:flutter/material.dart' hide Action;

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  static const FloatingActionButtonLocation customFloat = CustomFloatingActionButtonLocation(20);
  final double bottom;
  final int? index;
  final int? max;

  const CustomFloatingActionButtonLocation(this.bottom, {this.max, this.index});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    double fabX = (scaffoldGeometry.scaffoldSize.width - scaffoldGeometry.floatingActionButtonSize.width) / 2.0;
    if (this.max != null && this.index != null) {
      fabX = (scaffoldGeometry.scaffoldSize.width / this.max! - scaffoldGeometry.floatingActionButtonSize.width) / 2 + scaffoldGeometry.scaffoldSize.width / this.max! * (this.index ?? 0);
    }
    // Compute the y-axis offset.
    final double bottomSheetHeight = scaffoldGeometry.bottomSheetSize.height;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    double fabY = scaffoldGeometry.scaffoldSize.height - bottomSheetHeight - this.bottom - fabHeight;
    return Offset(fabX, fabY);
  }

  @override
  String toString() => 'FloatingActionButtonLocation.endTop';
}

class CustomFloatingActionButtonAnimator extends FloatingActionButtonAnimator {
  double? _x;
  double? _y;

  @override
  Offset getOffset({ Offset? begin,  Offset? end,  double? progress}) {
    _x = begin!.dx + (end!.dx - begin.dx) * progress!;
    _y = begin.dy + (end.dy - begin.dy) * progress;
    return Offset(_x!, _y!);
  }

  @override
  Animation<double> getRotationAnimation({Animation<double>? parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent!);
  }

  @override
  Animation<double> getScaleAnimation({Animation<double>? parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent!);
  }
}
