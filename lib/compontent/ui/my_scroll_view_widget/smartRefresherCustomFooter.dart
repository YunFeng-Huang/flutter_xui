import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xui/compontent/index.dart';

class XSmartRefresherCustomFooter extends StatelessWidget {
  final String? page;
  XSmartRefresherCustomFooter({Key? key, this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _style = font(28, color: '#9EA6AE');
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        double height = 76 / 2;
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
          height: height,
          child: Center(child: body),
        );
      },
    );
  }
}
