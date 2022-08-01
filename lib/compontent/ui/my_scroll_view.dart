import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../index.dart';
import 'my_scroll_view_widget/appBarWidget.dart';
import 'my_scroll_view_widget/bottomAppBarWrap.dart';
import 'my_scroll_view_widget/headerWidget.dart';
import 'my_scroll_view_widget/smartRefresherCustomFooter.dart';

enum PageStatus { loading, error, success }

// ignore: must_be_immutable
class XCustomScrollView extends StatefulWidget {
  List<Widget> list = [];
  XCustomScrollViewAppbar? appbar;
  // ignore: non_constant_identifier_names
  AppBar? xAppBar;
  Color backgroundColor;
  PageStatus status = PageStatus.loading;
  Function? slivers;
  Widget? bottomAppBar;
  Widget? headerLoading;
  Widget emptyWidget;
  Widget? errorWidget;
  Widget? loadingWidget;
  Function? onRefresh;
  Function? onLoading;
  Function(ScrollController, RefreshController)? init;
  double? appbarHeight;
  Widget? footer;
  XBottomAppBarConfig? bottomAppBarConfig;
  bool? resizeToAvoidBottomInset;
  bool? scrollbar;
  XCustomScrollView(
      {Key? key,
      this.scrollbar = true,
      this.onRefresh,
      this.appbarHeight,
      this.onLoading,
      this.init,
      this.resizeToAvoidBottomInset,
      required this.status,
      required this.slivers,
      required this.emptyWidget,
      this.errorWidget,
      this.appbar,
      this.backgroundColor = Colors.transparent,
      this.bottomAppBar,
      this.xAppBar,
      this.bottomAppBarConfig,
      this.headerLoading,
      this.loadingWidget,
      this.footer})
      : super(key: key) {
    headerLoading = this.headerLoading ?? HeaderWidget();
    list = [];
    if (status != PageStatus.loading) {
      list = List.from(slivers!());
      if (bottomAppBar != null) {
        bottomAppBarConfig = bottomAppBarConfig ?? XBottomAppBarConfig();
        list.add(
          SliverToBoxAdapter(
            child: SizedBox(
              height: (this.bottomAppBarConfig?.bottomAppBarHeight ?? 0.0),
            ),
          ),
        );
      }
    }
  }

  @override
  XCustomScrollViewState createState() => XCustomScrollViewState();
}

