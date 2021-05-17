import 'package:flutter/material.dart';
import 'package:mclock/common/app_colors.dart';
import 'package:mclock/components/analog_clock.dart';
import 'package:mclock/injector.dart';
import 'package:mclock/module/world_clock/world_clock_viewmodel.dart';
import 'package:timezone/timezone.dart';

abstract class WorldClockWidget {
  final vm = inject<WorldClockViewmodel>();
  buildContent(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          SafeArea(child: SizedBox()),
          Center(
            child: SizedBox(
              width: 280,
              height: 280,
              child: AnalogClock(DateTime.now().timeZoneOffset.inMilliseconds),
            ),
          ),
          TextButton(onPressed: onAddPressed, child: Text('Add')),
          ...List.generate(vm.addedTimezones.length, (index) {
            var timeZone = vm.addedTimezones[index];
            Location location = vm.locations[timeZone];
            return ListTile(
              title: AnalogClock(location.currentTimeZone.offset),
            );
          })
        ],
      ),
    );
  }

  onAddPressed();
}
