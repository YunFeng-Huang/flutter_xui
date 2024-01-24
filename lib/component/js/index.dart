import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xui/component/js/print_log.dart';
import 'package:xui/component/ui/index.dart';

class XUtil {
  /// 函数节流
  ///
  /// [func]: 要执行的方法
  static Map enableMap = HashMap();

  /// 函数防抖
  ///
  /// [func]: 要执行的方法
  /// [duration]: 要迟延的时长

  // StackTrace.current
  static debounce(
      Function func,
      StackTrace key, {
        Duration duration = const Duration(milliseconds: 500),
      }) {
    MYCustomTrace programInfo = MYCustomTrace(key);
    String _key = '${programInfo.fileName}_${programInfo.lineNumber}_debounce';
    if (!XUtil.enableMap.containsKey(_key)) {
      XUtil.enableMap.addAll({_key: null});
    }
    if (XUtil.enableMap[_key]?.isActive ?? false) {
      XUtil.enableMap[_key]?.cancel();
    }
    XUtil.enableMap[_key] = Timer(duration, () {
      func.call();
      XUtil.enableMap[_key]?.cancel();
    });
  }

  static throttle(
      Function func,
      StackTrace key, {
        Duration duration = const Duration(milliseconds: 2000),
      }) {
    MYCustomTrace programInfo = MYCustomTrace(key);
    String _key = '${programInfo.fileName}_${programInfo.lineNumber}_throttle';
    print(_key);
    if (XUtil.enableMap.containsKey(_key)) {
      return;
    } else {
      XUtil.enableMap.addAll({_key: true});
      func.call();
      Timer(duration, () {
        XUtil.enableMap.remove(_key);
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
        }
      });
    }
  }

  static filterList(data) {
    // List data=[{'name':'1','id':1},{'name':'1','id':1},{'name':'2','id':2},{'name':'2','id':2}];
    var _a = new Set(); //将_a带上去重属性
    List _h = [];
    for (int i = 0; i < data.length; i++) {
      _a.add(data[i].id); //_a会自动将重复的去掉  _a=[1,2]
    }
    List _b = _a.toList();
    for (int j = 0; j < _a.length; j++) {
      for (int i = 0; i < data.length; i++) {
        if (_b[j] == data[i].id) {
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

  static String formatName(String text, {type = "text"}) {
    if (text == "" || text == null) return "";
    if (type == 'phone') {
      return text.replaceFirst(new RegExp(r'\d{4}'), '****', 3);
    } else {
      if (text.length > 2) {
        return text.replaceFirst(new RegExp('.'), '*', 1);
      }
      return text.substring(0, 1) + '*';
    }
  }

  static String renderSize(double value, [fix = 2]) {
    // ignore: unnecessary_null_comparison
    if (value == null) {
      return '0.0';
    }
    List<String> unitArr = []
      ..add('B')
      ..add('K')
      ..add('M')
      ..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(fix);
    return size + unitArr[index];
  }

  //循环获取缓存大小
  static Future getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    //  File

    if (file is File && file.existsSync()) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory && file.existsSync()) {
      List children = file.listSync();
      double total = 0.0;
      if (children.isNotEmpty) {
        for (final FileSystemEntity child in children) {
          total += await getTotalSizeOfFilesInDir(child);
        }
      }

      return total;
    }
    return 0.0;
  }

  static getVersion(version){
    RegExp regExp = RegExp(r'v\d+\.\d+\.\d+');
    Iterable<Match> matches = regExp.allMatches(version ?? '');
    if (matches.isNotEmpty) {
    Match match = matches.first;
    print(match);
    version = match.group(0);
    }
    return version;
  }
  ///版本比较
  static bool versionDiff(String version, String version1) {
    String _v = getVersion(version).replaceAll('v', '').replaceAll('V', '');
    print(_v);
    List list1 = _v.split('.');
    int version_1 = XUtil.intParse(list1[0]);
    int version_2 = XUtil.intParse(list1[1]);
    int version_3 = XUtil.intParse(list1[2]);
    String _v1 = getVersion(version1).replaceAll('v', '').replaceAll('V', '');
    print(_v1);
    List list2 = _v1.split('.');
    int version1_1 = XUtil.intParse(list2[0]);
    int version1_2 = XUtil.intParse(list2[1]);
    int version1_3 = XUtil.intParse(list2[2]);

    if (version_1 > version1_1) {
      return true;
    }
    if (version_1 == version1_1) {
      if (version_2 > version1_2) {
        return true;
      }
      if (version_2 == version1_2) {
        if (version_3 >= version1_3) {
          return true;
        }
      }
    }
    return false;
  }

  static moreData(List? res, [int page = 20]) {
    return (res?.length ?? 0) % page == 0 && res?.length != 0;
  }

  static mapIcons(url) {
    if (Platform.isAndroid) {
      url += '@2x';
    }
    url += '.png';
    return url;
  }
}

isNotNull(v) {
  return v != null;
}

