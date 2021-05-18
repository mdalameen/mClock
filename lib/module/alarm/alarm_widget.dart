import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mclock/common/app_colors.dart';
import 'package:mclock/common/model.dart';
import 'package:mclock/components/clock_wrapper_widget.dart';
import 'package:mclock/components/mclock.dart';

import '../../injector.dart';
import 'alarm_viewmodel.dart';

abstract class AlarmWidget {
  final vm = inject<AlarmViewmodel>();
  buildContent(BuildContext context) => Container(
        color: AppColors.background,
        child: StreamBuilder(
            stream: vm.stream,
            builder: (_, d) => CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: Text('Alarms'),
                    ),
                    SliverFillRemaining(
                      child: SingleChildScrollView(
                        child: Container(
                          child: ClockWrapperWidget(
                              onAddPressed,
                              List.generate(vm.alarms.length, (index) {
                                final alarm = vm.alarms[index];
                                return WrapContent(
                                  () => removeAlarm(alarm),
                                  MDisplayClock(alarm.time),
                                  DateFormat('dd/MMM/yy hh:mm:aa').format(alarm.time),
                                );
                              })),
                        ),
                      ),
                    )
                  ],
                )),
      );

  removeAlarm(AlarmItem alarm);

  onAddPressed();
}
