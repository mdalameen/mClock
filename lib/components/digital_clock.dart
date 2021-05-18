import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mclock/common/app_colors.dart';
import 'package:mclock/common/clock_viewmodel.dart';

import '../injector.dart';

class DigitalClock extends StatelessWidget {
  final DateTime time;
  final bool animate;
  DigitalClock(this.time, this.animate);

  final vm = inject<ClockViewmodel>();
  static final hour = DateFormat('hh');
  static final minute = DateFormat('mm');
  static final seconds = DateFormat('ss');
  static final aa = DateFormat('aa');

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      double width = constraints.maxWidth;
      final digitalStyle = TextStyle(fontFamily: 'digital', fontSize: width * 0.3);
      final tinyDigitalStyle = TextStyle(fontFamily: 'digital', fontSize: width * 0.15);
      return Center(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.clockOuter,
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.grey.withAlpha(50), blurRadius: 5),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.clockInner,
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.grey.withAlpha(50), blurRadius: 5),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _timeText(hour.format(time), digitalStyle),
                    Text(':',
                        style: TextStyle(
                          fontFamily: 'digital2',
                          fontSize: width * 0.3,
                          color: animate ? (time.millisecond < 500 ? Colors.black : Colors.grey.shade300) : Colors.black,
                        )),
                    _timeText(minute.format(time), digitalStyle),
                  ],
                ),
                SizedBox(height: width * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _timeText(seconds.format(time), tinyDigitalStyle),
                    Opacity(
                      opacity: vm.isDisplayAMPm ? 1 : 0,
                      child: _timeText(aa.format(time), tinyDigitalStyle),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _timeText(String text, TextStyle style) {
    return Stack(
      children: [
        Text('88', style: style.copyWith(color: Colors.grey.shade300)),
        Text(text, style: style),
      ],
    );
  }
}
