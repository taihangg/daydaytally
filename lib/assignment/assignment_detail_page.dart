import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:im_stepper/stepper.dart';
import '../common_util.dart';
import 'assignment_add_edit_page.dart';
import 'assignment_card.dart';
import 'assignment_data.dart';
import 'assignment_import_export.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class AssignmentDetailView extends StatefulWidget {
  static int gShowingPageIndex = 0;
  AssignmentDetailViewState? _viewState;
  void setShowingPage(int showingPageIndex) {
    gShowingPageIndex = showingPageIndex;
    if ((null != _viewState) && (_viewState!.mounted)) {
      _viewState!.setState(() {});
    }
    return;
  }

  @override
  State<StatefulWidget> createState() {
    _viewState = AssignmentDetailViewState();
    return _viewState!;
  }
}

class AssignmentDetailViewState extends State<AssignmentDetailView> {
  final double _width = MediaQueryData.fromWindow(window).size.width;
  final double _height = MediaQueryData.fromWindow(window).size.height;
  late double _bigBoxWidth;
  late double _smallBoxWidth;
  late double _smallBoxHeight;

  AssignmentDetailViewState() {
    _bigBoxWidth = _width * 9 / 10;
    _smallBoxWidth = _bigBoxWidth / 2;
    _smallBoxHeight = _width * 8 / 100;

    return;
  }

  final _fmt = DateFormat('yyyy-MM-dd');

  List<AssignmentData>? _assignmentDataList;
  var _eventBusFn;

  @override
  initState() {
    super.initState();

    _fetchData();

    _eventBusFn = AssignmentData.addListener(() {
      _fetchData();
      return;
    });

    return;
  }

  @override
  void dispose() {
    super.dispose();
    _eventBusFn.cancel();
    return;
  }

