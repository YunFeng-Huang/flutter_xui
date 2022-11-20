import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class XPConfig {
  String? title;
  TextStyle? style;
  Widget? child;
  GestureTapCallback? onTap;
  XPConfig({this.title, this.style, this.onTap, this.child});
}

// ignore: must_be_immutable
class XP extends StatelessWidget {
  List<XPConfig> child;
  TextAlign? textAlign;
  final TextSpan? label;
  XP(this.child, {this.textAlign, this.label});
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.start,
      // softWrap:false,
      text: TextSpan(
        text: label?.text ?? '',
        style: label?.style,
        recognizer: label?.recognizer,
        children: child
            .map<InlineSpan>(
              (XPConfig e) => e.child == null
                  ? TextSpan(
                      text: e.title,
                      style: e.style,
                      recognizer: new TapGestureRecognizer()..onTap = e.onTap,
                
                    )
                  : WidgetSpan(child: e.child!),
            )
            .toList(),
      ),
    );
  }
}
