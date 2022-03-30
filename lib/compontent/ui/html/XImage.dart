import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xui/compontent/js/index.dart';
import '../../index.dart';

// ignore: must_be_immutable
class XImage extends StatelessWidget {
  String? image;
  BoxFit? fit;
  double? width;
  double? height;
  double? borderRadius;
  XImage(
      {required this.image,
      this.fit,
      this.width,
      this.height,
      this.borderRadius});
  @override
  Widget build(BuildContext context) {
    return XImg(
      image: image,
      fit: fit,
      width: width,
      height: height,
      borderRadius: borderRadius,
    );
  }
}

// ignore: non_constant_identifier_names
Widget XImg({image, fit, width, height, borderRadius}) {
  _network() {
    return CachedNetworkImage(
      imageUrl: image,
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      placeholder: (context, url) => Center(
        child: Container(
          width: 40.w,
          height: 40.w,
          child: CircularProgressIndicator(strokeWidth: 1),
        ),
      ),
      errorWidget: (context, url, error) => Center(
        child: Container(
          width: 40.w,
          height: 40.w,
          child: CircularProgressIndicator(strokeWidth: 1),
        ),
      ),
    );
  }
  return ClipRRect(
    child: image == null ||image == '' || image.contains('http')
        ? _network()
        : Image.asset(
            image,
            fit: fit ?? BoxFit.contain,
            width: width,
            height: height,
          ),
    borderRadius: BorderRadius.circular(borderRadius ?? 0),
  );
}
