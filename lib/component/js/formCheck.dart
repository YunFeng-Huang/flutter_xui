import 'package:flutter/cupertino.dart';
import 'package:xui/component/ui/my_toast.dart';

import 'index.dart';

enum FormKeyEnum { name, phone, idCard, code, empty, password, password1 }

// ignore: camel_case_types
class CheckFormItem {
  late FormKeyEnum key;
  dynamic value;
  String info = '';
  bool required = false;
  int? num;
}

//[type]: key
//[value]: value
//[required]: 是否必填
formCheck(CheckFormItem item) {
  bool isEmpty = item.value == null || item.value == '';
  var str;
  switch (item.key) {
    case FormKeyEnum.name:
      RegExp reg = new RegExp(r"[a-zA-Z0-9]+");
      if (isEmpty) {
        str = item.required ? '名称不能为空' : null;
      } else if (!reg.hasMatch(item.value)) {
        str = '名称中不能含有特殊符号';
      }
      break;
    case FormKeyEnum.code:
      if (isEmpty) {
        str = item.required ? '验证码不能为空' : null;
      } else if (item.value.length != item.num) {
        str = '请输入${item.num}位有效验证码';
      }
      break;
    case FormKeyEnum.password:
      RegExp reg = new RegExp(r"\d{6,16}$");
      if (isEmpty) {
        str = item.required ? '密码不能为空' : null;
      } else if (!reg.hasMatch(item.value)) {
        str = '密码需要6~16位纯数字组合';
      }
      break;
    case FormKeyEnum.password1:
      RegExp reg = new RegExp("^[\u4E00-\u9FA5A-Za-z0-9]{6,16}\$");
      if (isEmpty) {
        str = item.required ? '密码不能为空' : null;
      } else if (!reg.hasMatch(item.value)) {
        str = '密码需要6~16位数字和字符组合';
      }
      break;
    case FormKeyEnum.phone:
      RegExp reg = new RegExp(
          r'^1(3\d|4[5-9]|5[0-35-9]|6[567]|7[0-8]|8\d|9[0-35-9])\d{8}$');
      if (isEmpty) {
        str = item.required ? '手机号码不能为空' : null;
      } else if (!reg.hasMatch(item.value)) {
        str = '请输入正确手机号码';
      }
      break;
    case FormKeyEnum.idCard:
      RegExp reg = new RegExp(r'(^\d{18}$)|(^\d{17}(\d|X|x)$)');
      if (isEmpty) {
        str = item.required ? '身份证号码不能为空' : null;
      } else if (!reg.hasMatch(item.value)) {
        str = '身份证号码输入有错误';
      }
      break;
    case FormKeyEnum.empty:
      if (isEmpty) {
        str = item.required ? item.info : null;
      }
      break;
    default:
      str = null;
  }
  return str;
}

//eg:
//  List<CheckFormItem> arr = [
//   CheckFormItem()
//     ..required = true
//     ..key = FormKeyEnum.name
//     ..value = params.loginName,
//   CheckFormItem()
//     ..required = true
//     ..key = FormKeyEnum.name
//     ..value = params.password,
// ];
// if (!checkAllForm(context,arr)) return ;
bool checkAllForm(BuildContext context, List<CheckFormItem> arr) {
  return arr.every((CheckFormItem item) {
    var v = formCheck(item);
    if (XUtil.typeOf(v) == 'String') {
      showToast(context, v);
      return false;
    } else {
      return true;
    }
  });
}