class XCustomScrollViewState extends State<XCustomScrollView> {
  PageStatus get status => widget.status;
  Widget get EmptyWidget => widget.emptyWidget;
  Widget? get errorWidget => widget.errorWidget;
  Widget? get loadingWidget => widget.loadingWidget;
  XCustomScrollViewAppbar? get appbar => widget.appbar;
  Widget get headerLoading => widget.headerLoading!;
  Color get backgroundColor => widget.backgroundColor;
  List<Widget> get slivers => widget.list;
  Widget? get bottomAppBar => widget.bottomAppBar;
  // ScrollController controller = ScrollController();
  double opacity = 0.0;
  double get appbarHeight => widget.appbarHeight ?? 100.w;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Function? get onRefresh => widget.onRefresh;
  Function? get onLoading => widget.onLoading;
  AppBar? get xAppBar => widget.xAppBar;
  Color? get bottomAppBarColor => widget.bottomAppBarConfig?.bottomAppBarColor!;
  double get bottomAppBarHeight =>
      widget.bottomAppBarConfig?.bottomAppBarHeight! ?? 0.0;
  Timer? _timer;
  ScrollController? controller = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ScrollController();
    widget.init?.call(controller!, _refreshController);
    if (!isNotNull(appbar?.customAppBar))
      controller?.addListener(() {
        setState(() {
          opacity = (controller?.offset ?? 0.0) >= appbarHeight
              ? 1.00
              : (controller?.offset ?? 0.0) / appbarHeight;
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
    // print('dispose=====');
    // widget.controller?.dispose();
  }

  void _onRefresh() async {
    bool success = await onRefresh?.call();
    if (success) {
      _refreshController.refreshCompleted();
    } else {
      _refreshController.refreshFailed();
    }
    _refreshController.loadComplete();
  }

  void _onLoading() async {
    bool more = await onLoading?.call();
    if (more) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
      return;
    }
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if (mounted) setState(() {});
  }

  _footerBottom() {
    return XBottomAppBarWrap(
      child: bottomAppBar,
      color: bottomAppBarColor,
      height: bottomAppBarHeight,
      boxShadow: widget.bottomAppBarConfig?.boxShadow,
      heightAuto: widget.bottomAppBarConfig?.bottomAppBarHeightAuto,
    );
  }

  void animateTo(double position) {
    controller?.animateTo(
      position,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void toBottom() {
    controller?.animateTo(
      controller?.position.maxScrollExtent ?? 0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    var _scrollWidget = () {
      return Column(
        children: [
          Expanded(
            child: ScrollConfiguration(
              behavior: CusBehavior(), // 自定义的 behavior
              child: SmartRefresher(
                // ignore: unnecessary_null_comparison
                enablePullDown: onRefresh != null,
                // ignore: unnecessary_null_comparison
                enablePullUp: onLoading != null,
                header: headerLoading,
                footer: widget.footer ?? XSmartRefresherCustomFooter(),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: status == PageStatus.loading
                    ? Center(child: loadingWidget ?? Loading())
                    : status == PageStatus.error
                        ? Transform.translate(
                            offset: Offset(0, -90.w),
                            child: Center(
                              child: errorWidget ??
                                  Center(
                                    child: Text('错误页面'),
                                  ),
                            ),
                          )
                        : slivers.length == 0
                            ? Center(child: EmptyWidget)
                            : CustomScrollView(
                                physics: ClampingScrollPhysics(),
                                controller: controller,
                                slivers: slivers,
                              ),
              ),
            ),
          ),
          // if (bottomAppBar != null) SizedBox(height: bottomAppBarHeight)
        ],
      );
    };
    return Scaffold(
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      backgroundColor: backgroundColor,
      appBar: xAppBar,
      // floatingActionButton: bottomAppBar == null ? null : _footerBottom(),
      // floatingActionButtonAnimator:
      //     bottomAppBar == null ? null : CustomFloatingActionButtonAnimator(),
      // floatingActionButtonLocation:
      //     bottomAppBar == null ? null : CustomFloatingActionButtonLocation(0),
      body: SafeArea(
        child: Stack(
          children: [
            widget.scrollbar ?? false
                ? Scrollbar(
                    child: _scrollWidget(),
                  )
                : _scrollWidget(),
            if (!isNotNull(appbar?.customAppBar) && isNotNull(appbar))
              XAppBarWidget(
                context,
                title: appbar?.title,
                appbarHeight: appbarHeight,
                color: Colors.white.withOpacity(1 - opacity),
              ).background(
                color: Colors.white.withOpacity(opacity),
              ),
            if (!isNotNull(appbar?.customAppBar) && isNotNull(appbar))
              XAppBarWidget(
                context,
                title: appbar?.title,
                appbarHeight: appbarHeight,
                color: Colors.black.withOpacity(opacity),
              ),
            if (isNotNull(appbar?.customAppBar) && isNotNull(appbar))
              appbar!.customAppBar!,
            if (bottomAppBar != null && status == PageStatus.success)
              Positioned(
                child: _footerBottom(),
                bottom: 0,
                left: 0,
                right: 0,
              ),
          ],
        ),
        bottom: true,
        top: false,
      ),
    );
  }
}

class XCustomScrollViewAppbar {
  String? title;
  Widget? customAppBar;
  XCustomScrollViewAppbar({this.title, this.customAppBar});
}

class XBottomAppBarConfig {
  Color? bottomAppBarColor;
  double? bottomAppBarHeight;
  bool? bottomAppBarHeightAuto;
  List<BoxShadow>? boxShadow;
  XBottomAppBarConfig({
    this.bottomAppBarColor,
    this.bottomAppBarHeight,
    this.bottomAppBarHeightAuto,
    this.boxShadow,
  }) {
    bottomAppBarColor = this.bottomAppBarColor ?? Colors.white;
    bottomAppBarHeight = this.bottomAppBarHeight ?? 0.0;
    bottomAppBarHeightAuto = this.bottomAppBarHeightAuto ?? false;
  }
}

class CusBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia) return child;
    return super.buildViewportChrome(context, child, axisDirection);
  }
}
