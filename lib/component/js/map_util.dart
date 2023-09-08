import 'dart:io';

import 'package:url_launcher/url_launcher.dart';
import 'package:xui/component/index.dart';

import 'gps_util.dart';


enum MapUtilEnum { apple, amap, baidu, tencent, google }

class MapUtil {
  static Future<List> allMap() async {
    List list = [];

    try {
      var url = '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=1&lon=2&dev=0&style=2';
      logger.d(await canLaunchUrl(Uri.parse(url)));
      if (await canLaunchUrl(Uri.parse(url))) {
        list.add({'type': MapUtilEnum.amap, 'name': '高德地图'});
      }
      if (await canLaunchUrl(Uri.parse('qqmap://map/routeplan?type=drive&fromcoord=CurrentLocation&tocoord=&referer=IXHBZ-QIZE4-ZQ6UP-DJYEO-HC2K2-EZBXJ'))) {
        list.add({'type': MapUtilEnum.tencent, 'name': '腾讯地图'});
      }
      if (await canLaunchUrl(Uri.parse('baidumap://map/direction?destination=&coord_type=bd09ll&mode=driving'))) {
        list.add({'type': MapUtilEnum.baidu, 'name': '百度地图'});
      }
      if (Platform.isIOS) {
        list.add({'type': MapUtilEnum.apple, 'name': '苹果地图'});
      }
    } catch (e) {
      print(e);
    }
    return list;
  }

  static Future gotoMap({required MapUtilEnum type,longitude, latitude,formGaode = false}) async {
    if (type == MapUtilEnum.amap) {
      await gotoAMap(longitude, latitude);
    }

    if (type == MapUtilEnum.apple) {
      var url = 'http://maps.apple.com/?&daddr=$latitude,$longitude';
      await launchUrl(Uri.parse(url));
    }

    if (type == MapUtilEnum.baidu) {
      await gotoBaiduMap(longitude, latitude, formGaode);
    }

    if (type == MapUtilEnum.tencent) {
      await gotoTencentMap(longitude, latitude);
    }
  }


  static Future fromToAMap({
    required MapUtilEnum type,
    required double fromLat,
    required double fromLog,
    required String startName,
    required String endName ,
    required double toLat,
    required double toLog,
    bool formGaode = true,
    int t = 2,
  }) async {
    String url = "";
   
    if (type == MapUtilEnum.amap) {

      url= "${Platform.isAndroid ? 'android' : 'ios'}amap://route/plan/?sid=&slat=${fromLat}&slon=${fromLog}&sname=${startName}&did=&dlat=${toLat}&dlon=${toLog}&dname=$endName&dev=0&t=$t";
    }

    if (type == MapUtilEnum.apple) {
       url = 'http://maps.apple.com/?&daddr=${toLat},${toLog}';
    }

    if (type == MapUtilEnum.baidu) {
      String mode = "";
      if(t==2){
        mode = 'walking';
      }
      url = 'baidumap://map/direction?origin=${fromLat},${fromLog}&destination=${fromLat},${toLog}&origin_name=$startName&destination_name=$endName&mode=$mode';
      if (formGaode) {
        List list = GpsUtil.gcj02_To_Bd09(fromLat, fromLog);
        List list1 = GpsUtil.gcj02_To_Bd09(toLat, toLog);
        url = 'baidumap://map/direction?origin=${list[0]},${list[1]}&destination=${list1[0]},${list1[1]}&origin_name=$startName&destination_name=$endName&mode=$mode';
      }
    }

    if (type == MapUtilEnum.tencent) {
      url = 'qqmap://map/routeplan?type=walk&from=$startName&fromcoord=${fromLat},${fromLog}&to=${endName}&tocoord=${toLat},${toLog}';
    }
   
    bool canLaunch = await canLaunchUrl(Uri.parse(url));
    if (canLaunch) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch';
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
      List list = GpsUtil.gcj02_To_Bd09(latitude, longitude);
      latitude = list[0];
      longitude = list[1];
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
