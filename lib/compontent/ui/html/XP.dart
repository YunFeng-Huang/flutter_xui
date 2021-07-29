import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

// ignore: must_be_immutable
class XP extends StatelessWidget {
  List child;
  XP(this.child);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: child
            .map<InlineSpan>(
              (e) => TextSpan(text: e['title'].toString(), style: e['style'], recognizer: new TapGestureRecognizer()..onTap = e.containsKey('onTap') ? e['onTap'] : null),
            )
            .toList(),
      ),
    );
  }
}
