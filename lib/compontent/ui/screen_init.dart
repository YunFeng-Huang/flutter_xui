// import 'package:flutter/material.dart';
// import 'package:xui/compontent/js/screem.dart';

// class ScreenInit extends StatelessWidget {
//   ScreenInit({
//     required this.builder,
//     this.designSize = ScreenUtil.defaultSize,
//     Key? key,
//   }) : super(key: key);

//   final Widget Function() builder;
//   final Size designSize;

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (_, BoxConstraints constraints) {
//       return OrientationBuilder(
//         builder: (_, Orientation orientation) {
//           if (constraints.maxWidth != 0) {
//             ScreenUtil.init(context, designSize: designSize);
//             return builder();
//           }
//           return Container();
//         },
//       );
//     });
//   }
// }
