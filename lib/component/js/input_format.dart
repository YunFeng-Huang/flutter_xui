import 'package:flutter/services.dart';

//  举例：1234.56

// CustomFilteringTextInputFormatter.numberFormatter(
// maxIntegerCount:4, // 对应整数位个数1234
// maxDecimalCount:2,  // 对应小数位个数56, 如果想输入纯数字，则此值设置成0
// zeroStartLTOne: fale, //如果需要输入0.05或者0这样的，则应该设置成true,默认是只能输入大于1的值
// )
// 如果设置了maxDecimalCount的值不等于0，比如设置成2，那么输入“1234.”这样的类型也会判定为合法值，此时需要代码自己处理成功标准的“1234.00”
// ————————————————

class CustomFilteringTextInputFormatter {
  /// 禁止首位空格
  static final TextInputFormatter noLeadingWhitespace =
      _NoLeadingWhitespaceInputFormatter();

  /// 金额输入限制
  static TextInputFormatter numberFormatter(
      {int maxIntegerCount = 8,
      int maxDecimalCount = 2,
      bool zeroStartLTOne = false}) {
    return _CustomNumFormatter(
        maxIntegerCount: maxIntegerCount,
        maxDecimalCount: maxDecimalCount,
        zeroStartLTOne: zeroStartLTOne);
  }

  /// 禁止空格
  static final TextInputFormatter denySpace =
      FilteringTextInputFormatter.deny(RegExp(r'\s'));

  /// 禁止中文
  static final TextInputFormatter denyChineseCharacter =
      FilteringTextInputFormatter.deny(RegExp(r'[\u4e00-\u9fa5]'));

  /// 禁止表情
  static final TextInputFormatter denyEmoji = FilteringTextInputFormatter.deny(
      RegExp(
          '[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]'));

  /// 禁止表情符号和中文
  static final TextInputFormatter denyChineseAndEmoji =
      FilteringTextInputFormatter.deny(RegExp(r'[\u0080-\uFFFF]'));



}

class _CustomNumFormatter extends TextInputFormatter {
  /// 整数的个数
  final int maxIntegerCount;

  /// 保留的小数个数
  final int maxDecimalCount;

  /// 是否可以输入>=0<1的值
  final bool zeroStartLTOne;
  _CustomNumFormatter(
      {this.maxIntegerCount = 8,
      this.maxDecimalCount = 2,
      this.zeroStartLTOne = false})
      : assert(maxIntegerCount >= 1 && maxDecimalCount >= 0);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (_isValidInput(newValue.text)) {
      return newValue;
    } else {
      if (newValue.text == '') {
        return TextEditingValue(
            text: '', selection: TextSelection.collapsed(offset: 0));
      } else {
        return oldValue;
      }
    }
  }

  bool _isValidInput(String input) {
    String pattern = '';
    if (maxDecimalCount == 0) {
      if (input.startsWith('0') && zeroStartLTOne) {
        pattern = '^0\$';
      } else {
        pattern = '^[1-9]\\d{0,${maxIntegerCount - 1}}\$';
      }
    } else {
      if (input.startsWith('0') && zeroStartLTOne) {
        pattern = '^0(?:\\.\\d{0,$maxDecimalCount})?\$';
      } else {
        pattern =
            '^[1-9]\\d{0,${maxIntegerCount - 1}}(?:\\.\\d{0,$maxDecimalCount})?\$';
      }
    }
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(input);
  }
}

class _NoLeadingWhitespaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.startsWith(' ')) {
      final txt = newValue.text.trimLeft();
      return newValue.copyWith(
          text: txt, selection: TextSelection.collapsed(offset: txt.length));
    }
    return newValue;
  }
}
