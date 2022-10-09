import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VHScrollableTablePage extends StatefulWidget {
  const VHScrollableTablePage({Key? key}) : super(key: key);

  @override
  _VHScrollableTablePageState createState() => _VHScrollableTablePageState();
}

class _VHScrollableTablePageState extends State<VHScrollableTablePage> {
  final List<String> _titleList = [
    "股票名称",
    "标题2",
    "标题3",
    "标题4",
    "标题5",
    "标题6",
    "标题7"
  ];
  double _leftWidth = 100;
  double _cellWidth = 100;
  double _cellHeight = 45;
  final ScrollController _titleController = ScrollController();
  final ScrollController _contentController = ScrollController();
  final RefreshController _controller = RefreshController();
  @override
  void initState() {
    super.initState();
    _titleController.addListener(_updateContent);
    _contentController.addListener(_updateTitle);
  }

  void _onLoading() async {
    print(123);
    await Future.delayed(Duration(seconds: 1));
    _controller.loadComplete();
    // bool more = await onLoading?.call();
    // if (more) {
    //   _controller.loadComplete();
    // } else {
    //   _controller.loadNoData();
    //   return;
    // }
    // // if failed,use loadFailed(),if no data return,use LoadNodata()
    // // items.add((items.length+1).toString());
    // if (mounted) setState(() {});
  }

  void _updateTitle() {
    if (_titleController.offset != _contentController.offset) {
      _titleController.jumpTo(_contentController.offset);
    }
  }

  void _updateContent() {
    if (_contentController.offset != _titleController.offset) {
      _contentController.jumpTo(_titleController.offset);
    }
  }

  @override
  void dispose() {
    _titleController.removeListener(_updateContent);
    _contentController.removeListener(_updateTitle);
    super.dispose();
  }

  Container _buildTitleContainer(int i) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.transparent, width: 1),
              right: BorderSide(color: Colors.transparent, width: 1))),
      alignment: Alignment.center,
      width: _cellWidth,
      height: _cellHeight,
      child: Text(
        _titleList[i],
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  _buildRightTitle() {
    List<Widget> list = [];
    for (int i = 0; i < _titleList.length; i++) {
      list.add(_buildTitleContainer(i));
    }
    return list;
  }

  _buildRightContent(int index) {
    List<Widget> list = [];
    for (int i = 0; i < _titleList.length; i++) {
      list.add(Container(
        alignment: const Alignment(0, 0),
        // decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.transparent, width: 1), right: BorderSide(color: Colors.transparent, width: 1))),
        width: _cellWidth,
        height: _cellHeight,
        child: Text(
          "行$index 列${i + 1}",
          style: TextStyle(color: Colors.black),
        ),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                // decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1), right: BorderSide(color: Colors.black, width: 1))),
                width: _leftWidth,
                height: _cellHeight,
                alignment: Alignment.center,
                child: Text('标题', style: TextStyle(color: Colors.green)),
              ),
              Expanded(
                  child: Container(
                width: _titleList.length * _cellWidth,
                child: SingleChildScrollView(
                  controller: _titleController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _buildRightTitle(),
                  ),
                ),
              ))
            ],
          ),
          Expanded(
              child: SmartRefresher(
            enablePullUp: true,
            enablePullDown: false,
            onLoading: _onLoading,
            controller: _controller,
            child: CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: _leftWidth,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      alignment: const Alignment(0, 0),
                                      // decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.transparent, width: 1), right: BorderSide(color: Colors.transparent, width: 1))),
                                      width: _cellWidth,
                                      height: _cellHeight,
                                      child: Container(
                                        child: Text('左侧$index'),
                                      ),
                                    ));
                              },
                              itemCount: 50,
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              controller: _contentController,
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: _titleList.length * _cellWidth,
                                child: ListView.builder(
                                  itemCount: 50,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        children: _buildRightContent(index),
                                      ),
                                    );
                                  },
                                ),
                                // ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
