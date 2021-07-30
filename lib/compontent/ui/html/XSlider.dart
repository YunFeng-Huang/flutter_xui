import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huanhu/compontent/ui/css.dart';
import '../index.dart';

// ignore: must_be_immutable
class XSlider extends StatelessWidget {
  ValueChanged<double>? onChanged;
  double value;
  XSlider({required this.onChanged, required this.value});
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Color(0XFF3399FF),
        inactiveTrackColor: Color(0X1A3075EE),
        trackHeight: 4.w,
        thumbColor: Color(0XFF3075EE),
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4.w),
        overlayShape: SliderComponentShape.noOverlay,
      ),
      child: Slider(
        onChanged: onChanged,
        value: value,
      ),
    );
  }
}
