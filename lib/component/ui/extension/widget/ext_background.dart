import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../index.dart';
import '../../css.dart';

extension ExtBg on Widget {
  Widget background({
    Color? color,
    String? bgImage,
    BoxFit? fitBgImage,
    BoxShape shape = BoxShape.rectangle,
    double? radius,
    double? border,
    Color? borderColor,
    double? borderLeft,
    double? borderTop,
    double? borderRight,
    double? borderBottom,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
    double? width,
    double? height,
    double? maxWidth,
    double? maxHeight,
    double? minWidth,
    double? minHeight,
    BoxDecoration? decoration,
    Alignment? alignment,
  }) {
    bool allBorderRadiusNull = topLeft == null &&
        topRight == null &&
        bottomLeft == null &&
        bottomRight == null;
    bool allBorderNull = borderLeft == null &&
        borderTop == null &&
        borderRight == null &&
        borderBottom == null;

    return ClipRRect(
        // borderRadius: BorderRadius.all(Radius.circular(0)),
        borderRadius: !allBorderRadiusNull && borderColor==null ? BorderRadius.only(
                    topLeft: Radius.circular(topLeft ?? 0),
                    topRight: Radius.circular(topRight ?? 0),
                    bottomLeft: Radius.circular(bottomLeft ?? 0),
                    bottomRight: Radius.circular(bottomRight ?? 0),
                  )
                : BorderRadius.all(Radius.circular(0)),
        child: Container(
          width: width,
          height: height,
          child: this,
          constraints: (maxWidth != null ||
                  maxHeight != null ||
                  minWidth != null ||
                  minHeight != null)
              ? BoxConstraints(
                  maxWidth: maxWidth ?? double.infinity,
                  maxHeight: maxHeight ?? double.infinity,
                  minWidth: minWidth ?? 0.0,
                  minHeight: minHeight ?? 0.0,
                )
              : null,
          alignment: alignment,
          decoration: decoration != null
              ? decoration
              : BoxDecoration(
                  color: color,
                  shape: shape,
                  image: bgImage == null
                      ? null
                      : DecorationImage(
                          image: bgImage.contains('http')
                              ? NetworkImage(bgImage)
                              : AssetImage(bgImage) as ImageProvider<Object>,
                          fit: fitBgImage ?? BoxFit.contain,
                        ),
                  border: !allBorderNull
                      ? Border(
                          left: borderLeft == null
                              ? BorderSide.none
                              : BorderSide(
                                  color: borderColor ?? themeColor.ffDEDFDE!,
                                  width: borderLeft,
                                ),
                          top: borderTop == null
                              ? BorderSide.none
                              : BorderSide(
                                  color: borderColor ?? themeColor.ffDEDFDE!,
                                  width: borderTop,
                                ),
                          right: borderRight == null
                              ? BorderSide.none
                              : BorderSide(
                                  color: borderColor ?? themeColor.ffDEDFDE!,
                                  width: borderRight,
                                ),
                          bottom: borderBottom == null
                              ? BorderSide.none
                              : BorderSide(
                                  color: borderColor ?? themeColor.ffDEDFDE!,
                                  width: borderBottom,
                                ),
                        )
                      : border == null
                          ? null
                          : Border.all(
                              width: border,
                              color: borderColor ?? themeColor.ffDEDFDE!),
                  borderRadius: !allBorderNull
                      ? null
                      : allBorderRadiusNull
                          ? BorderRadius.all(Radius.circular(radius ?? 0))
                          : BorderRadius.only(
                              topLeft: Radius.circular(topLeft ?? 0),
                              topRight: Radius.circular(topRight ?? 0),
                              bottomLeft: Radius.circular(bottomLeft ?? 0),
                              bottomRight: Radius.circular(bottomRight ?? 0),
                            ),
                ),
        ));
  }
}
