import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mclock/components/clock_viewmodel.dart';
import 'package:mclock/injector.dart';

class AnalogClock extends StatelessWidget {
  final int offset;
  AnalogClock(this.offset);

  final vm = inject<ClockViewmodel>();
  static final dateFomat = DateFormat.Hms();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (_, d) {
        var now = DateTime.now();
        now = now.subtract(now.timeZoneOffset);
        now = now.add(Duration(milliseconds: offset));
        return Text(dateFomat.format(now));
      },
      stream: vm.stream,
    );
  }
}
