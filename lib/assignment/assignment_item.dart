import 'dart:ui';

import 'package:flutter/material.dart';

import '../common_util.dart';
import 'assignment_data.dart';

class _AssignmentBarUtil {
  final double _width = MediaQueryData.fromWindow(window).size.width;
  final double _height = MediaQueryData.fromWindow(window).size.height;
  late double _defaultBoxWidth;
  late double _defaultBoxHeight;
  late double _buttonWidth;
  late double _fontSize;
  _AssignmentBarUtil() {
    _defaultBoxWidth = _width * 15 / 100;
    _defaultBoxHeight = _width * 15 / 100;
    _buttonWidth = _width * 17 / 100;
    _fontSize = _width / 10;
  }

  Widget buildRadiusBox(Widget child, Color? color, [double? width]) {
    width = width ?? _defaultBoxWidth;
    return Container(
//      alignment: Alignment.center,
      width: width,
      height: _defaultBoxHeight,
      child: Container(
        width: width,
        height: _defaultBoxHeight,
        margin: EdgeInsets.all(_width * 0.5 / 100),
        decoration: BoxDecoration(
          color: color,
//          border: Border.all(width: 1.0, color: Colors.black38),
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
        ),
        child: FittedBox(fit: BoxFit.fill, child: child),
      ),
    );
  }

  Widget buildTitleStringBox(String msg,
      {Color? textColor, Color? backgroundColor, double? width}) {
    return buildRadiusBox(
        Text(msg, style: TextStyle(fontSize: _fontSize, color: textColor)),
        backgroundColor,
        width);
  }

  String dateString(DateInt dateInt) {
    return "${dateInt.month}.${dateInt.day}";
  }

  Widget buildBox(Widget child, bool hasLeftBar,
      [Color? color, double? width]) {
    width = width ?? _defaultBoxWidth;
    return Container(
      width: width,
      height: _defaultBoxHeight,
      decoration: BoxDecoration(
          color: color,
//        border: Border.all(width: 0.3, color: Colors.black38),
          borderRadius: BorderRadius.circular((10.0)),
          border: hasLeftBar
              ? Border.lerp(
                  null,
                  Border(left: BorderSide(width: 0.8, color: Colors.black38)),
                  1.0,
                )
              : null),
      // clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      child: FittedBox(child: child),
    );
  }

  Widget buildStringBox(
    String msg, {
    Color? textColor,
    bool hasLeftBar = false,
    Color? backgroundColor,
    double? width,
  }) {
    return buildBox(
      Text(msg,
//            textAlign: TextAlign.center,
          style: TextStyle(fontSize: _fontSize, color: textColor)),
      hasLeftBar,
      backgroundColor,
      width,
    );
  }

//  Widget buildNumBox(int num,
//      {Color textColor, Color backgroundColor, double width}) {
//    return buildBox(
//        Text(numString(num, true),
//            style: TextStyle(fontSize: fontSize, color: textColor)),
//        backgroundColor,
//        width);
//  }
}

class AssignmentItem extends StatefulWidget {
  final AssignmentData a;
  final Color color;

  final Function(int) onTapLastDataFn;

  AssignmentItem(this.a, this.color, this.onTapLastDataFn)
      : super(key: ValueKey(a.id));

  @override
  State<StatefulWidget> createState() {
    return _AssignmentItemState();
  }

  static Widget title() {
    _AssignmentBarUtil util = _AssignmentBarUtil();
    DateInt todayInt = DateInt(DateTime.now());
    return Card(
//        color: Color(0xffFFFACD),
//        elevation: 10.0,
//        semanticContainer: false,
        child: Column(
      children: <Widget>[
        FittedBox(
            child: Container(
                alignment: Alignment.center,
                height: util._defaultBoxHeight * 1.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    util.buildTitleStringBox("课程",
                        backgroundColor: Color(0xFF00F5FF),
                        width: util._defaultBoxWidth * 2),
                    util.buildTitleStringBox(
                      util.dateString(todayInt.prevousDay.prevousDay),
                      backgroundColor: Colors.grey[350],
                    ),
                    util.buildTitleStringBox(
                      util.dateString(todayInt.prevousDay),
                      backgroundColor: Color(0xFF00F5FF),
                    ),
                    util.buildTitleStringBox(
                      util.dateString(todayInt),
                      backgroundColor: Colors.grey[350],
                    ),
                    util.buildTitleStringBox(
                      "修改报数",
                      backgroundColor: Color(0xFF00F5FF),
                      width: util._buttonWidth * 2,
                    ),
                  ],
                ))),
//        Divider(),
      ],
    ));
  }
}

