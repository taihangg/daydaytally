import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rubber/rubber.dart';

import '../global_data.dart';
import 'month_view.dart';
import 'todo_view.dart';

class MonthTodoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MonthTodoPageState();
  }
}

class MonthTodoPageState extends State<MonthTodoPage>
    with SingleTickerProviderStateMixin {
  final double _width = MediaQueryData.fromWindow(window).size.width;
  final double _height = MediaQueryData.fromWindow(window).size.height;
  late MonthView _monthView;
  TodoView? _todoView;
  MonthTodoPageState() {
    _monthView = MonthView(
      onDateSelectedFn: (DateTime? selectedDate) {
        if (null != _todoView) {
          _todoView!.setSelectedDate(selectedDate);
        }
      },
      onMonthChangeFn: (DateTime showMonth) {},
      noteIconTypeFn: _noteIconTypeFn,
    );

    // _todoView = TodoView(
    //     width: _width,
    //     onStatusChangeFn: () {
    //       _monthView.Refresh();
    //     });
  }

  NoteIconType _noteIconTypeFn(DateTime date) {
    final fmt = DateFormat('yyyy-MM-dd');

    final dateStr = fmt.format(date);
    final dateTask = globalData.dateTaskDataMap[dateStr];
    if ((null == dateTask) || (dateTask.children.isEmpty)) {
      return NoteIconType.none;
    }

    if (dateTask.children.length == dateTask.finishedChildCount) {
      return NoteIconType.grey;
    }

    return NoteIconType.colorful;
  }

  late RubberAnimationController _controller;

  @override
  initState() {
    super.initState();

    _controller = RubberAnimationController(
      vsync: this,
      halfBoundValue: AnimationControllerValue(percentage: 0.5),
      duration: Duration(milliseconds: 200),
    );

    globalData.onLoadDataFinishedFn = () {
      _monthView.refresh();
      _todoView?.refresh();
    };
  }

  @override
  build(BuildContext context) {
    return _monthView; // ?????????month view, ??????todo view

//    return Scaffold(
////      appBar: AppBar(title: Text("Scrolling", style: TextStyle(color: Colors.cyan[900]))),
//      body: Container(
//        child: RubberBottomSheet(
////          scrollController: _scrollController,
//          lowerLayer: _monthView,
////          header: Container(
////            color: Colors.lightBlueAccent,
////            alignment: Alignment.center,
////            child: Text(
////              "????????????",
////              style: TextStyle(fontSize: screenWidth / 15),
////            ),
////          ),
//          headerHeight: screenWidth / 10,
////          upperLayer: _taskView,
//          animationController: _controller,
//        ),
//      ),
//    );

    List<Widget> _headerSliverBuilder(
        BuildContext context, bool innerBoxIsScrolled) {
      return [
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: SliverAppBar(
//            floating: true,
//            snap: true,
            pinned: true, // bottom?????????????????????????????????
            forceElevated: innerBoxIsScrolled,
            expandedHeight: _height * 70 / 100, // ?????????????????????flexibleSpace?????????
            flexibleSpace: FlexibleSpaceBar(background: _monthView),
//            bottom: PreferredSize(
//// 46.0???TabBar?????????????????????tabs.dart??????_kTabHeight????????????flutter???????????????????????????????????????????????????
////                preferredSize: Size(double.infinity, 46.0),
//              preferredSize: Size(double.infinity, screenWidth / 8),
//              child: TaskActionBar(screenWidth, screenHeight),
//            ),
          ),
        ),
      ];
    }

    var tabBarView = TabBarView(children: [
      SafeArea(
          top: false,
          bottom: false,
          child: Builder(builder: (BuildContext context) {
            return CustomScrollView(
                /*key: PageStorageKey<_Page>(page), */ slivers: [
                  SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context)),
                  SliverPadding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.0),
                          child: _todoView,
                        );
                      },
                      childCount: 1,
                    )),
                  ),
                ]);
          })),
    ]);

    return DefaultTabController(
      length: 1,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: _headerSliverBuilder,
          body: tabBarView,
        ),
      ),
    );
  }
}
