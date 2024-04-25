import 'package:flutter/material.dart';

// ignore: must_be_immutable
class XButton extends StatelessWidget {
  Widget? child;
  Function callback;
  XButton({
    this.child,
    required this.callback,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => callback(),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
