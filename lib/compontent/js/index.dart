import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xui/compontent/ui/index.dart';

import 'local_storage.dart';

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

// ignore: unused_element
String? _key = '';
throttle2(
  Function func, [
  String? key,
]) {
  if (_key != key) {
    func.call();
    _key = key;
  }
}

//[cookieName]: 'cookieName'
//[api]: 接口地址
//[params]: 参数
//[callback]: 要执行的方法
//[type]: 0 等待cookie和api 都请求结束  1 谁快用谁
Future staticStorage({cookieName, api, params, callback, type = 0}) async {
  var data;
  var paramsToJson;
  var date = DateTime.now();
  _post() async {
    data = await api(Map<String, dynamic>.from(params));
    if (data != null) {
      if (type == 0 || (type == 1 && paramsToJson == null)) {
        paramsToJson = callback.call(data);
        Sesstion().setStorage(cookieName, data);
        return paramsToJson;
      }
    }
  }

  _getCookie() async {
    data = await Sesstion().getStorage(cookieName);
    if (data != null && paramsToJson == null)
      paramsToJson = callback.call(data);
    return paramsToJson;
  }

  _getCookie();
  await _post();
  return paramsToJson;
}

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

    print(num.toStringAsFixed(postion)
        .substring(0, num.toString().lastIndexOf(".") + postion + 1)
        .toString());
  } else {
    print(num.toString()
        .substring(0, num.toString().lastIndexOf(".") + postion + 1)
        .toString());
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
  return params != null && params != '';
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
    GlobalConfig.timerCancel =
        Timer.periodic(const Duration(seconds: 1), (timer) {
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

Iterable mapData(List list) {
  return list.asMap().entries;
}

filterList(data, key) {
  // List data=[{'name':'1','id':1},{'name':'1','id':1},{'name':'2','id':2},{'name':'2','id':2}];
  var _a = new Set(); //将_a带上去重属性
  List _h = [];
  for (int i = 0; i < data.length; i++) {
    _a.add(data[i][key]); //_a会自动将重复的去掉  _a=[1,2]
  }
  List _b = _a.toList();
  for (int j = 0; j < _a.length; j++) {
    for (int i = 0; i < data.length; i++) {
      if (_b[j] == data[i][key]) {
        _h.add(data[i]);
        break;
      }
    }
  }
  return _h;
}

Future<ui.Image> loadImage(String url) async {
  Completer<ui.Image> completer = Completer<ui.Image>();
  ImageStreamListener? listener;
  ImageStream stream =
      CachedNetworkImageProvider(url).resolve(ImageConfiguration.empty);
  listener = ImageStreamListener((ImageInfo frame, bool sync) {
    final ui.Image image = frame.image;
    completer.complete(image);
    if (listener != null) {
      stream.removeListener(listener);
    }
  });
  stream.addListener(listener);
  return completer.future;
}

double getY(BuildContext buildContext) {
  final RenderBox box = buildContext.findRenderObject() as RenderBox;
  final offset = box.localToGlobal(Offset.zero);
  return offset.dy;
}
