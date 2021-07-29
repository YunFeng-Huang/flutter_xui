// // '相册'ImageSource.gallery  '相机' ImageSource.camera
//
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
//
// import 'compontent/ui/toast.dart';
// import 'compontent/ui/my_loading.dart';
// import 'package:image_picker/image_picker.dart';
//
// class XupLoadFile {
//   static PickedFile? file;
//   late Response response;
//   static late Dio dio = Dio();
//   static XupLoadFile _instance = XupLoadFile();
//   factory XupLoadFile() {
//     return _instance;
//   }
//   static Future<String> getVideo(ImageSource source) async {
//     file = await ImagePicker().getVideo(source: source);
//     print(file);
//     return file!.path;
//   }
//
//   static Future<String> getImage(ImageSource source) async {
//     file = await ImagePicker().getImage(source: source);
//     return file!.path;
//   }
//
//   static late String _url;
//   static late String _token;
//   static BuildContext get _context => ToastCompoent.context;
//   static late int _merchantId;
//
//   static Future<String> upload({
//     url,
//     type,
//     token,
//     merchantId,
//   }) async {
//     _url = url;
//     _token = token;
//     _merchantId = merchantId;
//     if (type == 'video') {
//       return await putBigFile(file!.path);
//     } else {
//       // return await HomeApi.uploadFile(file.path);
//     }
//     return file!.path;
//   }
//
//   static Future putBigFile(String filePath) async {
//     LoadingConfig.type = true;
//     showLoading('上传中，请稍等');
//     print(filePath);
//     File files = File(filePath);
//     var sFile = await files.open();
//     try {
//       int fileLength = sFile.lengthSync();
//       int chunkSize = 1024 * 1024;
//       int x = 0;
//       int chunkIndex = 0;
//       while (x < fileLength) {
//         // 是否是最后一片了
//         bool isLast = fileLength - x >= chunkSize ? false : true;
//         int _len = isLast ? fileLength - x : chunkSize;
//         // 获取一片
//         List<int> postData = sFile.readSync(_len).toList();
//
//         var data = Stream.fromIterable([postData]);
//         var name = filePath.substring(filePath.lastIndexOf("/") + 1, filePath.length);
//         print(name);
//         var headers = {
//           'merchantId': _merchantId,
//           'token': _token,
//           Headers.contentLengthHeader: postData.length,
//           'fileId': name,
//           'index': chunkIndex,
//           'chunkCount': fileLength ~/ chunkSize,
//         };
//         try {
//           var response = (await dio.post(
//             _url,
//             data: data,
//             options: Options(headers: headers, contentType: 'application/octet-stream'),
//             onSendProgress: (c, t) {
//               var current = x + c;
//               var total = fileLength;
//               var a = (current / total * 100).floor();
//               print((current / total * 100).floor());
//               LoadingConfig.text = '上传进度 $a %';
//               // TODO 通知进度条
//             },
//           ));
//
//           if (chunkIndex == fileLength ~/ chunkSize) {
//             showToast('上传成功');
//             print(response.data);
//             return response.data['previewLink'];
//           }
//           chunkIndex++;
//           x += _len;
//         } catch (e) {
//           showToast('网络不稳定，请稍后重试');
//           LoadingConfig.text = null;
//           // Routers.pop();
//           return Future.error(e);
//         }
//       }
//     } finally {
//       sFile.close(); // 最后一定要关闭文件
//       Navigator.pop(_context);
//       LoadingConfig.text = null;
//     }
//   }
// }
