import 'dart:async';
import 'dart:ui';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../common_util.dart';
import '../plugins/sxwnl/sxwnl_Lunar.dart';
import 'month_day.dart';
import 'month_view_action_bar.dart';
import 'user_defined_festival_manager.dart';

Future<void> showLunarDatePickerDialog({
  required BuildContext context,
  required Function(DateTime? dt) fn,
  DateTime? initialDate,
}) async {
  final _width = MediaQueryData.fromWindow(window).size.width;
  DateTime? _selectedDt = initialDate ?? DateTime.now();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Material(
        //创建透明层
        type: MaterialType.transparency, //透明类型
        child: Container(
          decoration: ShapeDecoration(
//                color: Color(0xffffffff),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
          ),
          child: SimpleDialog(
            children: <Widget>[
              MonthView(
                onDateSelectedFn: (DateTime? selectedDate) {
                  _selectedDt = selectedDate;
                  return;
                },
                onMonthChangeFn: (DateTime showMonth) {
                  return;
                },
                noteIconTypeFn: (DateTime date) {
                  return NoteIconType.none;
                },
              ),
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                        child: Container(
                            child: Text("返回",
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontSize: _width / 15,
                                ))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    Container(
                        height: _width * 2 / 15,
                        child: VerticalDivider(color: Colors.grey)),
                    TextButton(
                      child: Container(
                          child: Text("确定",
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: _width / 15,
                              ))),
                      onPressed: () {
                        fn(_selectedDt);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

enum NoteIconType {
  none,
  grey,
  colorful,
}

class MonthView extends StatefulWidget {
  final Function(DateTime? selectedDate) onDateSelectedFn;
  final Function(DateTime showMonth) onMonthChangeFn;
  final NoteIconType Function(DateTime date) noteIconTypeFn;

  // 有读文件操作，定义成static，只读一次，节约点儿
  static UserDefinedFestivalManager? _userDefinedFestivalMgr;

  MonthView({
    required this.onDateSelectedFn,
    required this.onMonthChangeFn,
    required this.noteIconTypeFn,
    DateTime? initDate,
  }) {
    _setShowDate(initDate ?? DateTime.now());
    _selectedDate = initDate;
    if (null == _userDefinedFestivalMgr) {
      _userDefinedFestivalMgr = UserDefinedFestivalManager(onLoadedFn: refresh);
    }
    return;
  }

  late DateTime _showingDate;
  late DayInfo _showingDayInfo;
  late _MonthViewDateInfo _monthViewDate;
  DateTime? _selectedDate;
  DayInfo? _selectedDayInfo;

  final _monthFmt = DateFormat('yyyy-MM');
  Map<String, LunarMonth> _lunars = {};

  MonthViewState? _monthViewState;

  @override
  State<StatefulWidget> createState() {
    _monthViewState = MonthViewState();
    return _monthViewState!;
  }

  _setShowDate(DateTime date) {
    this._showingDate = date;
    _monthViewDate = _MonthViewDateInfo(_showingDate, 1);
    return;
  }

  setShowMonth(DateTime month) {
    _setShowDate(month);
    refresh();
    return;
  }

  refresh() {
    if ((null != _monthViewState) && (_monthViewState!.mounted)) {
      _monthViewState!.setState(() {});
    }
    return;
  }
}

class MonthViewState extends State<MonthView> {
  final double _width = MediaQueryData.fromWindow(window).size.width;

  // late Function(DateTime, bool) _onDaySelectedFn;

  EventBus _eventBus = EventBus();
  late StreamSubscription subscription;

  MonthViewState() {}

  @override
  initState() {
    super.initState();

    subscription = _eventBus.on<DateTime>().listen((DateTime newDt) {
      widget._setShowDate(newDt);
      setState(() {});
    });
  }

  @override
  dispose() {
    _eventBus.destroy();

    super.dispose();
  }

  LunarMonth _getLunarMonth(DateTime month) {
    final monthStr = widget._monthFmt.format(month);

    LunarMonth? lunarMonth = widget._lunars[monthStr];
    if (null == lunarMonth) {
      lunarMonth = LunarMonth(month);
      widget._lunars[monthStr] = lunarMonth;
    }
    return lunarMonth;
  }

  DayInfo _getLunarDayInfo(DateTime date) {
    final monthStr = widget._monthFmt.format(date);

    LunarMonth? lunarMonth = widget._lunars[monthStr];
    if (null == lunarMonth) {
      lunarMonth = LunarMonth(date);
      widget._lunars[monthStr] = lunarMonth;
    }

    return lunarMonth.days[date.day - 1];
  }

  List<TitleDay> _weekdayList(int firstWeekday) {
    List<TitleDay> _list = List.generate(7, (int index) {
      return TitleDay(((index + firstWeekday - 1) % 7) + 1, this._width);
    });
    return _list;
  }

  List<DayBox> _generateDays(_MonthInfo monthInfo, LunarMonth lunarMonth,
      bool baskgroundGrey, DateTime today) {
    List<DayBox> days = [];

    for (int index = 0, day = monthInfo.firstShowDay;
        index < monthInfo.showCount;
        index++, day++) {
      final date = DateTime(monthInfo.year, monthInfo.month, day);
      final selected = isSameDay(date, widget._selectedDate);
      final isToday = isSameDay(date, today);
      DayInfo dayInfo = lunarMonth.days[day - 1];

      assert((lunarMonth.monthDaysCount == monthInfo.daysCount) &&
          (lunarMonth.gregorianMonth == monthInfo.month) &&
          (lunarMonth.gregorianYear == monthInfo.year));

      final NoteIconType noteIconType = widget.noteIconTypeFn(date);

      days.add(DayBox(
        MonthView._userDefinedFestivalMgr!,
        dayInfo, date,
        geoMonthDaysCount: monthInfo.daysCount,

        baskgroundGrey: baskgroundGrey,
        isToday: isToday,
        selected: selected,
        onSelectedFn: _onDaySelectedFn,

        // showNoteIcon: (noteIconType != NoteIconType.none),
        // noteActive: (noteIconType == NoteIconType.colorful),
      ));
    }

    return days;
  }

  _onDaySelectedFn(DateTime date, DayInfo dayInfo, bool selected) {
    if (selected) {
      widget._selectedDate = date;
      widget._selectedDayInfo = dayInfo;
    } else {
      widget._selectedDate = null;
      widget._selectedDayInfo = null;
    }

    widget.onDateSelectedFn(widget._selectedDate);
    setState(() {});
  }

  List<DayBox> _dayList(final _MonthViewDateInfo _monthViewDate) {
    List<DayBox> _list = [];

    final today = DateTime.now();
    _MonthInfo monthInfo;
    LunarMonth lunarMonth;
    List<DayBox> days;

    // previous month
    monthInfo = _monthViewDate.data[0];
    lunarMonth = _getLunarMonth(DateTime(monthInfo.year, monthInfo.month));
    days = _generateDays(monthInfo, lunarMonth, true, today);
    _list.addAll(days);

    // current month
    monthInfo = _monthViewDate.data[1];
    lunarMonth = _getLunarMonth(DateTime(monthInfo.year, monthInfo.month));
    days = _generateDays(monthInfo, lunarMonth, false, today);
    _list.addAll(days);

    // next month
    monthInfo = _monthViewDate.data[2];
    lunarMonth = _getLunarMonth(DateTime(monthInfo.year, monthInfo.month));
    days = _generateDays(monthInfo, lunarMonth, true, today);
    _list.addAll(days);

    assert(
        (28 == _list.length) || (35 == _list.length) || (42 == _list.length));
    return _list;
  }

  _styleRow(List<Widget> list) {
    return Container(
        decoration: BoxDecoration(
            //color: Colors.lightBlueAccent,
            //border: Border.all(width: 1.0, color: Colors.black38),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: list));
  }

  List<Widget> _martrix(
      final List<Widget> _weekdays, final List<Widget> _dayList) {
    final table = <Widget>[];

    // 星期行增加以下上下的间隔
    table.add(
      Container(
        margin: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 2.0),
        child: _styleRow(_weekdays),
      ),
    );

    for (var i = 0; i < _dayList.length; i += 7) {
      table.add(_styleRow(_dayList.sublist(i, i + 7)));
    }
    return table;
  }

  @override
  Widget build(BuildContext context) {
    final List<TitleDay> _weekdays = _weekdayList(1);
    final List<DayBox> _days = _dayList(widget._monthViewDate);
    final List<Widget> _table = _martrix(_weekdays, _days);

    return SingleChildScrollView(
        child: Container(
//            margin: EdgeInsets.all(screenWidth / 50),
//            padding: EdgeInsets.all(screenWidth / 50),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(width: 1.0, color: Colors.black38),
//        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MonthViewActionBar(
            width: _width,
            showingMonth: widget._selectedDate ?? widget._showingDate,
            getLunarDayInfoFn: _getLunarDayInfo,
            onDateChangeFn: (DateTime date) {
              widget._setShowDate(date);
              widget.onMonthChangeFn(date);

              if (null != widget._selectedDate) {
                widget.onDateSelectedFn(date);
                widget._selectedDate = date;
              }
              setState(() {});
              return;
            },
            getFestivalTextFn: () {
              return MonthView._userDefinedFestivalMgr!.text;
            },
            onSaveFn: (String? newText) {
              String log = MonthView._userDefinedFestivalMgr!.setText(newText);
              setState(() {}); // 更新自定义节日后刷新一下，否则更新的内容不能立即看到。
              return log;
            },
          ),
          Container(
            width: _width * 96 / 100,
//            height: screenWidth  * 8/ 9,
            margin: EdgeInsets.all(_width * 1 / 100),
            padding: EdgeInsets.all(_width * 1 / 100),
            decoration: BoxDecoration(
//              color: Colors.red,
              border: Border.all(width: 1.0, color: Colors.black38),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: FittedBox(
              alignment: Alignment.topCenter,
              child: Column(mainAxisSize: MainAxisSize.min, children: _table),
            ),
          ),
        ],
      ),
    ));
  }
}

class _MonthInfo {
  int year = 0;
  int month = 0;
  int daysCount = 0;
  int firstShowDay = 0;
  int lastShowDay = 0;
  int showCount = 0;
}

class _MonthViewDateInfo {
  // 分别是上个月，当前月，下个月的数据
  final List<_MonthInfo> data = [_MonthInfo(), _MonthInfo(), _MonthInfo()];
  final DateTime dt;
  final int showFirstWeekday; // 从周几开始显示
  late int calendarShowDaysCount; // 月历中需要显示的天数

  _MonthViewDateInfo(this.dt, this.showFirstWeekday) {
    assert(1 == showFirstWeekday); //目前只处理了从周一开始显示

    calendarShowDaysCount = 0;

    var thisMonthFirstWeedday = DateTime(dt.year, dt.month, 1).weekday;
    if (showFirstWeekday != thisMonthFirstWeedday) {
      var lastMonthInfo = data[0];
      DateTime lastMonth = DateTime(dt.year, dt.month, 0);
      lastMonthInfo.year = lastMonth.year;
      lastMonthInfo.month = lastMonth.month;
      lastMonthInfo.daysCount = lastMonth.day;

      if (1 == showFirstWeekday) {
        lastMonthInfo.showCount = thisMonthFirstWeedday - 1;
        lastMonthInfo.firstShowDay =
            lastMonthInfo.daysCount - lastMonthInfo.showCount + 1;
        lastMonthInfo.lastShowDay = lastMonth.day;
      }

      calendarShowDaysCount += lastMonthInfo.showCount;
    }

    DateTime thisMonth = DateTime(dt.year, dt.month + 1, 0);
    var thisMonthInfo = data[1];

    thisMonthInfo.year = thisMonth.year;
    thisMonthInfo.month = thisMonth.month;
    thisMonthInfo.daysCount = thisMonth.day;
    thisMonthInfo.firstShowDay = 1;
    thisMonthInfo.lastShowDay = thisMonth.day;
    thisMonthInfo.showCount = thisMonth.day;
    calendarShowDaysCount += thisMonthInfo.showCount;

    var nextMonthFirstWeekday = DateTime(dt.year, dt.month + 1, 1).weekday;
    if (showFirstWeekday != nextMonthFirstWeekday) {
      var lastMonthInfo = data[2];

      var nextMonth = DateTime(dt.year, dt.month + 2, 0);
      lastMonthInfo.year = nextMonth.year;
      lastMonthInfo.month = nextMonth.month;
      lastMonthInfo.daysCount = nextMonth.day;

      if (1 == showFirstWeekday) {
        lastMonthInfo.firstShowDay = 1;
        lastMonthInfo.showCount = 7 - nextMonthFirstWeekday + 1;
        lastMonthInfo.lastShowDay = lastMonthInfo.showCount;
      }
      calendarShowDaysCount += lastMonthInfo.showCount;
    }
  }
}
