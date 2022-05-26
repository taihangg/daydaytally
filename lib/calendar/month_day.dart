import 'dart:ui';
// import 'package:marquee_text/marquee_text.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:flutter/material.dart';
import 'user_defined_festival_manager.dart';
import '../plugins/sxwnl/sxwnl_Lunar.dart';
// import 'package:marquee_widget/marquee_widget.dart';
// import 'package:marquee/marquee.dart';
// import 'package:marquee/marquee.dart';
// import 'package:marquee_flutter_nullsafety/marquee_flutter_nullsafety.dart';
// import 'package:marquee_in_flutter/marquee.dart';

class TitleDay extends StatelessWidget {
  final double screenWidth;

  TitleDay(this.num, this.screenWidth)
      : assert(1 <= num),
        assert(num <= 7);
  final int num;

  final List<String> _weekDayName = ["一", "二", "三", "四", "五", "六", "天"];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth / 8,
      height: screenWidth / 8 / 10 * 6,
      decoration: BoxDecoration(
        color: Colors.blue[300],
        border: Border.all(width: 0.5, color: Colors.black38),
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
      ),
      child: Center(
        child: FittedBox(
          child: Text(
            _weekDayName[num - 1],
            style: TextStyle(fontSize: screenWidth / 20, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class DayBox extends StatelessWidget {
  final UserDefinedFestivalManager userDefinedFestivalMgr;
  final DayInfo dayInfo;
  final DateTime date;
  final int geoMonthDaysCount;

  final bool baskgroundGrey;
  final bool isToday;
  final bool selected;
  final Function(DateTime, DayInfo, bool)? onSelectedFn;

  bool? showNoteIcon;
  bool? noteActive;

  static final int _columnCount = 4;
  static final double _width = MediaQueryData.fromWindow(window).size.width;
  static late final double _fontSize = _width * 4 / 100;
  static late final double _boxWidth = _width * 12.5 / 100;
  static late final double _boxItemHight = _boxWidth * 2 / 5;

  DayBox(this.userDefinedFestivalMgr, this.dayInfo, this.date,
      {required this.geoMonthDaysCount,
      this.baskgroundGrey = false,
      this.isToday = false,
      this.selected = false,
      this.onSelectedFn}) {}

  @override
  Widget build(BuildContext context) {
    // // 添加任务图标
    // if (showNoteIcon) {
    //   stackChildren.add(Container(
    //       alignment: Alignment.centerLeft,
    //       child: Icon(Icons.event_note,
    //           size: _width / 27,
    //           color: noteActive ? Colors.orange : Colors.grey)));
    // }

    // BoxDecoration decoration = BoxDecoration(
    //   // color: Colors.cyan,
    //   border: Border.all(width: 0.5, color: Colors.cyan),
    //   // borderRadius: BorderRadius.all(Radius.circular(8.0)),
    // );
    // decoration = null;

    return GestureDetector(
      child: Container(
          width: _boxWidth,
          // height: _boxItemHight * _columnCount,
          child: Stack(children: [
            _buildBackgroundLayer(),
            _buildForgroundLayer(),
          ])),
      onTap: () {
        if (null != onSelectedFn) {
          onSelectedFn!(date, dayInfo, !selected);
        }
      },
    );
  }

  Widget _buildBackgroundLayer() {
    Color? backgroundColor;
    if (true == isToday) {
      backgroundColor = Color(0xFFFFD700);
    } else if (baskgroundGrey) {
      backgroundColor = Colors.grey[300]!.withOpacity(0.8);
    }

    // 用一个单独的Container来处理选中时候的效果
    // 如果直接在显示层处理选中效果，点击选中的时候显示内容会有细微的大小变化
    // 背景放在最底层，否则会覆盖其他显示内容
    assert(4 == _columnCount);
    return Container(
        width: _boxWidth,
        height: _boxItemHight * _columnCount,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
              width: selected ? 2.0 : 0.1,
              color: selected ? Colors.red : Colors.black38),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ));
  }

  Widget _buildForgroundLayer() {
    List<Widget> columnChildren = [
      _buildGregorianFestivalLine(),
      _buildMainLine(),
      _buildGanziFestivalLine(),
      _buildLunarFestivalLine(),
    ];

    assert(columnChildren.length == _columnCount);
    return FittedBox(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: columnChildren));
  }

  Widget _buildMainLine() {
    List<TextSpan> mainLineStrs = [];

    String geoStr;
    Color geoColor;
    double geoFontSize = _fontSize;
    if (1 == dayInfo.day) {
      geoStr = "${dayInfo.month}月";
      geoColor = Colors.red;
    } else {
      if (dayInfo.day < 10) {
        geoStr = "${dayInfo.day} ";
      } else {
        geoStr = "${dayInfo.day}";
      }
      geoColor = Colors.black;
      geoFontSize = _fontSize * 1.3;
    }
    mainLineStrs.add(TextSpan(
        text: geoStr,
        style: TextStyle(fontSize: geoFontSize, color: geoColor)));

    String lunarStr;
    Color lunarColor;
    if (1 == dayInfo.lunarDay) {
      lunarStr = dayInfo.lunarRunyue + dayInfo.lunarMonthName;
      lunarColor = Colors.red;
    } else {
      lunarStr = dayInfo.lunarDayName;
      lunarColor = Colors.grey[700]!;
    }

    mainLineStrs.add(TextSpan(
        text: lunarStr,
        style: TextStyle(fontSize: _fontSize, color: lunarColor)));

    return Container(
      alignment: Alignment.topCenter,
      width: _boxWidth,
      height: _boxItemHight,
      child: FittedBox(
          child: RichText(
              text: TextSpan(children: mainLineStrs),
              textAlign: TextAlign.right)),
    );

    // return _buildMarqueeText(mainLineStrs, intervalStr);
  }

  Widget _buildGregorianFestivalLine() {
    List<TextSpan> gregorianFestivalStrs = [];

    if ("" != dayInfo.jieqi) {
      //节气
      gregorianFestivalStrs.add(
        TextSpan(
            text: dayInfo.jieqi,
            style: TextStyle(fontSize: _fontSize, color: Colors.deepOrange)),
      );
    }

    if ("" != dayInfo.gregorianFestival) {
      //公历节日
      gregorianFestivalStrs.add(
        TextSpan(
            text: dayInfo.gregorianFestival,
            style: TextStyle(fontSize: _fontSize, color: Colors.deepOrange)),
      );
    }

    gregorianFestivalStrs.addAll(_getUserDefinedGregorianFestival());

    return _buildMarqueeText(gregorianFestivalStrs);
  }

  Widget _buildLunarFestivalLine() {
    List<TextSpan> lunarFestivalStrs = [];

    if ("" != dayInfo.lunarFestival) {
      //农历节日
      lunarFestivalStrs.add(
        TextSpan(
            text: dayInfo.lunarFestival,
            style: TextStyle(fontSize: _fontSize, color: Colors.blue)),
      );
    }
    if ("" != dayInfo.ganzhiFestival) {
      // 干支信息，三伏、三九等
      lunarFestivalStrs.add(TextSpan(
          text: dayInfo.ganzhiFestival,
          style: TextStyle(fontSize: _fontSize, color: Colors.deepOrange)));
    }

    lunarFestivalStrs.addAll(_getUserDefinedLunarFestival());

    return _buildMarqueeText(lunarFestivalStrs);
  }

  Widget _buildGanziFestivalLine() {
    List<TextSpan> ganziFestivalStrs = [];
    ganziFestivalStrs.add(TextSpan(
        text: dayInfo.gzDay,
        style: TextStyle(fontSize: _fontSize, color: Colors.cyan[600])));

    return _buildMarqueeText(ganziFestivalStrs);
  }

  List<TextSpan> _getUserDefinedGregorianFestival() {
    List<Festival> festivalList = userDefinedFestivalMgr.getGregorianFestival(
        dayInfo.month, dayInfo.day, geoMonthDaysCount);

    return festivalList.map((Festival festival) {
      return TextSpan(
          text: festival.text,
          style: TextStyle(fontSize: _fontSize, color: festival.color));
    }).toList();
  }

  List<TextSpan> _getUserDefinedLunarFestival() {
    List<Festival> festivalList = userDefinedFestivalMgr.getLunarFestival(
        dayInfo.month, dayInfo.lunarDay, dayInfo.lunarMonthDayCount);

    final all = festivalList.map((Festival festival) {
      return TextSpan(
          text: festival.text,
          style: TextStyle(fontSize: _fontSize, color: festival.color));
    }).toList();
    return all;
  }

  Widget _buildMarqueeText(List<TextSpan> strs, [String intervalStr = ","]) {
    BoxDecoration? decoration = BoxDecoration(
      // color: Colors.cyan,
      border: Border.all(width: 0.5, color: Colors.red),
      // borderRadius: BorderRadius.all(Radius.circular(8.0)),
    );
    decoration = null;

    if (strs.isEmpty) {
      return Container(
        alignment: Alignment.topCenter,
        width: _boxWidth,
        height: _boxItemHight,
        decoration: decoration,
        child: Text(""),
      );
    }

    List<TextSpan> allSubStrs;
    if ("" == intervalStr) {
      allSubStrs = strs;
    } else {
      allSubStrs = [];

      TextSpan interval = TextSpan(
          text: intervalStr,
          style: TextStyle(fontSize: _fontSize, color: Colors.grey));

      // int length = 0;
      strs.forEach((TextSpan e) {
        // length += e.text!.length;
        allSubStrs.addAll([e, interval]);
      });

      allSubStrs.removeLast();
    }

    Widget child = Marquee(
        child: RichText(
            text: TextSpan(children: allSubStrs), textAlign: TextAlign.center),
        animationDuration: Duration(milliseconds: 3000),
        backDuration: Duration(milliseconds: 3000),
        pauseDuration: Duration(milliseconds: 500));

    return Container(
        alignment: Alignment.topCenter,
        width: _boxWidth,
        height: _boxItemHight,
        decoration: decoration,
        child: child);
  }
}
