// 可以在utils定义log.dart
import 'index.dart';

void printLog(Object message, StackTrace current) {
  MYCustomTrace programInfo = MYCustomTrace(current);
  print(
      "文件位置: ${programInfo.fileName}, 行: ${programInfo.lineNumber} ====> 打印信息: $message");
}

class MYCustomTrace {
  final StackTrace _trace;
  String? fileName;
  int? lineNumber;

  MYCustomTrace(this._trace) {
    _parseTrace();
  }

  void _parseTrace() {
    var traceString = this._trace.toString().split("\n")[0];
    var indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z_]+.dart'));
    var fileInfo = traceString.substring(indexOfFileName);
    var listOfInfos = fileInfo.split(":");
    this.fileName = listOfInfos[0];
    var lineNumber = listOfInfos[1];
    lineNumber = lineNumber.replaceFirst(")", "");
    this.lineNumber = XUtil.intParse(lineNumber);

  }
}
