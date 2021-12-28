import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class XPConfig {
  late String title;
  late TextStyle style;
  GestureTapCallback? onTap;
  XPConfig(this.title, this.style, {this.onTap});
}

// ignore: must_be_immutable
class XP extends StatelessWidget {
  List<XPConfig> child;
  TextAlign? textAlign;
  XP(this.child,{this.textAlign});
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign:textAlign??TextAlign.start,
      text: TextSpan(
        children: child
            .map<InlineSpan>(
              (XPConfig e) => TextSpan(
                text: e.title,
                style: e.style,
                recognizer: new TapGestureRecognizer()..onTap = e.onTap,
              ),
            )
            .toList(),
      ),
    );
  }
}
