import 'dart:io';
import 'dart:ui';

// import 'package:easy_folder_picker/FolderPicker.dart';
// import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:share_plus/share_plus.dart';

import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'package:android_external_storage/android_external_storage.dart';

import '../assignment/assignment_data.dart';
import '../common_util.dart';
import '../file_storage.dart';

class ImportExport extends StatefulWidget {
  final void Function()? afterImport;
  ImportExport({this.afterImport});
  @override
  State<StatefulWidget> createState() {
    return ImportExportState();
  }
}

class ImportExportState extends State<ImportExport> {
  final String _exportDirKey = "exportDirKey";
  final KeyValueFile _kvFile = KeyValueFile();
  final double _width = MediaQueryData.fromWindow(window).size.width;

  String? _defaultPath;
  Directory _dir = Directory("");
  Directory _rootDir = Directory("");

  final String _fileName_prefix = "天天计数-";
  String _fileName_timestamp = "";
  final String _fileName_postfix = ".xlsx";

  String _importFilePath = "未导入文件";
  String _log = "未导入文件";

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await _initPath();
    String? path = await _kvFile.getString(key: _exportDirKey);
    // _defaultPath = defaultDir.path;
    if ((null == path) || ("" == path)) {
      path = _defaultPath;
    }

    _dir = Directory(path!);

    setState(() {});

    _fileName_timestamp = DateFormat("yyyyMMdd-HHmmss").format(DateTime.now());

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("数据备份/导入")),
      body: Container(
//      decoration: BoxDecoration(color: Colors.cyan[100]),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Builder(
              builder: _builder,
            ),
          ),
        ),
      ),
    );
  }

  Widget _builder(BuildContext context) {
    return Container(
      width: _width,
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: _width * 9 / 10,
//        height: _width * 15 / 100,
//            color: Colors.grey,
        child: Column(
//              crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCard_dir(context),
            Divider(),
            _buildCard_export(context),
            Divider(),
            _buildCard_import(context),
            Divider(),
            SizedBox(height: _width * 3 / 100),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[300])),
              child: Text("返回", style: TextStyle(fontSize: _width / 15)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(height: _width * 40 / 100),
          ],
        ),
      ),
    );
  }

  _onPressButton_changeDir() async {
    if (!_dir.existsSync()) {
      _dir.createSync(recursive: true);
    }
    print(_dir.path);

    String? path = await FilePicker.platform.getDirectoryPath();

    print("change dir : ${path}/");

    if (null != path) {
      _dir = Directory(path + "/");
      _kvFile.setString(key: _exportDirKey, value: _dir.path);
      setState(() {});
    }

    return;
  }

  _onPressButton_share() async {
    if (null != _data) {
      // await esys_flutter_share.Share.file("分享到：", _fileName, _data, '*/*');
      // await FlutterShare.shareFile(
      //     title: "分享到：",
      //     filePath: _dir.path +
      //         _fileName_prefix +
      //         _fileName_timestamp +
      //         _fileName_postfix);

      await Share.shareFiles(
        [
          _dir.path +
              _fileName_prefix +
              _fileName_timestamp +
              _fileName_postfix,
        ],
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("请先备份",
              style: TextStyle(color: Colors.red, fontSize: _width / 10)),
        ]),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.tealAccent,
      ));
    }
    return;
  }

  _onPressButton_resetDir() {
    print("reset dir : ${_defaultPath}");
    _dir = Directory(_defaultPath!);
    _kvFile.setString(key: _exportDirKey, value: "");
    setState(() {});
    return;
  }

  Widget _buildCard_dir(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: _width * 5 / 100),
        Card(
          elevation: 5.0,
          color: Colors.lightBlueAccent.withOpacity(0.8),
          child: Container(
            margin: EdgeInsets.all(_width * 5 / 100),
            child: Column(
              children: [
                Container(
//            alignment: Alignment.centerLeft,
                    width: _width * 9 / 10,
                    height: _width * 15 / 100,
//            color: Colors.grey,
                    child: FittedBox(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.yellow)),
                          child: Text("更改目录",
                              style: TextStyle(
                                  color: Colors.red, fontSize: _width / 20)),
                          onPressed: _onPressButton_changeDir,
                        ),
                        SizedBox(width: _width * 5 / 100),
                        OutlinedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.yellow)),
                          child: Text("默认目录",
                              style: TextStyle(
                                  color: Colors.red, fontSize: _width / 20)),
                          onPressed: _onPressButton_resetDir,
                        ),
                      ],
                    ))),
                SizedBox(height: _width * 2 / 100),
                Container(
                    width: _width * 9 / 10,
                    color: Colors.grey[300],
                    child: Text(_dir.path,
                        style: TextStyle(fontSize: _width / 20))),
                SizedBox(height: _width * 2 / 100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _onPressButton_export() async {
    final msg = await _export(
        _dir.path + _fileName_prefix + _fileName_timestamp + _fileName_postfix);
    if ((null == msg) || ("" == msg)) {
      showMsg(context, "备份成功！");
    }
    return;
  }

  Widget _buildCard_export(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          elevation: 5.0,
          color: Colors.yellow.withOpacity(0.8),
          child: Container(
            margin: EdgeInsets.all(_width * 5 / 100),
            child: Column(
              children: [
                Container(
                    width: _width * 90 / 100,
                    color: Colors.grey[300],
                    child: Text(
                        _fileName_prefix +
                            "\n" +
                            _fileName_timestamp +
                            _fileName_postfix,
                        style: TextStyle(fontSize: _width / 20))),
                SizedBox(height: _width * 4 / 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.lightBlueAccent)),
                        child: Text("备份",
                            style: TextStyle(
                                color: Colors.red, fontSize: _width / 15)),
                        onPressed: _onPressButton_export),
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.lightBlueAccent)),
                        child: Text("分享",
                            style: TextStyle(
                                color: Colors.red, fontSize: _width / 15)),
                        onPressed: _onPressButton_share),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _onPressButton_import() async {
    final msg = await _import();
    String showMsg;
    if ((null == msg) || ("" == msg)) {
      showMsg = "导入成功";
      if (null != widget.afterImport) {
        widget.afterImport!();
      }
    } else {
      showMsg = msg;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(showMsg,
            style: TextStyle(color: Colors.red, fontSize: _width / 10))
      ]),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.tealAccent,
