import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xui/component/ui/index.dart';

import 'local_storage.dart';

class XUtil {
  /// 函数节流
  ///
  /// [func]: 要执行的方法
  static Map enableMap = HashMap();

  /// 函数防抖
  ///
  /// [func]: 要执行的方法
  /// [delay]: 要迟延的时长
// static Timer? timer;
  static debounce(
    Function func, [
    Duration delay = const Duration(milliseconds: 500),
  ]) {
    String key = func.toString() + '_debounce';
    if (!enableMap.containsKey(key)) {
      enableMap.addAll({key: null as Timer});
    }

    if (enableMap[key]?.isActive ?? false) {
      enableMap[key]?.cancel();
    }
    enableMap[key] = Timer(delay, () {
      func.call();
    });
  }

  static throttle(
    Function func, [
    Duration delay = const Duration(milliseconds: 2000),
  ]) {
    String key = func.toString() + '_throttle';
    if (enableMap.containsKey(key)) {
      return;
    } else {
      enableMap.addAll({key: true});
      func.call();
      Timer(delay, () {
        enableMap.remove(key);
      });
    }
  }

  static String typeOf(element) {
    return element.runtimeType.toString();
  }

  static bool isJson(source) {
    var isJson = false;
    try {
      jsonDecode(source);
      // JSON.stringify(JSON.parse(res.data),null,2);
      isJson = true;
    } catch (e) {}
    return isJson;
  }

  static formatNum(double num, int postion) {
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) <
        postion) {
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
  static List splitList(xList, [chunk = 2]) {
    var list = [];
    var len = xList.length;
    for (var i = 0; i < len; i += chunk as int) {
      var maxValue = (i + chunk) > len ? len : (i + chunk);
      list.add(xList.sublist(i, maxValue));
    }
    return list;
  }

  static intParse(params) {
    if (typeOf(params) != 'int' && params != null) {
      return int.parse(params);
    } else {
      return params;
    }
  }

// 1.00 => 1
  static toInt(value) {
    if (typeOf(value) == 'double') {
      return value == value.toInt() ? value.toInt() : value;
    } else {
      return value;
    }
  }

  static filterKey(params, key) {
    return params.containsKey(key) ? params[key] : null;
  }

  static recursive(data, keys) {
    if (data == null) return;
    keys.forEach((e) {
      data = data[e];
    });
    return data;
  }

//[time]: 结束时间
//[callback]: 回调
// GlobalConfig.TimerCancel = null; 销毁
  static countdown(time, callback) {
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

  static filterList(data, key) {
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

  static Future<ui.Image> loadImage(String url) async {
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

  static double getY(BuildContext buildContext) {
    final RenderBox box = buildContext.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    return offset.dy;
  }

  static flutterPop() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }

  static deepClone(obj) {
    dynamic newObj = obj is Map ? {} : [];
    if (obj is Map) {
      obj.forEach((key, value) {
        if (obj[key] is Map || obj[key] is List) {
          newObj[key] = deepClone(value);
        } else {
          newObj[key] = value;
        }
      });
    } else {
      for (int i = 0; i < obj.length; i++) {
        if (obj[i] is Map || obj[i] is List) {
          newObj.add(deepClone(obj[i]));
        } else {
          newObj.add(obj[i]);
        }
      }
    }
    return newObj;
  }
}

isNotNull(v) {
  return v != null;
}
