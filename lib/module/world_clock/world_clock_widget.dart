import 'package:flutter/material.dart';
import 'package:mclock/common/app_colors.dart';
import 'package:mclock/components/clock_wrapper_widget.dart';
import 'package:mclock/components/mclock.dart';
import 'package:mclock/injector.dart';
import 'package:mclock/module/world_clock/world_clock_viewmodel.dart';
import 'package:timezone/timezone.dart';

abstract class WorldClockWidget {
  final vm = inject<WorldClockViewmodel>();
  buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.background,
        child: Column(
          children: [
            SafeArea(
                child: SizedBox(
              height: 20,
            )),
            Center(
              child: SizedBox(
                width: 280,
                height: 280,
                child: Mclock(DateTime.now().timeZoneOffset.inMilliseconds),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(vm.currentTimeZone()),
            ClockWrapperWidget(
                onAddPressed,
                List.generate(vm.addedTimezones.length, (index) {
                  var timeZone = vm.addedTimezones[index];
                  Location location = vm.locations[timeZone];
                  return WrapContent(
                    () => vm.removeTimezone(timeZone),
                    Mclock(location.currentTimeZone.offset),
                    timeZone,
                  );
                }))
          ],
        ),
      ),
    );
  }

  onAddPressed();
}
