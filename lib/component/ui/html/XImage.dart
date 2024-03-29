import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../index.dart';

enum XImageType { general, avatar ,file }

// ignore: must_be_immutable
class XImage extends StatefulWidget {
  String? image;
  BoxFit? fit;
  double? width;
  double? height;
  double? radius;
  XImageType type;
  Color? background;
  double iconSize = 0.0;
  bool hideIcon = false;
  XImage({Key? key, required this.image, this.fit, this.width, this.height, this.radius, this.type = XImageType.general, this.background, this.hideIcon = false}) : super(key: key) {
    iconSize = (this.height == null ? 40.w : this.height!) / 2;
    background = this.background ?? Colors.transparent;
  }

  @override
  State<XImage> createState() => _XImageState();
}

class _XImageState extends State<XImage> {
  _errorWidget() {
    var _icon = globalConfig.imgList[widget.type];
    if (XUtil.typeOf(_icon) == 'Null') {
      return Center(
        child:const Icon(Icons.error,color: Colors.black38,),
    ).background(width: widget.iconSize, height: widget.iconSize);
    } else if (XUtil.typeOf(_icon) == 'Icon') {
      if (widget.hideIcon) {
        return SizedBox(width: 0, height: 0);
      }
      return Icon(
        _icon.icon,
        size: widget.iconSize,
        color: themeColor.ffFFFFFF,
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
          color: widget.background,
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
        child: Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(themeColor.primary!),
            strokeWidth: 2.w,
          ),
        ).background(width: widget.iconSize, height: widget.iconSize),
      ),
      errorWidget: (context, url, error) => Container(
        width: widget.iconSize, height: widget.iconSize,
        color: widget.background,
        child: _errorWidget(),
      ),
    );

    return cachedNetworkImage;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: widget.image == null || widget.image == ''
          ? Container(
              width: widget.width,
              height: widget.height,
              color: widget.background,
              child:_errorWidget(),
            )
          : widget.image!.contains('http') || widget.image!.contains('assets') == false
              ? _network()
              : Image.asset(
                  widget.image ?? '',
                  fit: widget.fit ?? BoxFit.contain,
                  width: widget.width,
                  height: widget.height,
                ).background(color: widget.background),
      borderRadius: BorderRadius.circular(widget.radius ?? 0),
    );
  }
}
