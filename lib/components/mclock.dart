import 'package:flutter/material.dart';
import 'package:mclock/components/analog_clock.dart';
import 'package:mclock/components/digital_clock.dart';

import '../injector.dart';
import 'clock_viewmodel.dart';

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
        return vm.isAnalog ? AnalogClock(now, true) : DigitalClock(now);
      },
      stream: vm.stream,
    );
  }
}
