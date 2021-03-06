import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../common_util.dart';

class ReplenishReportPage extends StatefulWidget {
  final String pageTitle;

  final DateInt initDate;
  final bool isDateChangeable;

  final String line1_title;
  final Future<int?> Function(DateTime date) line1_getNumOnDateChangeFn;

  final String line2_title;
  final Future<int> Function(DateTime date) line2_getNumOnDateChangeFn;

  final int step;

  final void Function(DateTime date, int? line1_newNum, int? line2_newNum)
      onCommitFn;

  ReplenishReportPage({
    required this.pageTitle,
    required this.initDate,
    required this.isDateChangeable,
    required this.line1_title,
    required this.line1_getNumOnDateChangeFn,
    required this.line2_title,
    required this.line2_getNumOnDateChangeFn,
    required this.step,
    required this.onCommitFn,
  }) {
    assert(null != initDate);
    assert(null != isDateChangeable);
    assert(null != line1_title);
    assert(null != line1_getNumOnDateChangeFn);
    assert(null != line2_title);
    assert(null != line2_getNumOnDateChangeFn);
    assert(null != step);
    assert(null != onCommitFn);
  }

  @override
  State<StatefulWidget> createState() {
    return ReplenishReportPageState();
  }
}

String _formatDate(int date) {
  final dateInt = DateInt.fromInt(date);
  return "${dateInt.year}-" +
      ((dateInt.month < 10) ? "0" : "") +
      "${dateInt.month}-" +
      ((dateInt.day < 10) ? "0" : "") +
      "${dateInt.day}";
}

