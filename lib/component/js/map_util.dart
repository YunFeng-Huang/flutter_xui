import 'dart:io';

import 'package:url_launcher/url_launcher.dart';
import 'package:xui/component/index.dart';

import 'gps_util.dart';


enum MapUtilEnum { apple, amap, baidu, tencent, google }

class MapUtil {
  static Future<List> allMap() async {
    List list = [];

    try {
      if (await canLaunchUrl(Uri.parse(Platform.isAndroid ? 'androidamap://keywordNavi?sourceApplication=softname&keyword=&style=2' : 'iosamap://path?sourceApplication=applicationName&dname=&dev=0&t=0'))) {
        list.add({'type': MapUtilEnum.amap, 'name': '高德地图'});
      }
      if (await canLaunchUrl(Uri.parse('qqmap://map/routeplan?type=drive&fromcoord=CurrentLocation&tocoord=&referer=IXHBZ-QIZE4-ZQ6UP-DJYEO-HC2K2-EZBXJ'))) {
        list.add({'type': MapUtilEnum.tencent, 'name': '腾讯地图'});
      }
      if (await canLaunchUrl(Uri.parse('baidumap://map/direction?destination=&coord_type=bd09ll&mode=driving'))) {
        list.add({'type': MapUtilEnum.baidu, 'name': '百度地图'});
      }
      if (await canLaunchUrl(Uri.parse('comgooglemaps://?saddr=&daddr=&directionsmode=driving'))) {
        list.add({'type': MapUtilEnum.google, 'name': '谷歌地图'});
      }
      if (Platform.isIOS) {
        list.add({'type': MapUtilEnum.apple, 'name': '苹果地图'});
      }
    } catch (e) {
      print(e);
    }
    return list;
  }

  static Future gotoMap(MapUtilEnum type, longitude, latitude, [formGaode = false]) async {
    if (type == MapUtilEnum.tencent) {
      await gotoTencentMap(longitude, latitude);
    }
    if (type == MapUtilEnum.apple) {
      var url = 'http://maps.apple.com/?&daddr=$latitude,$longitude';
      await launchUrl(Uri.parse(url));
    }
    if (type == MapUtilEnum.amap) {
      await gotoAMap(longitude, latitude);
    }
    if (type == MapUtilEnum.baidu) {
      await gotoBaiduMap(longitude, latitude, formGaode);
    }
    if (type == MapUtilEnum.google) {
      await launchUrl(Uri.parse("comgooglemaps://?saddr=&daddr=$latitude,$longitude&directionsmode=driving"));
    }
  }





  /// 高德地图
  static Future<bool> gotoAMap(longitude, latitude) async {
    var url = '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=$latitude&lon=$longitude&dev=0&style=2';

    bool canLaunch = await canLaunchUrl(Uri.parse(url));

    if (!canLaunch) {
      return false;
    }

    await launchUrl(Uri.parse(url));

    return canLaunch;
  }

  /// 腾讯地图
  static Future<bool> gotoTencentMap(longitude, latitude) async {
    var url = 'qqmap://map/routeplan?type=drive&fromcoord=CurrentLocation&tocoord=$latitude,$longitude&referer=IXHBZ-QIZE4-ZQ6UP-DJYEO-HC2K2-EZBXJ';
    bool canLaunch = await canLaunchUrl(Uri.parse(url));

    await launchUrl(Uri.parse(url));

    return canLaunch;
  }

  /// 百度地图
  static Future<bool> gotoBaiduMap(longitude, latitude, [formGaode = false]) async {
    if (formGaode) {
      print("latitude, longitude====start=====>${latitude}==$longitude");
      List list = GpsUtil.gcj02_To_Bd09(latitude, longitude);
      latitude = list[0];
      longitude = list[1];
      print("latitude, longitude====end=====>${latitude}==$longitude");
    }
    var url = 'baidumap://map/direction?destination=$latitude,$longitude&coord_type=bd09ll&mode=driving';

    bool canLaunch = await canLaunchUrl(Uri.parse(url));

    if (!canLaunch) {
      return false;
    }

    await launchUrl(Uri.parse(url));

    return canLaunch;
  }



}
