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
  Color? background;
  double iconSize = 0.0;
  bool hideIcon = false;
  XImage(
      {Key? key,
      required this.image,
      this.fit,
      this.width,
      this.height,
      this.borderRadius,
      this.type = XImageType.general,
      this.background,
      this.hideIcon = false})
      : super(key: key) {
    iconSize = (this.height == null ? 40.w : this.height!) / 2;
    background = this.background ?? globalConfig.theme.backgroundColor;
  }

  @override
  State<XImage> createState() => _XImageState();
}

class _XImageState extends State<XImage> {
  _errorWidget() {
    var _icon = globalConfig.imgList[widget.type];
    if (typeOf(_icon) == 'Icon') {
      if (widget.hideIcon) {
        return SizedBox(width: 0, height: 0);
      }
      return Icon(
        _icon.icon,
        size: widget.iconSize,
        color: globalConfig.theme.primaryColorLight,
      );
    } else {
      return Center(child: XImage(image: _icon));
    }
  }

  _network() {
    CachedNetworkImage cachedNetworkImage = CachedNetworkImage(
      useOldImageOnUrlChange: true,
      fadeInDuration: Duration(milliseconds: 0),
      fadeOutDuration: Duration(milliseconds: 0),
      fadeInCurve: Curves.linear,
      fadeOutCurve: Curves.linear,
      imageUrl: widget.image ?? '',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: widget.fit ?? BoxFit.contain,
          ),
        ),
      ),
      fit: widget.fit ?? BoxFit.contain,
      width: widget.width,
      height: widget.height,
      placeholder: (context, url) => Container(
        color: widget.background,
        child: _errorWidget(),
      ),
      errorWidget: (context, url, error) => Container(
        color: widget.background,
        child: _errorWidget(),
      ),
    );

    return cachedNetworkImage;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.image == null || widget.image == '') {
      return Container(
        color: widget.background,
        child: _errorWidget(),
      );
    }
    return ClipRRect(
      child: widget.image == null ||
              widget.image == '' ||
              widget.image!.contains('http') ||
              widget.image!.contains('assets') == false
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