//    action: SnackBarAction(
//      label: "button",
//      onPressed: () {
//        print("in press");
//      },
//    ),
    ));
    return;
  }

  Widget _buildCard_import(BuildContext context) {
    return Column(
      children: <Widget>[
//        SizedBox(height: _width * 1 / 100),
        Card(
          elevation: 5.0,
          color: Colors.lightBlueAccent.withOpacity(0.8),
          child: Container(
            margin: EdgeInsets.all(_width * 5 / 100),
            child: Column(
              children: [
//                 Container(
//                     alignment: Alignment.centerLeft,
// //                    width: _width * 4 / 10,
// //            color: Colors.grey,
//                     child: Text("导入：",
//                         style: TextStyle(
//                             fontSize: _width / 10, color: Colors.grey[700]))),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.yellow)),
                  child: Text("选择导入文件",
                      style:
                          TextStyle(color: Colors.red, fontSize: _width / 15)),
                  onPressed: _onPressButton_import,
                ),
                SizedBox(height: _width * 3 / 100),
                Container(
                    width: _width * 9 / 10,
                    color: Colors.grey[300],
                    child: Text(_importFilePath,
                        style: TextStyle(fontSize: _width / 20))),
                SizedBox(height: _width * 3 / 100),
                Container(
                    width: _width * 9 / 10,
                    color: Colors.grey[300],
                    child: Text(_log, style: TextStyle(fontSize: _width / 20))),
//                SizedBox(height: _width / 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static ByteData? _bd;
  List<int>? _data;
  _export(String fullpath) async {
    final msg = await _isPermissionOK();
    if (null != msg) {
      return msg;
    }

    if (null == _bd) {
      _bd = await _loadAssetFile();
    }

    SpreadsheetDecoder decoder = SpreadsheetDecoder.decodeBytes(
      _bd!.buffer.asUint8List().toList(),
      update: true,
    );

//    print("xxx init ${decoder.encode().length}");
    await _exportAllData(decoder);

    _data = decoder.encode();
//    print("xxx final ${_data.length}");

    await _save2Local(fullpath, _data!);
//    await _save2Local(fullpath, decoder.encode());
    return;
  }

  Future<String?> _isPermissionOK() async {
    if (Platform.isAndroid) {
      // if (await Permission.storage.status PermissionHandler()
      //         .checkPermissionStatus(PermissionGroup.storage) !=
      //     PermissionStatus.granted)
      if (await Permission.storage.status != PermissionStatus.granted) {
        final msg = "没有存储权限";
        debugPrint(msg);
        return msg;
      }
    }
    return null;
  }

  Future<ByteData> _loadAssetFile() async {
    final assetPath = "assets/files/empty.xlsx";
    return await rootBundle.load(assetPath);
  }

  _initPath() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
//      dic = await getExternalStorageDirectory();
      if (null == _defaultPath) {
        String rootPath =
            (await AndroidExternalStorage.getExternalStorageDirectory())!;
        _rootDir = Directory(rootPath);
        _defaultPath = rootPath + "/天天计数/";
      }
      _dir = Directory(_defaultPath!);
//       dir = Directory("/storage/emulated/0/Android/data/com.example.daydayup/");

      // dir = Directory("/data/user/0/daydaytally");

      // dir = Directory("daydaytally");
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      assert(false);
      // dir = await getApplicationDocumentsDirectory();
    }

    return;
  }

  Future<bool> _save2Local(String fullpath, List<int> data) async {
    print("save file: ${fullpath}");

    File file = File(fullpath);
    if (await file.exists()) {
      await file.delete();
    }
    await file.create(recursive: true);

//    debugPrint("文件路径->" + file.path);
//    ByteData bd = await rootBundle.load(assetPath);
//    await file.writeAsBytes(bd.buffer.asUint8List(), flush: true);
    await file.writeAsBytes(data, flush: true);

    return true;
  }

  _exportAllData(SpreadsheetDecoder decoder) async {
    final allAssignmentData = await AssignmentData.getAllAssignment();
//    print("xxx _exportAllData data=${decoder.encode().length}");
    _exportTitles(allAssignmentData, decoder);
//    print("xxx _exportAllData data=${decoder.encode().length}");
    await _exportDatas(allAssignmentData, decoder);
//    print("xxx _exportAllData data=${decoder.encode().length}");
  }

  _exportTitles(
      List<AssignmentData> allAssignmentData, SpreadsheetDecoder decoder) {
    final table = decoder.tables.keys.first;
    for (int i = 0; i < allAssignmentData.length + 1; i++) {
      decoder.insertColumn(table, i);
    }

    decoder.insertRow(table, 0);
    decoder.updateCell(table, 0, 0, "日期");

    int i = 1;
    for (final a in allAssignmentData) {
      decoder.updateCell(table, i, 0, a.name);
      i++;
    }
    return;
  }

  _exportDatas(List<AssignmentData> allAssignmentData,
      SpreadsheetDecoder decoder) async {
    final String table = decoder.tables.keys.first;
    final List<dynamic> rowData =
        List.generate(allAssignmentData.length + 1, (_) => null);
//    final SpreadsheetTable table = decoder.tables.values.first;
    int row = 1;
    List<int> years = await AssignmentData.getAllAssignmentYears();
    for (final y in years) {
//      print("xxx $y");
      List<int> dateList =
          await AssignmentData.getAllAssignmentSortedDatesByYear(y);
      for (int date in dateList) {
        rowData[0] = date; // date

        int column = 1;
        int doneCount = 0;
//        rowData.toSet().toList().sort();
        for (final a in allAssignmentData) {
          final done = await a.getDailyDoneByIntAsync(date);

          if ((null != done) && (0 != done)) {
            rowData[column] = done;
            doneCount++;
          }
          column++;
        }
        if (0 != doneCount) {
          decoder.insertRow(table, row);
          final di = DateInt.fromInt(date);
          decoder.updateCell(table, 0, row, "${di.year}/${di.month}/${di.day}");
          for (int i = 1; i < column; i++) {
            if (null != rowData[i]) {
              decoder.updateCell(table, i, row, rowData[i]);
              rowData[i] = null;
            }
          }
          row++;
        }
      }
    }

    return;
  }

  Future<String?> _import() async {
//    final msg = await _isPermissionOK();
//    if (null != msg) {
//      return msg;
//    }
//    String localPath = await _localImportFilePath();
//    final String localPath =

    String? path;

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["xlsx"],
        // initialDirectory: _defaultPath, // 移动平台不支持这个参数
      );
      path = result?.paths.first;
      // if (null != result) {
      //   if (result.paths.isNotEmpty) {
      //     path = result.paths.first;
      //   }
      // }
    } on PlatformException catch (e) {
      print("不支持的操作：" + e.toString());
    } catch (ex) {
      print(ex);
    }

    print("import file: ${path}");

    if (null == path) {
      return "未选择文件";
    }

    _importFilePath = path;

    List<int> bytes = File(path).readAsBytesSync();

    SpreadsheetDecoder decoder;
    try {
      decoder = SpreadsheetDecoder.decodeBytes(bytes, update: true);
    } catch (err) {
      return "请选择合法的xlsx文件";
    }

    // Map<table, Map<column, name>>
    Map<String, Map<int, String>> allTableTitles = {};

    // Map<table, Map<column, Map<date, done>>>
    Map<String, Map<int, Map<int, int>>> allTableDatas = {};

    _log = "解析到：\n";
    for (final table in decoder.tables.values) {
      final Map<int, String> titles = _parseTableTitle(table);
      if (titles.isEmpty) {
        // 空表
        continue;
      }

      assert(null == allTableTitles[table.name]);
      allTableTitles[table.name] = titles;

      assert(null == allTableDatas[table.name]);
      final tableData = _parseDatas(table, titles);
      allTableDatas[table.name] = tableData;
    }

    setState(() {});

//    print("xxx " + _log);

    final Map<String, Map<int, int>> allInOne = {};
    allTableDatas.forEach((String tableName, Map<int, Map<int, int>> m) {
      m.forEach((int column, Map<int, int> dailyDatas) {
        final assignmentName = allTableTitles[tableName]![column]!;
        final assignmentData = allInOne[assignmentName];
        if (null == assignmentData) {
          allInOne[assignmentName] = dailyDatas;
        } else {
          assignmentData.addAll(dailyDatas); // 最新读到的数据覆盖旧的数据，不累计
        }
      });
    });

    AssignmentData.import(allInOne);

    return null;
  }

  Map<int, String> _parseTableTitle(SpreadsheetTable table) {
    Map<int, String> titles = {};

    if ((table.maxCols <= 1) || (table.maxRows <= 1)) {
      return titles;
    }

    final r = 0;
    int c;
    final pattern = RegExp(r'时间|日期');
    for (c = 0; c < table.maxCols; c++) {
      final v = table.rows[r][c];
      final str = v.toString();
      if (str.contains(pattern)) {
        break;
      }
    }
    if (!(c < table.maxCols)) {
      // 没有找到日期列
      return titles;
    }

    for (c++; c < table.maxCols; c++) {
      final v = table.rows[r][c];
      titles[c] = v.toString();
    }

    return titles;
  }

  Map<int, Map<int, int>> _parseDatas(
      SpreadsheetTable table, Map<int, String> titles) {
    final Map<int, Map<int, int>> tableData = {};

    titles.forEach((int column, String name) {
      tableData[column] = {};
    });

    final dtBase = DateTime(1900, 1, 0);
    final coloumns = titles.keys.toList();
    coloumns.sort();
    final startColumn = coloumns.first - 1;
    final endColumn = coloumns.last;

    int records = 0;
    for (int r = 1; r < table.maxRows; r++) {
      final v = table.rows[r][startColumn];
      DateInt? dateInt = parseExcelDate(v);
      if (null == dateInt) {
        print("import parse date error: ${table.name}[$r][1]:$v");
        continue;
      }

      for (int c = startColumn + 1; c <= endColumn; c++) {
        final v = table.rows[r][c];
        int done;
        if (null == v) {
          continue;
        } else if (v is int) {
          done = v;
        } else if (v is String) {
          try {
            done = int.parse(v);
          } catch (e) {
            print("import parse done error: ${table.name}[$r][$c]:$v");
            continue;
          }
        } else {
          print("import parse done error: ${table.name}[$r][$c]:$v");
          continue;
        }

        if (null != tableData[c]![dateInt.data]) {
          tableData[c]![dateInt.data] = tableData[c]![dateInt.data]! + done;
        } else {
          tableData[c]![dateInt.data] = done;
        }
        // tableData[c]![dateInt.data] =
        //     (tableData[c]![dateInt!.data] ?? 0) + done;
        // if (null == tableData[c]![dateInt!.data]) {
        //   tableData[c]![dateInt.data] = done;
        // } else {
        //   tableData[c]![dateInt.data] += done;
        // }
      }
      records++;
    }

    _log += "    [${table.name}]  $records条记录\n";

    return tableData;
  }
}
