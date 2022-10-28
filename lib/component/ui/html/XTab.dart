// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:xui/component/js/color_utils.dart';

// import '../../index.dart';

// // ignore: must_be_immutable
// class XTab extends StatefulWidget {
//   List<Widget> tabs;
//   void Function(int) onTap;
//   XTab({Key? key, required this.tabs, required this.onTap}) : super(key: key);

//   @override
//   _XTabState createState() => _XTabState();
// }

// class _XTabState extends State<XTab> with SingleTickerProviderStateMixin {
//   TabController? controller;
//   @override
//   void initState() {
//     super.initState();
//     controller = new TabController(length: widget.tabs.length, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TabBar(
//       indicatorSize: TabBarIndicatorSize.label,
//       labelColor: HexToColor('#FF4300'),
//       controller: controller,
//       unselectedLabelColor: HexToColor('#3D3B48'),
//       indicatorColor: HexToColor('#FF4300'),
//       labelPadding: EdgeInsets.only(left: 0, right: 0),
//       labelStyle: font(28),
//       indicator: XUnderlineTabIndicator(
//         borderSide: BorderSide(
//           width: 8.w,
//           color: HexToColor('#FD674D'),
//         ),
//       ),
//       tabs: widget.tabs,
//       onTap: widget.onTap,
//     );
//   }
// }
