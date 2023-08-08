import 'package:flutter/material.dart';
import 'package:xui/component/ui/html/XImage.dart';

import 'gesture_zoom_box.dart';

class XGalleryImagesWidget extends StatelessWidget {
  final List<GalleryItem> galleryItems;
  final int? index;
  const XGalleryImagesWidget({Key? key, required this.galleryItems, this.index}) : super(key: key);

  void open(BuildContext context) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: false,
          fullscreenDialog: true,
          pageBuilder: (
            BuildContext context,
            animation,
            secondaryAnimation,
          ) {
            return FadeTransition(
              opacity: animation,
              child: GalleryPhotoViewWrapper(
                galleryItems: galleryItems,
                initialIndex: index ?? 0,
                scrollDirection: Axis.horizontal,
              ),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GalleryItemThumbnail(
      galleryItem: galleryItems[index ?? 0],
      onTap: () => open(context),
    );
  }
}

class GalleryItem {
  GalleryItem({
    required this.id,
    required this.child,
    required this.resource,
    this.isSvg = false,
  });

  final String id;
  final Widget child;
  final bool isSvg;
  final String resource;
}

class GalleryItemThumbnail extends StatelessWidget {
  const GalleryItemThumbnail({
    Key? key,
    required this.galleryItem,
    required this.onTap,
  }) : super(key: key);

  final GalleryItem galleryItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: galleryItem.id,
        child: galleryItem.child,
      ),
    );
  }
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<GalleryItem> galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;
  PageController? controller;
  Color color = Colors.black;
  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
  }

  double opacity = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(opacity),
        ),
        // constraints: BoxConstraints.expand(
        //   height: MediaQuery.of(context).size.height,
        // ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // Container(color: Colors.red),
            PageView.builder(
              // physics: physics ? null : new NeverScrollableScrollPhysics(),
              controller: controller,
              itemBuilder: (context, position) {
                final GalleryItem item = widget.galleryItems[position];
                return GestureZoomBox(
                  up: (v, k) {
                    print('v=>>$v');
                    setState(() {
                      opacity = v;
                      // physics = k;
                    });
                  },
                  maxScale: 5.0,
                  doubleTapScale: 2.0,
                  duration: Duration(milliseconds: 200),
                  onPressed: () => Navigator.pop(context),
                  child: Hero(
                    tag: item.id,
                    child: XImage(image: item.resource),
                  ),
                );
              },
              itemCount: widget.galleryItems.length,
              scrollDirection: Axis.horizontal,
              onPageChanged: onPageChanged,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                " ${currentIndex + 1}/${widget.galleryItems.length}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  decoration: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
