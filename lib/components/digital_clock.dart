import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mclock/common/app_colors.dart';
import 'package:mclock/components/clock_viewmodel.dart';

import '../injector.dart';

class DigitalClock extends StatelessWidget {
  final DateTime time;
  DigitalClock(this.time);

  final vm = inject<ClockViewmodel>();
  static final hour = DateFormat('hh');
  static final minute = DateFormat('mm');
  static final seconds = DateFormat('ss');
  static final aa = DateFormat('aa');

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      print('digital ${constraints.maxWidth}');
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
                    Text(':', style: TextStyle(fontFamily: 'digital2', fontSize: width * 0.3)),
                    _timeText(minute.format(time), digitalStyle),
                  ],
                ),
                SizedBox(height: width * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _timeText(seconds.format(time), tinyDigitalStyle),
                    _timeText(aa.format(time), tinyDigitalStyle),
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
