import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
// import 'package:location_permissions/location_permissions.dart'
//     as location_permissions;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'assignment/assignment_detail_page.dart';
import 'assignment/assignment_overview_page.dart';
import 'calendar/month_todo_page.dart';
import 'my_navigation_bar.dart';
import 'plugins/common_localizations_delegate.dart';
import 'weather/weather_view.dart';

void main() {
//  testFn();

  MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
  double _width = mediaQuery.size.width;
  double _height = mediaQuery.size.height;
  double _topbarH = mediaQuery.padding.top;
  double _botbarH = mediaQuery.padding.bottom;
  double _pixelRatio = mediaQuery.devicePixelRatio;
  print("xxx main : $_width $_height $_topbarH $_botbarH $_pixelRatio");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return ScreenUtilInit(
    //   designSize: Size(500, 1000),
    //   builder: () {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        //自定义代理
        CommonLocalizationsDelegate(),
//        DefaultCupertinoLocalizations.delegate,
//        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale("zh", "CN"),
      supportedLocales: [Locale('zh', 'CN'), Locale('en', 'US')],
      title: '天天向上',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _HomePage(),
    );
    //   },
    // );
  }
}

class _HomePage extends StatefulWidget {
  _HomePage({Key? key}) : super(key: key);

  @override
  createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<_HomePage>
    with SingleTickerProviderStateMixin {
  _HomePageState() {
    _checkPermission();
  }

  final double _width = MediaQueryData.fromWindow(window).size.width;
  final double _height = MediaQueryData.fromWindow(window).size.height;

  int _bottomBarSelectIndex = 0; // 默认第一个

  late TabController _tabController;

  final List<Widget> _tabHeadList = [];
  final List<Widget> _tabBodyList = [];

  final _assignmentDetailView = AssignmentDetailView();

  @override
  void initState() {
    super.initState();

    _addAssignmentOverview();
    _addAssignmentDetail();
    _addMonthTodoPage();
    _addWeather();

    assert(_tabBodyList.length == _tabHeadList.length);

    _tabController = TabController(length: _tabBodyList.length, vsync: this);

    return;
  }

  @override
  Widget build(BuildContext context) {
    var bottomNavigateBar = Container(
        height: _height * 11 / 100,
        child: MyBottomNavigationBar((int index) {
          if (_bottomBarSelectIndex != index) {
            _bottomBarSelectIndex = index;
            setState(() {});
          }
        }));

    return DefaultTabController(
      length: _tabHeadList.length,
      child: WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false, //避免软键盘把widget顶上去
          appBar: AppBar(
            //leading: Text('Tabbed AppBar'),
            //title: const Text('Tabbed AppBar'),
            title: TabBar(
                // isScrollable: false,
                tabs: _tabHeadList,
                controller: _tabController),
//      bottom: myTabBar,
          ),
//      body: _tabBarViewChildren[_bottomBarSelectIndex],
          body: TabBarView(children: _tabBodyList, controller: _tabController),
//      bottomNavigationBar: bottomNavigateBar,
        ),
        onWillPop: _onWillPop,
      ),
    );
  }

  _addMonthTodoPage() {
    _tabHeadList.add(Tab(
//        text: "日历",
      icon: Icon(Icons.border_all),
    ));

    _tabBodyList.add(MonthTodoPage());
    return;
  }

  _addAssignmentOverview() {
    _tabHeadList.add(Tab(
//      text: "功课",
//      icon: Icon(Icons.dehaze),
//      icon: Icon(Icons.sort),
      icon: Icon(Icons.format_list_bulleted),
    ));

    _tabBodyList.add(AssignmentOverview((int index) {
      _tabController.index = 1; // detail tab
      _assignmentDetailView.setShowingPage(index);
      // setState(() {});
      return;
    }));
    return;
  }

  _addAssignmentDetail() {
    _tabHeadList.add(Tab(
//      text: "功课",
      icon: Icon(Icons.assignment),
    ));

    _tabBodyList.add(_assignmentDetailView);
    return;
  }

  _addWeather() {
    _tabHeadList.add(Tab(
//        text: "天气",b
      icon: Icon(Icons.wb_sunny),
    ));

    _tabBodyList.add(WeatherPage());
    return;
  }

  _checkPermission() async {
    // PermissionStatus storagePermission = await Permission.storage.status;

    // if (PermissionStatus.granted != storagePermission) {
//    bool isOpened = await PermissionHandler().openAppSettings();
    permission_handler.PermissionStatus status;
    status =
        await permission_handler.Permission.manageExternalStorage.request();
    print("permission manageExternalStorage: ${status}");
    status = await permission_handler.Permission.storage.request();
    print("permission storage: ${status}");

    // location_permissions.PermissionStatus permission =
    //     await location_permissions.LocationPermissions().requestPermissions(
    //         permissionLevel:
    //             location_permissions.LocationPermissionLevel.locationWhenInUse);
    // print("permission2 ${permission}");

    // bool isShown = await Permission.storage.shouldShowRequestRationale;

    // PermissionStatus status = await Permission.storage.request();

//      if (PermissionStatus.granted != status.values.first.value) {
//        Scaffold.of(context).showSnackBar(SnackBar(
//          content: Text(
//            "请允许app读写存储的权限\n否则无法工作",
//            style: TextStyle(color: Colors.red, fontSize: 50),
//          ),
//          duration: Duration(seconds: 5),
//          backgroundColor: Colors.tealAccent,
////    action: SnackBarAction(
////      label: "button",
////      onPressed: () {
////        print("in press");
////      },
////    ),
//        ));
//      }
//     }

    return;
  }

  DateTime? _lastPopTime;
  Future<bool> _onWillPop() async {
    // 点击返回键的操作
    if (null == _lastPopTime ||
        DateTime.now().difference(_lastPopTime!) > Duration(seconds: 2)) {
      _lastPopTime = DateTime.now();
      Fluttertoast.showToast(
        msg: "再按一次退出",
//        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
//        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
//        textColor: Colors.grey,
        fontSize: _width / 12,
      );
      return false;
    } else {
      _lastPopTime = DateTime.now();
      // 退出app
      return await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }
}
