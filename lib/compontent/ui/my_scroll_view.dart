import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xui/compontent/js/index.dart';
import 'package:xui/compontent/js/screem.dart';
import '../index.dart';
import '../js/color_utils.dart';

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
  double? appbarHeight;
  XBottomAppBarConfig? bottomAppBarConfig;
  XCustomScrollView({
    Key? key,
    this.onRefresh,
    this.appbarHeight,
    this.onLoading,
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
  }) : super(key: key) {
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
  ScrollController controller = ScrollController();
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
  bool noData = false;
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (!isNotNull(appbar?.customAppBar))
      controller.addListener(() {
        setState(() {
          opacity = controller.offset >= appbarHeight
              ? 1.00
              : controller.offset / appbarHeight;
        });
      });
    _timer = Timer(Duration(milliseconds: 5000), () {
      noData = true;
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
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
    controller.animateTo(
      position,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void toBottom() {
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(status);
    return Scaffold(
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
              Column(
                children: [
                  Expanded(
                    child: SmartRefresher(
                      // ignore: unnecessary_null_comparison
                      enablePullDown: onRefresh != null,
                      // ignore: unnecessary_null_comparison
                      enablePullUp: onLoading != null,
                      header: headerLoading,
                      footer: XSmartRefresherCustomFooter(),
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
                  if (bottomAppBar != null) SizedBox(height: 88.w)
                ],
              ),
              if (!isNotNull(appbar?.customAppBar) && isNotNull(appbar))
                XAppBarWidget(
                  context,
                  title: appbar?.title,
                  appbarHeight: appbarHeight,
                  color: Colors.white.withOpacity(1 - opacity),
                ).background(
                  colorA: Colors.white.withOpacity(opacity),
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
              if (bottomAppBar != null)
                Positioned(
                  child: _footerBottom(),
                  bottom: 0,
                  left: 0,
                  right: 0,
                ),
            ],
          ),
          bottom: true,
        ));
  }
}

// ignore: non_constant_identifier_names
XBottomAppBarWrap({child, color, height, boxShadow, heightAuto}) {
  return Container(
    height: heightAuto ? null : height,
    decoration: BoxDecoration(
      color: color ?? Colors.white,
      boxShadow: boxShadow ??
          [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05), //底色,阴影颜色
              blurRadius: 1, // 阴影模糊层度
              spreadRadius: 1, //阴影模糊大小
            )
          ],
    ),
    child: child,
  );
}

XSmartRefresherCustomFooter() {
  TextStyle _style = font(28, color: '#9EA6AE');
  return CustomFooter(
    builder: (BuildContext context, LoadStatus? mode) {
      Widget body;

      if (mode == LoadStatus.idle) {
        body = Text(
          "上拉加载",
          style: _style,
        );
      } else if (mode == LoadStatus.loading) {
        body = CupertinoActivityIndicator();
      } else if (mode == LoadStatus.failed) {
        body = Text(
          "加载失败！点击重试！",
          style: _style,
        );
      } else if (mode == LoadStatus.canLoading) {
        body = Text(
          "松手,加载更多",
          style: _style,
        );
      } else {
        body = Text(
          "没有更多了",
          style: _style,
        );
      }
      return Container(
        height: 55.0,
        child: Center(child: body),
      );
    },
  );
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

// ignore: non_constant_identifier_names
Widget XAppBarWidget(
  context, {
  String? title,
  double? appbarHeight,
  // TextStyle? textStyle,
  Color? backgroundColor,
  double? fontSize,
  Color? color,
  List<Widget>? actions,
}) {
  double height = appbarHeight ?? 88.w;
  return Container(
    padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
    color: backgroundColor ?? Colors.transparent,
    height: height + ScreenUtil().statusBarHeight,
    child: Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
          child: BackButton(
            color: color ?? HexToColor('#010101'),
          )
              // Icon(
              //   Icons.chevron_left,
              //   color: color ?? HexToColor('#010101'),
              // )
              .background(width: height, height: height),
        ).centerLeft.margin(left: 24.w),
        Text(
          title ?? '',
          style: TextStyle(
            fontSize: fontSize ?? 32.w,
            color: color ?? HexToColor('#010101'),
            fontWeight: FontWeight.bold,
          ),
          // font(32, color: color ?? '#010101', bold: true),
        ).center,
        if (isNotNull(actions?.length))
          Row(
            children: List.generate(
              actions!.length,
              (index) => Container(
                child: actions[index],
                width: height,
              ),
            ),
          )
              .background(width: height * actions.length)
              .centerRight
              .margin(right: 24.w),
      ],
    ),
  );
}

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  double offset = 0.00;
  double height = 120.w;
  double get opacity {
    var diff = offset / height;
    if (diff > 0) {
      return diff > 1 ? 1 : diff;
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime newTime = DateTime.now();
    return CustomHeader(
        builder: (BuildContext context, RefreshStatus? mode) {
          String text = '';
          switch (mode) {
            case RefreshStatus.refreshing:
              text = "更新中";
              break;
            case RefreshStatus.completed:
              text = "更新成功";
              break;
            case RefreshStatus.failed:
              text = "更新失败";
              break;
            default:
              text =
                  '释放刷新 最后更新 ${newTime.hour}:${newTime.minute > 9 ? newTime.minute : ('0${newTime.minute}')}:${newTime.second}';
              break;
          }
          return Opacity(
            opacity: opacity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                XImage(
                  image: globalConfig.defaultImg,
                  width: 28.w,
                  height: 22.w,
                )
                    .center
                    .padding(top: 4.w)
                    .background(
                      border: 2.w,
                      borderColor: HexToColor('#FF4300'),
                      radius: 100.w,
                      width: 44.w,
                      height: 44.w,
                    )
                    .margin(vertical: 15.w),
                Text(text, style: font(24, color: '#9EA6AE')),
              ],
            ).center,
          );
        },
        onOffsetChange: (double value) {
          setState(() {
            offset = value;
          });
        },
        height: height);
  }
}

class XSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  const XSliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(shrinkOffset);
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(XSliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
