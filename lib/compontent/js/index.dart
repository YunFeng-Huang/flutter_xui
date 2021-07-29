import 'dart:async';
import 'dart:convert';

import '/compontent/ui/my_toast.dart';

/// 函数防抖
///
/// [func]: 要执行的方法
/// [delay]: 要迟延的时长
Timer? timer;
debounce(
  Function func, [
  Duration delay = const Duration(milliseconds: 500),
]) {
  if (timer?.isActive ?? false) {
    timer?.cancel();
  }
  timer = Timer(delay, () {
    func.call();
  });
}

/// 函数节流
///
/// [func]: 要执行的方法
bool enable = true;
throttle(
  Function func, [
  Duration delay = const Duration(milliseconds: 2000),
]) {
  if (enable == true) {
    enable = false;
    func.call();
    Timer(delay, () {
      enable = true;
    });
  }
}

//[cookieName]: 'cookieName'
//[api]: 接口地址
//[params]: 参数
//[callback]: 要执行的方法
//[type]: 0 等待cookie和api 都请求结束  1 谁快用谁
// Future staticStorage({cookieName, api, params, callback, type = 0}) async {
//   var data;
//   var paramsToJson;
//   var date = DateTime.now();
//   _post() async {
//     data = await api(Map<String, dynamic>.from(params));
//     if (data != null) {
//       if (type == 0 || (type == 1 && paramsToJson == null)) {
//         paramsToJson = callback.call(data);
//         PersistentStorage().setStorage(cookieName, data);
//         return paramsToJson;
//       }
//     }
//   }
//
//   _getCookie() async {
//     data = await PersistentStorage().getStorage(cookieName);
//     if (data != null && paramsToJson == null) paramsToJson = callback.call(data);
//     return paramsToJson;
//   }
//
//   _getCookie();
//   await _post();
//   return paramsToJson;
// }

String typeOf(element) {
  return element.runtimeType.toString();
}

bool isJson(source) {
  var isJson = false;
  try {
    jsonDecode(source);
    // JSON.stringify(JSON.parse(res.data),null,2);
    isJson = true;
  } catch (e) {}
  return isJson;
}

formatNum(double num, int postion) {
  if ((num.toString().length - num.toString().lastIndexOf(".") - 1) < postion) {
    //小数点后有几位小数

    print(num.toStringAsFixed(postion).substring(0, num.toString().lastIndexOf(".") + postion + 1).toString());
  } else {
    print(num.toString().substring(0, num.toString().lastIndexOf(".") + postion + 1).toString());
  }
}

//[type]: key
//[value]: value
//[required]: 是否必填
formCheck(key, value, [required = false]) {
  bool isEmpty = value == null || value == '';
  var str;
  switch (key) {
    case 'name':
      RegExp reg = new RegExp("^[\u4E00-\u9FA5A-Za-z0-9]+\$");
      if (isEmpty) {
        str = required ? '参数不能为空' : null;
      } else if (!reg.hasMatch(value)) {
        str = '名称中不能含有特殊符号';
      }
      break;
    case 'phone':
      RegExp reg = new RegExp(r'^\d{11}$');
      if (isEmpty) {
        str = required ? '参数不能为空' : null;
      } else if (!reg.hasMatch(value)) {
        str = '请输入11位手机号码';
      }
      break;
    case 'idCard':
      RegExp reg = new RegExp(r'(^\d{18}$)|(^\d{17}(\d|X|x)$)');
      if (isEmpty) {
        str = required ? '参数不能为空' : null;
      } else if (!reg.hasMatch(value)) {
        str = '身份证号码输入有错误';
      }
      break;
    case 'empty':
      if (isEmpty) {
        str = required ? '参数不能为空' : null;
      }
      break;
// default:
//   str = null;
  }
  return str;
}

//[type]: key
//[value]: value
//[info]: eg:联系人        则提示联系人+'err'
//[required]: 是否必填
bool formCheckToast(key, value, [info = '', required = false]) {
  var v = formCheck(key, value, required);
  print(v);
  print(typeOf(v));
  if (typeOf(v) == 'String') {
    showToast('$info$v');
    return false;
  } else {
    return true;
  }
}

//数组分组
List splitList(xList, [chunk = 2]) {
  var list = [];
  var len = xList.length;
  for (var i = 0; i < len; i += chunk as int) {
    var maxValue = (i + chunk) > len ? len : (i + chunk);
    list.add(xList.sublist(i, maxValue));
  }
  return list;
}

bool isNotNull(params) {
  return params != null;
}

intParse(params) {
  if (typeOf(params) != 'int' && params != null) {
    return int.parse(params);
  } else {
    return params;
  }
}

// 1.00 => 1
toInt(value) {
  if (typeOf(value) == 'double') {
    return value == value.toInt() ? value.toInt() : value;
  } else {
    return value;
  }
}

filterKey(params, key) {
  return params.containsKey(key) ? params[key] : null;
}

recursive(data, keys) {
  if (data == null) return;
  keys.forEach((e) {
    data = data[e];
  });
  return data;
}

//[time]: 结束时间
//[callback]: 回调
// GlobalConfig.TimerCancel = null; 销毁
countdown(time, callback) {
  if (time.isAfter(DateTime.now())) {
    GlobalConfig.TimerCancel = Timer.periodic(const Duration(seconds: 1), (timer) {
      var difference = time.difference(DateTime.now());
      print('difference: $difference');
      if (time.isBefore(DateTime.now())) {
        callback?.call();
        print('取消定时器');
        //取消定时器，避免无限回调
        timer.cancel();
        timer = null as Timer;
      }
    });
  }
}

class GlobalConfig {
  // ignore: non_constant_identifier_names
  static var TimerCancel;
}