class _AssignmentItemState extends State<AssignmentItem>
    with SingleTickerProviderStateMixin {
  _AssignmentBarUtil _util = _AssignmentBarUtil();
  late AnimationController _animationController;

  @override
  initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _animationController.forward(); // 运行一下，否则会停在起始值
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<int> _showNumList = [0, 0, 0];
  @override
  Widget build(BuildContext context) {
//    List<int> lastLineData = widget.a.lastLineData;

    final futureBuilder = FutureBuilder<List<int>>(
      initialData: _showNumList, //lastLineData,
      future: widget.a.getLatestLineData(3),
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if ((ConnectionState.done == snapshot.connectionState) &&
            (snapshot.hasError)) {
          return Center(
              child: Text(
            '错误: ${snapshot.error}',
            style: TextStyle(fontSize: _util._fontSize),
          ));
        }

        return _buildDataRow(snapshot.data!);
      },
    );

    return Card(
        key: ValueKey(widget.a.id),
        elevation: 6.0,
        child: Container(
            height: _util._defaultBoxHeight * 1.2,
            alignment: Alignment.center,
            child: FittedBox(child: futureBuilder)));
  }

  Widget _buildDataRow(List<int> newData) {
//    assert(null != showNumList);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _util.buildStringBox(
          widget.a.name,
          textColor: Color(0xFFFF8C00), //widget.color,
          hasLeftBar: false,
          width: _util._defaultBoxWidth * 2,
        ),
        // VerticalDivider(width: 1.0, color: Colors.grey),
        Container(
          height: _util._defaultBoxWidth,
          child: VerticalDivider(width: 1.0, color: Colors.grey),
        ),
        _buildAnimatedNumBox(0, newData[0]),
        Container(
          height: _util._defaultBoxWidth,
          child: VerticalDivider(width: 1.0, color: Colors.grey),
        ),
        _buildAnimatedNumBox(1, newData[1]),
        GestureDetector(
          child: _buildAnimatedNumBox(
              2, newData[2], Colors.lightGreenAccent.shade100),
          onTap: () {
            widget.onTapLastDataFn(widget.a.sortSequence);
            return;
          },
        ),
        _buildReduceButtonBox(widget.a),
        _buildAddButtonBox(widget.a),
      ],
    );
  }

  Widget _buildAnimatedNumBox(int showNumIndex, int newNum,
      [Color? backgroundColor]) {
//    print("showNumList[$showNumIndex]=${_showNumList[showNumIndex]}");
    if (_showNumList[showNumIndex] == newNum) {
      return _util.buildStringBox(numString(newNum, true),
          textColor: (0 == _showNumList[showNumIndex]) ? Colors.red : null,
          backgroundColor: backgroundColor);
    } else {
      Animation animation =
          IntTween(begin: _showNumList[showNumIndex], end: newNum).animate(
              CurvedAnimation(
                  parent: _animationController, curve: Curves.easeInOutExpo));

      return AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            _showNumList[showNumIndex] = animation.value;
            return _util.buildStringBox(numString(animation.value, true),
                textColor:
                    (0 == _showNumList[showNumIndex]) ? Colors.red : null,
                backgroundColor: backgroundColor);
          });
    }
  }

  Widget _buildButtonBox(IconData icon, String lable, VoidCallback onPressed,
      [Color? color]) {
    return _util.buildRadiusBox(
        TextButton.icon(
//            color: Colors.red,
            onPressed: onPressed,
            icon: Icon(icon, color: Colors.red, size: _util._fontSize),
            label: Text(lable,
                style: TextStyle(
                    color: Colors.red, fontSize: _util._fontSize * 1.2))),
        color,
        _util._buttonWidth);
  }

  Widget _buildReduceButtonBox(AssignmentData a) {
    return _buildButtonBox(
      Icons.remove,
      "${a.step}",
      () async {
        bool b = await a.todayDoneReduceStep();
        if (b) {
          _animationController.reset();
          _animationController.forward();
          setState(() {});
        }
      },
      Colors.tealAccent,
    );
  }

  Widget _buildAddButtonBox(AssignmentData a) {
    return _buildButtonBox(
      Icons.add,
      "${a.step}",
      () async {
        await a.todayDoneAddStep();
        _animationController.reset();
        _animationController.forward();
        setState(() {});
      },
      Colors.amberAccent,
    );
  }
}
