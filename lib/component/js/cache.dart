import 'dart:io';
import 'package:path_provider/path_provider.dart';
class XCacheManager {

 

  static String formatSize(double value) {
    if (null == value) {
      return '0';
    }
    List<String> unitArr = []..add('B')..add('K')..add('M')..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }
  /// 删除缓存
  static Future clearApplicationCache() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();
    Directory tempDirectory = await getTemporaryDirectory();

    if (docDirectory.existsSync()) {
      await deleteDirectory(docDirectory);
    }

    if (tempDirectory.existsSync()) {
      await deleteDirectory(tempDirectory);
    }
  }
  static Future<Null> deleteDirectory(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await deleteDirectory(child);
        await child.delete();
      }
    }
  }
  static Future<double> loadApplicationCache() async {
    //获取文件夹
    Directory docDirectory = await getApplicationDocumentsDirectory();
    Directory tempDirectory = await getTemporaryDirectory();

    double size = 0;

    if (docDirectory.existsSync()) {
      size += await getTotalSizeOfFilesInDir(docDirectory);
    }
    if (tempDirectory.existsSync()) {
      size += await getTotalSizeOfFilesInDir(tempDirectory);
    }
    return size;
  }

   static Future<double> getTotalSizeOfFilesInDir(
      final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      double total = 0;
      if (children != null)
        for (final FileSystemEntity child in children)
          total += await getTotalSizeOfFilesInDir(child);
      return total;
    }
    return 0;
  }
}