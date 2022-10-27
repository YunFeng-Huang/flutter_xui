import 'package:flutter/cupertino.dart';
import 'package:xui/compontent/ui/my_toast.dart';

import 'index.dart';

enum FormKeyEnum { name, phone, idCard, empty, password, password1 }

// ignore: camel_case_types
class CheckFormItem {
  late FormKeyEnum key;
  late String value;
  String info = '';
  bool required = false;
}

//[type]: key
//[value]: value
//[required]: 是否必填
formCheck(FormKeyEnum key, value, [required = false]) {
  bool isEmpty = value == null || value == '';
  var str;
  switch (key) {
    case FormKeyEnum.name:
      RegExp reg = new RegExp(r"[a-zA-Z0-9]+");
      if (isEmpty) {
        str = required ? '名称不能为空' : null;
      } else if (!reg.hasMatch(value)) {
        str = '名称中不能含有特殊符号';
      }
      break;
    case FormKeyEnum.password:
      RegExp reg = new RegExp(r"\d{6,16}$");
      if (isEmpty) {
        str = required ? '密码不能为空' : null;
      } else if (!reg.hasMatch(value)) {
        str = '密码需要6~16位数字组合';
      }
      break;
    case FormKeyEnum.password1:
      RegExp reg = new RegExp("^[\u4E00-\u9FA5A-Za-z0-9]{6,16}\$");
      if (isEmpty) {
        str = required ? '密码不能为空' : null;
      } else if (!reg.hasMatch(value)) {
        str = '密码需要6~16位数字和字符组合';
      }
      break;
    case FormKeyEnum.phone:
      RegExp reg = new RegExp(r'^\d{11}$');
      if (isEmpty) {
        str = required ? '手机号码不能为空' : null;
      } else if (!reg.hasMatch(value)) {
        str = '请输入11位手机号码';
      }
      break;
    case FormKeyEnum.idCard:
      RegExp reg = new RegExp(r'(^\d{18}$)|(^\d{17}(\d|X|x)$)');
      if (isEmpty) {
        str = required ? '身份证号码不能为空' : null;
      } else if (!reg.hasMatch(value)) {
        str = '身份证号码输入有错误';
      }
      break;
    case FormKeyEnum.empty:
      if (isEmpty) {
        str = required ? '参数不能为空' : null;
      }
      break;
    default:
      str = null;
  }
  return str;
}

//[type]: key
//[value]: value
//[info]: eg:联系人        则提示联系人+'err'
//[required]: 是否必填
bool formCheckToast(BuildContext context, FormKeyEnum key, value, [info = '', required = false]) {
  var v = formCheck(key, value, required);
  if (typeOf(v) == 'String') {
    showToast(context, '${isNotNull(info) && info.length > 0 ? info : v}');
    return false;
  } else {
    return true;
  }
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
// if (!checkAllForm(arr)) return ;
bool checkAllForm(BuildContext context, List<CheckFormItem> arr) {
  var a = arr.every((CheckFormItem v) {
    return formCheckToast(context, v.key, v.value, v.info, v.required);
  });
  return a;
}
