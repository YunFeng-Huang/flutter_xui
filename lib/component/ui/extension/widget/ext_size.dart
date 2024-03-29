// ignore: import_of_legacy_library_into_null_safe


import '../../../index.dart';

extension SizeExtension on num {
  double get w => this / 2;
  double get h => this / 2;
  // ///[ScreenUtil.setWidth]
  double get px => ScreenUtil().setWidth(this);

  // ///[ScreenUtil.setHeight]
  // double get h => ScreenUtil().setHeight(this);

  // ///[ScreenUtil.setSp]
  // double get sp => ScreenUtil().setSp(this);

  // ///[ScreenUtil.setSp]
  // double get ssp => ScreenUtil().setSp(this, allowFontScalingSelf: true);

  // ///[ScreenUtil.setSp]
  // double get nsp => ScreenUtil().setSp(this, allowFontScalingSelf: false);

  // ///屏幕宽度的倍数
  // ///Multiple of screen width
  double get sw => ScreenUtil().screenWidth * this;

  // ///屏幕高度的倍数
  // ///Multiple of screen height
  double get sh => ScreenUtil().screenHeight * this;
}