class ReplenishReportPageState extends State<ReplenishReportPage>
    with TickerProviderStateMixin {
  DateTime? _date;
  ReplenishReportPageState() {}

  final double _width = MediaQueryData.fromWindow(window).size.width;
  final double _height = MediaQueryData.fromWindow(window).size.height;

  final _fmt = DateFormat('yyyy-MM-dd');

  TextEditingController _date_controller = TextEditingController();
  TextEditingController _line1_controller = TextEditingController();
  TextEditingController _line2_controller = TextEditingController();

  late AnimationController _line1_animationController;
  Animation? _line1_animation;

  late AnimationController _line2_animationController;
  Animation? _line2_animation;

  int _line1_showNum = 0; // ?????????????????????
  int? _line1_realNum = 0; // ?????????

  int? _line2_showNum = 0; // ?????????????????????
  int? _line2_realNum = 0; // ?????????

  @override
  initState() {
    super.initState();

    _date_controller.text = _formatDate(widget.initDate.data);

    _updateDate(widget.initDate.dt); // ?????????

    _line1_animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _line2_animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
//    _animation = IntTween(begin: _oldNum, end: _oldNum).animate(CurvedAnimation(
//        parent: _animationController, curve: Curves.fastLinearToSlowEaseIn));
  }

  @override
  void dispose() {
    _line1_animationController.dispose();
    _line2_animationController.dispose();

    _date_controller.dispose();
    _line1_controller.dispose();
    _line2_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    final children = [
//      SizedBox(height: _width / 5),
//      _buildDateInputBox(),
//      SizedBox(height: _width / 20),
////      _buildOldDoneInputBox(),
//      SizedBox(height: _width / 20),
////      _buildNewDoneInputBox(),
//      SizedBox(height: _width / 20),
//      Divider(),
//      SizedBox(height: _width / 20),
//      _buildButtonLine(context)
//    ];

    return SimpleDialog(
      title: Center(
          child: Text(widget.pageTitle,
              style:
                  TextStyle(color: Colors.deepOrange, fontSize: _width / 15))),
      children: [
        Divider(),
        SizedBox(height: _width / 40),
        _buildDateInputBox(),
        SizedBox(height: _width / 40),
        _buildDateShotcutButtonLine(),
        SizedBox(height: _width / 40),
        _buildLine1InputBox(),
        SizedBox(height: _width / 100),
        _buildLine2InputBox(),
        SizedBox(height: _width / 100),
        _buildStepButtonLine(),
        SizedBox(height: _width / 20),
        Divider(),
        _buildButtonLine(context),
      ],
    );
//    return Scrollbar(
//      child: SingleChildScrollView(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: children,
//        ),
//      ),
//    );

//    return Scaffold(
//      appBar: AppBar(title: Text("???????????????")),
//      body: Builder(builder: (BuildContext context2) {}),
//    );
  }

  Widget _buildDateShotcutButton(
    Color backgroundColor,
    String text,
    Color textColor,
    GestureTapCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _width / 7,
        height: _width / 7,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(width: 2.0, color: Colors.black38),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: FittedBox(
          child: Text(text,
              style: TextStyle(color: textColor, fontSize: _width / 5)),
        ),
      ),
    );
  }

  Widget _buildDateShotcutButtonLine() {
    // ??????????????? ?????? ??? ?????? ???????????????

    final today = DateTime.now();
    final yesterday = DateInt(today).prevousDay.dt;
    final preYesterday = DateInt(yesterday).prevousDay.dt;
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(width: _width / 20),
        _buildDateShotcutButton(
            isSameDay(preYesterday, _date)
                ? Colors.yellowAccent
                : Colors.grey[350]!,
            "??????",
            isSameDay(preYesterday, _date) ? Colors.red : Colors.indigoAccent,
            () {
          if (widget.isDateChangeable) {
            _updateDate(preYesterday);
          }
          return;
        }),
        SizedBox(width: _width / 20),
        _buildDateShotcutButton(
            isSameDay(yesterday, _date)
                ? Colors.yellowAccent
                : Colors.grey[350]!,
            "??????",
            isSameDay(yesterday, _date) ? Colors.red : Colors.indigoAccent, () {
          if (widget.isDateChangeable) {
            _updateDate(yesterday);
          }
          return;
        }),
        SizedBox(width: _width / 20),
        _buildDateShotcutButton(
            isSameDay(today, _date) ? Colors.yellowAccent : Colors.grey[350]!,
            "??????",
            isSameDay(today, _date) ? Colors.red : Colors.indigoAccent, () {
          if (widget.isDateChangeable) {
            _updateDate(today);
          }
          return;
        }),
        SizedBox(width: _width / 20),
      ],
    ));
  }

  Animation _createAnimation(AnimationController controller, int from, int to) {
    controller.reset();
    controller.forward();
    return IntTween(begin: from, end: to).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutExpo,
//      curve: Curves.easeOutCirc,
    ));
  }

  _updateDate(DateTime newDate) async {
    if (isSameDay(_date, newDate)) {
      return;
    }

    _date = newDate;

    String dateStr = _fmt.format(newDate);
    _date_controller.text = dateStr;

    _line1_showNum = 0; // ????????????0??????????????????????????????????????????????????????
    _line1_realNum = await widget.line1_getNumOnDateChangeFn(newDate);
    if (((null == _line1_realNum) || (0 == _line1_realNum))) {
      _line1_animation = null;
    } else {
      _line1_animation = _createAnimation(
          _line1_animationController, _line1_showNum, _line1_realNum!);
    }

    _line2_showNum = 0;
    _line2_realNum = await widget.line2_getNumOnDateChangeFn(newDate);
    if (((null == _line2_realNum) || (0 == _line2_realNum))) {
      _line2_animation = null;
    } else {
      _line2_animation = _createAnimation(
          _line2_animationController, _line2_showNum!, _line2_realNum!);
    }

    if (mounted) {
      setState(() {});
    }
    return;
  }

  Widget _buildLine2InputBox() {
    final inputBox = _buildTextInputBox(
        widget.line2_title, _line2_controller, true, _line2_onInputTextChanged);
    if (null == _line2_animation) {
      if ((null != _line2_realNum) && (0 != _line2_realNum)) {
        _line2_controller.text = "$_line2_realNum";
      } else {
        _line2_controller.text = "";
      }

      return inputBox;
    }

//    _line2_animationController.reset();
//    _line2_animationController.forward();

    Animation animation = _line2_animation!;
    return AnimatedBuilder(
      animation: _line2_animationController,
      builder: (BuildContext context, Widget? child) {
        _line2_showNum = animation.value;
        if (0 != _line2_showNum) {
          _line2_controller.text = "$_line2_showNum";
        } else {
          _line2_controller.text = "";
        }
        return inputBox;
      },
    );
  }

  _line2_onInputTextChanged(String value) {
    _line2_animationController.stop();

    if ("" == value) {
      _line2_showNum = _line2_realNum = 0;
    } else {
      try {
        // ?????????????????????????????????
        int num = int.parse(value);
        _line2_showNum = _line2_realNum = num;
      } catch (err) {
        _line2_animation = null;
        _line2_showNum = _line2_realNum = null;
      }
    }

    return;
  }

  void _line2_reduceStep() {
    if (null == _line2_realNum) {
      return;
    }

    if (widget.step < _line2_realNum!) {
      _line2_realNum = _line2_realNum! - widget.step;
    } else {
      _line2_realNum = 0;
    }

    _line2_animation = _createAnimation(
        _line2_animationController, _line2_showNum!, _line2_realNum!);

    setState(() {});

    return;
  }

  void _line2_addStep() {
    if (null == _line2_realNum) {
      return;
    }

    _line2_realNum = _line2_realNum! + widget.step;

    _line2_animation = _createAnimation(
        _line2_animationController, _line2_showNum!, _line2_realNum!);

    setState(() {});

    return;
  }

  Widget _buildLine1InputBox() {
    final inputBox =
        _buildTextInputBox(widget.line1_title, _line1_controller, false, null);
    if (null == _line1_animation) {
      _line1_controller.text =
          (null != _line1_realNum) ? "$_line1_realNum" : "";
      return inputBox;
    }

//    _line1_animationController.forward();
    Animation animation = _line1_animation!;
    return AnimatedBuilder(
      animation: _line1_animationController,
      builder: (BuildContext context, Widget? child) {
        _line1_showNum = animation.value;
        _line1_controller.text = animation.value.toString();
        return inputBox;
      },
    );
  }

  Widget _buildDateInputBox() {
    return FittedBox(
        child: Row(
      children: [
        SizedBox(width: _width / 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
//            SizedBox(height: _width / 18),
            Container(
                alignment: Alignment.centerRight,
                width: _width / 4,
                height: _width / 10,
                child: FittedBox(
                    child: Text(
                  "?????????",
                  style: TextStyle(
                      fontSize: _width / 20,
                      color: widget.isDateChangeable
                          ? Colors.black
                          : Colors.grey[500]),
                ))),
          ],
        ),
        GestureDetector(
          child: Container(
            width: _width * 55 / 100,
            height: _width * 12 / 100,
            color: widget.isDateChangeable ? Colors.grey[200] : Colors.grey[50],
            alignment: Alignment.centerLeft,
            child: Text(
              _fmt.format(_date!),
              style: TextStyle(
                  fontSize: _width / 20,
                  color: widget.isDateChangeable
                      ? Colors.black
                      : Colors.grey[500]),
            ),
          ),
          onTap: () async {
            if (true != widget.isDateChangeable) {
              return;
            }

            final today = DateTime.now();
            final newDate = await showDatePicker(
              context: context,
              initialDate: _date!,
              firstDate: DateTime(today.year - 10, 1, 1),
              lastDate: today,
              locale: Locale("zh", "CN"),
            );
            if ((null != newDate) && (!isSameDay(newDate, _date))) {
              await _updateDate(newDate);
            }
          },
        ),
        SizedBox(width: _width / 20),
      ],
    ));
  }

  Widget _buildTextInputBox(String title, TextEditingController controller,
      bool revisable, Function(String)? onInputChanged) {
    return FittedBox(
        child: Row(children: [
      SizedBox(width: _width / 20),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: _width / 60),
          Container(
              alignment: Alignment.topRight,
              width: _width / 4,
              height: _width / 8,
              child: FittedBox(
                  child: Text(title,
                      style: TextStyle(
                          fontSize: _width / 20,
                          color:
                              (true == revisable) ? null : Colors.grey[500])))),
        ],
      ),
      Container(
        width: _width * 55 / 100,
        height: _width / 6,
        alignment: Alignment.topRight,
        child: TextFormField(
          enabled: (true == revisable),
          autofocus: false,
          style: TextStyle(
              fontSize: _width / 20,
              color: (true == revisable) ? null : Colors.grey[500]),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: (true == revisable) ? Colors.grey[100] : Colors.grey[50],
            errorStyle: TextStyle(fontSize: _width / 30),
          ),
          controller: controller,
          // autovalidate: true,
          validator: validateNumFn,
          onChanged: onInputChanged,
        ),
      ),
      SizedBox(width: _width / 20),
    ]));
  }

  Widget _buildButton(
      IconData icon, String label, void Function() onPressedFn) {
    return Container(
      width: _width * 30 / 100,
      height: _width * 15 / 100,
      child: FittedBox(
        child: OutlinedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey[100])),
          icon: Icon(icon, size: _width / 15, color: Colors.lightBlueAccent),
          label: Text(label,
              style: TextStyle(
                  fontSize: _width / 15, color: Colors.lightBlueAccent)),
          onPressed: onPressedFn,
        ),
      ),
    );
  }

  Widget _buildStepButtonLine() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButton(Icons.remove, "${widget.step}", _line2_reduceStep),
        _buildButton(Icons.add, "${widget.step}", _line2_addStep),
      ],
    ));
  }

  Widget _buildButtonLine(BuildContext context2) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          child: FittedBox(
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[200])),
              child: Text(
                "??????",
                style: TextStyle(fontSize: _width / 20),
              ),
              onPressed: () {
                Navigator.of(context2).pop();
              },
            ),
          ),
        ),
        Container(
          child: FittedBox(
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[200])),
              child: Text("??????", style: TextStyle(fontSize: _width / 20)),
              onPressed: () async {
                if (null == _line2_realNum) {
                  return;
                }

                widget.onCommitFn(_date!, _line1_realNum, _line2_realNum);
                Navigator.of(context2).pop();
              },
            ),
          ),
        ),
      ],
    ));
  }

  void onNewDoneTextFieldChanged(String value) {
    print("xxx onNewDoneTextFieldChanged");
    try {
//      ?????????+??????-????????????????????????controller.text???????????????????????????????????????????????????????????????????????????????????????????????????
      _line2_showNum = int.parse(value);
    } catch (err) {
      _line2_showNum = null;
    }
  }
}