  _fetchData() async {
    _assignmentDataList = await AssignmentData.getAllAssignment();
//    await Future.delayed(Duration(seconds: 100));
    if (mounted) {
      setState(() {});
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (null == _assignmentDataList) {
      child = buildLoadingView();
    } else {
      if (_assignmentDataList!.isEmpty) {
        child = _buildEmptyPrompt();
      } else {
        // child = _buildAssignmentCards();
        // child = ListView.separated(
        //   itemBuilder: (BuildContext context, int index) {
        //     if (index < _assignmentDataList.length) {
        //       return AssignmentCard(_assignmentDataList[index], refresh: () {
        //         setState(() {});
        //       });
        //     }
        //     return null;
        //   },
        //   separatorBuilder: (BuildContext context, int index) {
        //     return Divider();
        //   },
        //   itemCount:_assignmentDataList.length ,
        // );

        if (_assignmentDataList!.length <=
            AssignmentDetailView.gShowingPageIndex) {
          AssignmentDetailView.gShowingPageIndex =
              _assignmentDataList!.length - 1;
        }

        final PageController pageController = PageController(
            viewportFraction: 1.0,
            initialPage: AssignmentDetailView.gShowingPageIndex);

        final PageView pageView = PageView.builder(
          scrollDirection: Axis.vertical,
          // scrollDirection: Axis.horizontal,
          controller: pageController, // 从1开始
          onPageChanged: (int index) {
            AssignmentDetailView.gShowingPageIndex = index;
            setState(() {});
            return;
          },
          itemBuilder: (BuildContext context, int index) {
            // if (index < _assignmentDataList!.length) {
            return AssignmentCard(_assignmentDataList![index], onDeleteFn: () {
              setState(() {});
            });
            // }
          },
          itemCount: _assignmentDataList!.length,
        );

        // var indicator = SmoothPageIndicator(
        //   controller: pageController,
        //   axisDirection: Axis.vertical,
        //   count: _assignmentDataList!.length,
        //   onDotClicked: (int index) {
        //     pageController.animateToPage(index,
        //         duration: Duration(milliseconds: 500), curve: Curves.easeOut);
        //     return;
        //   },
        //   // effect: WormEffect(),
        // );
        // print("_assignmentDataList!.length=${_assignmentDataList!.length}");
        var indicator = RotatedBox(
          quarterTurns: 1,
          child: PageViewDotIndicator(
            currentItem: AssignmentDetailView.gShowingPageIndex,
            count: _assignmentDataList!.length,
            size: Size(_width * 5 / 100, _width * 5 / 100),
            unselectedColor: Colors.black26,
            selectedColor: Colors.blue,
            duration: Duration(milliseconds: 200),
          ),
        );
        // var indicator = NumberStepper(
        //   numbers: List.generate(_assignmentDataList!.length, (index) {
        //     return index + 1;
        //   }),
        //   stepColor: Colors.yellow,
        //   activeStep: AssignmentDetailView.gShowingPageIndex,
        //   activeStepBorderColor: Colors.red,
        //   direction: Axis.vertical,
        //   enableNextPreviousButtons: false,
        //   enableStepTapping: false,
        //   // previousButtonIcon: Icon(Icons.arrow_upward),
        //   // nextButtonIcon: Icon(Icons.arrow_downward),
        //   activeStepColor: Colors.cyan,
        //   stepReachedAnimationEffect: Curves.easeInOut,
        //   stepReachedAnimationDuration: Duration(milliseconds: 500),
        //   stepRadius: 15.0,
        //   onStepReached: (int index) {
        //     AssignmentDetailView.gShowingPageIndex = index;
        //     pageController.animateToPage(index,
        //         duration: Duration(milliseconds: 500), curve: Curves.easeOut);
        //     return;
        //   },
        //   // steppingEnabled: false,
        //   // scrollingDisabled: true,
        // );

        double width = _width * 12 / 100;

        BoxDecoration? decoration = BoxDecoration(
            border: Border.all(color: Colors.cyan, width: 2.5),
            borderRadius: BorderRadius.circular((30.0)));

        BoxDecoration? decorationRed =
            BoxDecoration(border: Border.all(color: Colors.red, width: 1.5));
        decorationRed = null;

        final popMenuButton = Container(
          width: width,
          height: width,
          // alignment: Alignment(-1, -1),
          decoration: decoration,
          child: Stack(
            children: [
              Container(
                  width: width,
                  height: width,
                  child: Icon(Icons.list,
                      color: Colors.cyan, size: _width * 10 / 100)),
              PopupMenuButton<String>(
                icon: Icon(Icons.list,
                    color: Colors.transparent, size: _width * 10 / 100),
                itemBuilder: (context) {
                  return <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: '备份/导入',
                      child: _buildImportExportButton(),
                    ),
                    PopupMenuItem<String>(
                      value: '新建课程',
                      child: _buildAddNewAssignmentButton(),
                    ),
                  ];
                },
              ),
            ],
          ),
        );

        final toTopButton = GestureDetector(
          child: Container(
            width: width,
            height: width,
            decoration: decoration,
            child: Icon(Icons.vertical_align_top,
                color: Colors.cyan, size: _width * 10 / 100),
          ),
          onTap: () {
            pageController.animateToPage(0,
                duration: Duration(milliseconds: 500), curve: Curves.easeOut);
            return;
          },
        );

        child = Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(width: _width * 95 / 100, child: pageView),
                // Container(
                //     width: _width * 8 / 100,
                //     decoration: BoxDecoration(
                //       color: Colors.grey[200],
                //       border: Border(
                //           bottom: BorderSide(width: 0.1, color: Colors.black)),
                //     ),
                //     child: indicator),
                // SizedBox(width: _width * 2 / 100),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: _width * 4 / 100,
                      width: _width * 4 / 100,
                      // decoration: decorationRed,
                    ),
                    Row(children: [
                      Container(
                        decoration: decorationRed,
                        child: popMenuButton,
                      ),
                      Container(
                        height: _width * 4 / 100,
                        width: _width * 4 / 100,
                        // decoration: decorationRed,
                      ),
                    ]),
                    // SizedBox(height: _width * 4 / 100),
                    Container(
                      height: _width * 4 / 100,
                      width: _width * 4 / 100,
                      // decoration: decorationRed,
                    ),
                    Row(children: [
                      Container(decoration: decorationRed, child: toTopButton),
                      SizedBox(width: _width * 4 / 100),
                    ]),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        // height: _width,
                        width: _width * 6 / 100,
                        // decoration: BoxDecoration(
                        //     border: Border.all(width: 1.5, color: Colors.red)),
                        child: indicator),
                  ],
                ),
              ],
            ),
          ],
        );
      }
    }

    return Scaffold(
      body: Container(
//      decoration: BoxDecoration(color: Colors.cyan[100]),
          child: child),
    );

    return Scaffold(
      body: Container(
//      decoration: BoxDecoration(color: Colors.cyan[100]),
          child: Scrollbar(child: child)),
    );

    return Scaffold(
      body: Container(
//      decoration: BoxDecoration(color: Colors.cyan[100]),
          child: Scrollbar(child: SingleChildScrollView(child: child))),
    );
  }

  Widget _buildEmptyPrompt() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: _width * 2 / 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildImportExportButton(),
            _buildAddNewAssignmentButton()
          ],
        ),
        SizedBox(height: _width * 2 / 5),
        Center(
          child: Text(
            "没有功课，\n请先添加！",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: _width / 10),
          ),
        ),
        SizedBox(height: _width / 20),
      ],
    );
  }

  Widget _buildAssignmentCards() {
    bool testShowOne = false;
//    testShowOne = true; // for test

    Widget child;
    if (testShowOne) {
      child = AssignmentCard(_assignmentDataList!.first, onDeleteFn: () {
        setState(() {});
      });
    } else {
      child = Column(
          children: _assignmentDataList!.map((a) {
        return AssignmentCard(a, onDeleteFn: () {
          setState(() {});
        });
      }).toList());
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: _width * 2 / 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildImportExportButton(),
            _buildAddNewAssignmentButton()
          ],
        ),
        SizedBox(height: _width * 1 / 100),
        child,
        SizedBox(height: _width / 100),
      ],
    );
  }

  _buildAddNewAssignmentButton() {
    return _buildButton1(
      "新增功课",
      Icons.add_circle_outline,
      () async {
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return AssignmentAddEditPage.addNew(
              onCommitFn: (AssignmentData value) async {
            final msg = await value.apply();
            return msg;
          });
        }));
        // Navigator.of(context).pop(); //退出popmenu
        setState(() {}); // 返回后需要刷新一下
        return;
      },
    );
  }

  _buildImportExportButton() {
    return _buildButton1(
      "备份/导入",
      Icons.import_export,
      () async {
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ImportExport();
        }));
        // Navigator.of(context).pop(); //退出popmenu
        return;
      },
    );
  }

  Widget _buildButton1(
      String title, IconData icon, void Function() onPressedFn) {
    return Container(
        width: _smallBoxWidth,
        height: _width / 10,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // color: Colors.cyanAccent,
          border: Border.all(width: 1.0, color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: FittedBox(
            child: TextButton.icon(
//          color: Colors.cyanAccent,
          icon: Icon(icon, size: _width / 10, color: Colors.cyan),
          label: Text(title,
              style: TextStyle(fontSize: _width / 15, color: Colors.cyan)),
          onPressed: onPressedFn,
        )));
  }
}
