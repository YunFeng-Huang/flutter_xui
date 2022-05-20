import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../index.dart';

enum XImageType { general, avatar }

// ignore: must_be_immutable
class XImage extends StatefulWidget {
  String? image;
  BoxFit? fit;
  double? width;
  double? height;
  double? borderRadius;
  XImageType type;
  String errorWidgetBackground;
  double iconSize = 0.0;
  XImage({
    Key? key,
    required this.image,
    this.fit,
    this.width,
    this.height,
    this.borderRadius,
    this.type = XImageType.general,
    this.errorWidgetBackground = '#F3F6F9',
  }) : super(key: key) {
    iconSize = (this.height == null ? 40.w : this.height!) / 2;
  }

  @override
  State<XImage> createState() => _XImageState();
}

class _XImageState extends State<XImage> {
  _errorWidget() {
    var _icon = globalConfig.imgList[widget.type];
    if (typeOf(_icon) == 'Icon') {
      return Icon(
        _icon.icon,
        size: widget.iconSize,
        color: _icon.color,
      );
    } else {
      return Center(child: XImage(image: _icon));
    }
  }

  _network() {
    return CachedNetworkImage(
      fadeInDuration : const Duration(milliseconds: 0),
      fadeOutDuration : const Duration(milliseconds: 0),
      imageUrl: widget.image ?? '',
      fit: widget.fit ?? BoxFit.contain,
      width: widget.width,
      height: widget.height,
      placeholder: (context, url) => _errorWidget(),
      // placeholder: (context, url) => Center(
      //   child: Container(
      //     width: widget.iconSize,
      //     height: widget.iconSize,
      //     color: Colors.redAccent,
      //     // child: CircularProgressIndicator(strokeWidth: 0.5),
      //   ),
      // ),
      errorWidget: (context, url, error) => Center(
        child: _errorWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: widget.image == null ||
              widget.image == '' ||
              widget.image!.contains('http')
          ? _network()
          : Image.asset(
              widget.image ?? '',
              fit: widget.fit ?? BoxFit.contain,
              width: widget.width,
              height: widget.height,
            ),
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
    );
  }
}
