import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'user_defined_festival_editor.dart';
import '../plugins/sxwnl/sxwnl_Lunar.dart';

class MonthViewActionBar extends StatelessWidget {
//  final double _width = MediaQueryData.fromWindow(window).size.width;
//  final double _height = MediaQueryData.fromWindow(window).size.height;
  final double width;
  final DateTime showingMonth;
  final DayInfo Function(DateTime) getLunarDayInfoFn;
  final Function(DateTime month) onDateChangeFn;
  final String? Function() getFestivalTextFn;
  final String Function(String?) onSaveFn;
  MonthViewActionBar({
    required this.width,
    required this.showingMonth,
    required this.getLunarDayInfoFn,
    required this.onDateChangeFn,
    required this.getFestivalTextFn,
    required this.onSaveFn,
  }) {
    _allWidth = width * 96 / 100;
    _boxHeight = _allWidth * 15 / 100;
    _fontSize = _allWidth * 30 / 100;
    _actionBoxWidth = _allWidth * 30 / 100;
    return;
  }

  late double _allWidth;
  late double _boxHeight;
  late double _fontSize;
  late double _actionBoxWidth;

  @override
  Widget build(BuildContext context) {
    // final double fontSize = width / 15;
    List<Widget> firstLineChildren = <Widget>[
      _buildActionLineButton(
          Color(0xFFFFD700), Icons.arrow_back_ios, "上一年", true, _toPrevYearFn),
      SizedBox(width: width * 2 / 100),
      _buildActionLineButton(Color(0xFFFFD700), Icons.arrow_forward_ios, "下一年",
          false, _toNextYearFn),
      SizedBox(width: width * 4 / 100),
      _buildActionLineButton(
          Color(0xFFFFB90F), Icons.arrow_back_ios, "上一月", true, _toPrevMonthFn),
      SizedBox(width: width * 2 / 100),
      _buildActionLineButton(Color(0xFFFFB90F), Icons.arrow_forward_ios, "下一月",
          false, _toNextMonthFn),
    ];

    _manageFestival() {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return UserDefinedFestirvalEditor(getFestivalTextFn(), onSaveFn);
      }));
      return;
    }

    List<Widget> secondLineChildren = <Widget>[
      _buildTitleLineButton1(
          null, "节日\n管理", Colors.indigoAccent, _manageFestival),
      SizedBox(width: _allWidth * 5 / 100),
      _buildTitleLineDateButton(context, _boxHeight),
      SizedBox(width: _allWidth * 5 / 100),
      _buildTitleLineButton1(Colors.yellowAccent, "返回\n今日", Colors.red, () {
        onDateChangeFn(DateTime.now());
        return;
      }),
    ];

    BoxDecoration decoration = BoxDecoration(
      //color: Colors.redAccent,
      border: Border.all(width: 0.5, color: Colors.red),
      // borderRadius: BorderRadius.all(Radius.circular(8.0)),
    );

    return FittedBox(
      child: Container(
        width: _allWidth,
        // height: _boxHeight * 2.5,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          //color: Colors.redAccent,
          border: Border.all(width: 0.5, color: Colors.black38),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Column(
            children: [
              SizedBox(height: _allWidth * 2 / 100),
              Container(
                // height: _boxHeight,
                // decoration: decoration,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: firstLineChildren),
              ),
              SizedBox(height: _allWidth / 100),
              Container(
                  // height: _boxHeight * 1.5,
                  // decoration: decoration,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: secondLineChildren)),
              SizedBox(height: _allWidth * 2 / 100),
            ],
          ),
        ),
      ),
    );
  }

  _toPrevYearFn() {
    DateTime lastYear =
        DateTime(showingMonth.year - 1, showingMonth.month, showingMonth.day);
    if (lastYear.day != showingMonth.day) {
      //如果切换的日期没有这一天，可能会跑到指定日期的下一个月去了，那么就修改为目标月的最后一天
      lastYear = DateTime(lastYear.year, lastYear.month, 0);
    }

    onDateChangeFn(lastYear);
    return;
  }

  _toNextYearFn() {
    DateTime nextYear =
        DateTime(showingMonth.year + 1, showingMonth.month, showingMonth.day);
    if (nextYear.day != showingMonth.day) {
      //如果切换的日期没有这一天，可能会跑到指定日期的下一个月去了，那么就修改为目标月的最后一天
      nextYear = DateTime(nextYear.year, nextYear.month, 0);
    }
    onDateChangeFn(nextYear);
    return;
  }

  _toPrevMonthFn() {
    var lastMonth =
        DateTime(showingMonth.year, showingMonth.month - 1, showingMonth.day);
    if (lastMonth.day != showingMonth.day) {
      //如果切换的日期没有这一天，可能会跑到指定日期的下一个月去了，那么就修改为目标月的最后一天
      lastMonth = DateTime(showingMonth.year, showingMonth.month, 0);
    }

    onDateChangeFn(lastMonth);
    return;
  }

  _toNextMonthFn() {
    var nextMonth =
        DateTime(showingMonth.year, showingMonth.month + 1, showingMonth.day);
    if (nextMonth.day != showingMonth.day) {
      //如果切换的日期没有这一天，可能会跑到指定日期的下一个月去了，那么就修改为目标月的最后一天
      nextMonth = DateTime(showingMonth.year, showingMonth.month + 2, 0);
    }
    onDateChangeFn(nextMonth);
    return;
  }

  Widget _buildActionLineButton(Color backgrounColor, IconData icon,
      String title, bool iconAtHead, VoidCallback onPressedFn) {
    Color textColor = Colors.blue;
    List<Widget> children = [
      Text(title, style: TextStyle(fontSize: _fontSize, color: textColor))
    ];
    if (iconAtHead) {
      children.insert(
          0, Container(child: Icon(icon, size: _fontSize, color: textColor)));
    } else {
      children
          .add(Container(child: Icon(icon, size: _fontSize, color: textColor)));
    }
    return Container(
      width: _actionBoxWidth,
      height: _boxHeight * 1.0,
      // decoration:
      //     BoxDecoration(border: Border.all(width: 2.0, color: Colors.red)),
      child: FittedBox(
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey.shade200)),
          child: Row(
            // mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: children,
          ),
          onPressed: onPressedFn,
        ),
      ),
    );
  }

  Widget _buildTitleLineButton1(
    Color? backgroundColor,
    String text,
    Color textColor,
    GestureTapCallback onTapFn,
  ) {
    return GestureDetector(
      onTap: onTapFn,
      child: Container(
        width: _boxHeight * 1.3,
        height: _boxHeight * 1.3,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(width: 2.0, color: Colors.black38),
          borderRadius: BorderRadius.all(Radius.circular(23.0)),
        ),
        child: FittedBox(
          child: Text(text,
              style: TextStyle(color: textColor, fontSize: _fontSize)),
        ),
      ),
    );
  }

  Widget _buildTitleLineDateButton(BuildContext context, double boxHeight) {
    BoxDecoration decoration = BoxDecoration(
      //color: Colors.redAccent,
      border: Border.all(width: 0.5, color: Colors.lightBlue),
      // borderRadius: BorderRadius.all(Radius.circular(8.0)),
    );

    return Container(
      width: _allWidth * 65 / 100,
      height: boxHeight * 1.5,
      // decoration: decoration,
      //alignment: Alignment.center,
      //padding: EdgeInsets.fromLTRB(screenWidth / 100, 0, screenWidth / 100, 0),
//      color: Colors.lightBlueAccent,
      child: FittedBox(
        child: TextButton(
          // style: ButtonStyle(
          //     backgroundColor: MaterialStateProperty.all(Colors.amber[300])),
          child: Container(
            // width: _allWidth * 70 / 100,
            // height: boxHeight,
            decoration: BoxDecoration(
              //color: Colors.redAccent,
              border: Border.all(width: 8.0, color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            child: Column(
              children: [
                _buildGeoLine(),
                _buildGanziLine(),
              ],
            ),
          ),
          onPressed: () async {
//          var pickDate = await showDatePicker(
//            context: context,
//            initialDate: showMonth,
//            firstDate: DateTime(1900),
//            lastDate: DateTime(2100),
//            locale: Localizations.localeOf(context),
//          );
//
//          if (null != pickDate) {
//            onMonthChangeFn(pickDate);
//          }

//          showCupertinoDialog
            await showCupertinoModalPopup(
              //通过showDialog方法展示alert弹框
              context: context,
              builder: (context) {
                return Container(
//                width: screenWidth,
                    height: 300,
                    // color: Colors.yellow.shade300, //.withOpacity(0.3),
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (DateTime pickDate) {
                          // if (null != pickDate) {
                          onDateChangeFn(pickDate);
                          // }
                        },
                        backgroundColor: Colors.cyan.shade300,
                        initialDateTime: showingMonth,
                        minimumDate: DateTime(1900),
                        maximumDate: DateTime(2100)));
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildGeoLine() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: "${showingMonth.year}",
              style: TextStyle(fontSize: _fontSize, color: Colors.blueAccent)),
          TextSpan(
              text: "年",
              style: TextStyle(fontSize: _fontSize, color: Colors.grey)),
          TextSpan(
              text: ((showingMonth.month < 10) ? "  " : "") +
                  "${showingMonth.month}",
              style: TextStyle(fontSize: _fontSize, color: Colors.blueAccent)),
          TextSpan(
              text: "月",
              style: TextStyle(fontSize: _fontSize, color: Colors.grey)),
          TextSpan(
              text:
                  ((showingMonth.day < 10) ? "  " : "") + "${showingMonth.day}",
              style: TextStyle(fontSize: _fontSize, color: Colors.blueAccent)),
          TextSpan(
              text: "日",
              style: TextStyle(fontSize: _fontSize, color: Colors.grey)),
        ],
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildGanziLine() {
    DayInfo dayInfo = getLunarDayInfoFn(showingMonth);
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: "${dayInfo.gzYear}",
            style: TextStyle(fontSize: _fontSize, color: Colors.cyan)),
        TextSpan(
            text: "年",
            style: TextStyle(fontSize: _fontSize, color: Colors.grey)),
        TextSpan(
            text: "${dayInfo.gzMonth}",
            style: TextStyle(fontSize: _fontSize, color: Colors.cyan)),
        TextSpan(
            text: "月",
            style: TextStyle(fontSize: _fontSize, color: Colors.grey)),
        TextSpan(
            text: "${dayInfo.gzDay}",
            style: TextStyle(fontSize: _fontSize, color: Colors.cyan)),
        TextSpan(
            text: "日",
            style: TextStyle(fontSize: _fontSize, color: Colors.grey)),
      ]),
    );
  }
}
