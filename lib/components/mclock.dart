import 'package:flutter/material.dart';
import 'package:mclock/common/clock_viewmodel.dart';
import 'package:mclock/components/analog_clock.dart';
import 'package:mclock/components/digital_clock.dart';

import '../injector.dart';

class Mclock extends StatelessWidget {
  final vm = inject<ClockViewmodel>();

  final int offset;
  Mclock(this.offset);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (_, d) {
        var now = DateTime.now();
        now = now.subtract(now.timeZoneOffset);
        now = now.add(Duration(milliseconds: offset));
        return vm.isAnalog ? AnalogClock(now, true) : DigitalClock(now, true);
      },
      stream: vm.stream,
    );
  }
}

class MDisplayClock extends StatelessWidget {
  final vm = inject<ClockViewmodel>();
  final DateTime time;
  MDisplayClock(this.time);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (_, d) {
        return vm.isAnalog ? AnalogClock(time, false) : DigitalClock(time, false);
      },
      stream: vm.stream,
    );
  }
}
