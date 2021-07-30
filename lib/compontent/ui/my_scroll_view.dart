import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huanhu/compontent/js/index.dart';
import 'package:flutter_huanhu/compontent/ui/my_loading.dart';
import 'package:flutter_huanhu/routes_config.dart';
import 'package:flutter_huanhu/compontent/js/screem.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import './index.dart';
import 'color_utils.dart';

// ignore: must_be_immutable
class XCustomScrollView extends StatefulWidget {
  XCustomScrollViewAppbar? appbar;
  Color backgroundColor;
  dynamic loading;
  List<Widget> slivers;
  Widget? bottomAppBar;
  Function? onRefresh;
  Function? onLoading;
  double? appbarHeight;
  XCustomScrollView({Key? key, this.onRefresh, this.appbarHeight, this.onLoading, required this.loading, required this.slivers, this.appbar, this.backgroundColor = Colors.transparent, this.bottomAppBar}) {
    if (bottomAppBar != null) {
      slivers.add(
        SliverToBoxAdapter(
          child: SizedBox(
            height: 110.w,
          ),
        ),
      );
    }
  }

  @override
  _XCustomScrollViewState createState() => _XCustomScrollViewState();
}

class _XCustomScrollViewState extends State<XCustomScrollView> {
  dynamic get data => widget.loading;
  XCustomScrollViewAppbar? get appbar => widget.appbar;
  Color get backgroundColor => widget.backgroundColor;
  List<Widget> get slivers => widget.slivers;
  Widget? get bottomAppBar => widget.bottomAppBar;
  ScrollController controller = ScrollController();
  double opacity = 0.0;
  double get appbarHeight => widget.appbarHeight ?? 100.w;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  Function? get onRefresh => widget.onRefresh;
  Function? get onLoading => widget.onLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (!isNotNull(appbar?.customAppBar))
      controller.addListener(() {
        setState(() {
          opacity = controller.offset >= appbarHeight ? 1.00 : controller.offset / appbarHeight;
        });
      });
  }

  void _onRefresh() async {
    await onRefresh?.call();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await onRefresh?.call();
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: MaterialClassicHeader(color: Colors.blue),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("上拉加载");
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("加载失败！点击重试！");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("松手,加载更多!");
              } else {
                body = Text("没有更多数据了!");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: data == null
              ? Center(
                  child: Loading(),
                )
              : Stack(
                  children: [
                    CustomScrollView(
                      physics: ClampingScrollPhysics(),
                      controller: controller,
                      slivers: slivers,
                    ),
                    if (!isNotNull(appbar?.customAppBar))
                      XAppBarWidget(
                        context,
                        title: appbar?.title,
                        appbarHeight: appbarHeight,
                        color: Colors.white.withOpacity(1 - opacity),
                      ).background(
                        color: Colors.white.withOpacity(opacity),
                      ),
                    if (!isNotNull(appbar?.customAppBar))
                      XAppBarWidget(
                        context,
                        title: appbar?.title,
                        appbarHeight: appbarHeight,
                        color: Colors.black.withOpacity(opacity),
                      ),
                    if (isNotNull(appbar?.customAppBar)) appbar!.customAppBar!,
                    if (bottomAppBar != null)
                      Container(
                        height: 98.w,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.05), //底色,阴影颜色
                              blurRadius: 1, // 阴影模糊层度
                              spreadRadius: 1, //阴影模糊大小
                            )
                          ],
                        ),
                        child: bottomAppBar,
                      ).bottomCenter
                  ],
                ),
        ));
  }
}

class XCustomScrollViewAppbar {
  String? title;
  Widget? customAppBar;
  XCustomScrollViewAppbar({this.title, this.customAppBar});
}

// ignore: non_constant_identifier_names
Widget XAppBarWidget(
  context, {
  String? title,
  double? appbarHeight,
  TextStyle? textStyle,
  Color? backgroundColor,
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
            Routers.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
            color: color ?? HexToColor('#010101'),
          ).background(width: height, height: height),
        ).centerLeft.margin(left: 24.w),
        Text(
          title ?? '',
          style: TextStyle(
            fontSize: 32.w,
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
          ).background(width: height * actions.length).centerRight.margin(right: 24.w),
      ],
    ),
  );
}
