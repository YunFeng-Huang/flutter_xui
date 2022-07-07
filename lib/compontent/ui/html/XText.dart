import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class XText extends StatefulWidget {
  String? msg = '';
  TextStyle? style;
  int? maxLines;
  TextOverflow? overflow;
  XText(this.msg, {Key? key, required this.style, this.maxLines, this.overflow})
      : super(key: key);

  @override
  State<XText> createState() => _XTextState();
}

class _XTextState extends State<XText> {
  @override
  Widget build(BuildContext context) {
    if (widget.msg == "") {
      return Container(height: 0);
    }
    return Text(
      widget.msg ?? "",
      style: widget.style?.copyWith(height: 1.0),
      strutStyle: StrutStyle(
        fontSize: widget.style?.fontSize,
        height: 1.0,
        leading: ((widget.style?.height ?? 0.0) - 1.0) / 2,
        forceStrutHeight: true,
      ),
      maxLines: widget.maxLines,
      overflow: widget.overflow,
    );
  }
}
