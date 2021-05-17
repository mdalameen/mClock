import 'package:flutter/material.dart';
import 'package:mclock/common/app_colors.dart';
import 'package:mclock/components/analog_clock.dart';
import 'package:mclock/components/digital_clock.dart';
import 'package:mclock/components/mclock.dart';
import 'package:mclock/injector.dart';
import 'package:mclock/module/world_clock/world_clock_viewmodel.dart';
import 'package:timezone/timezone.dart';

abstract class WorldClockWidget {
  final vm = inject<WorldClockViewmodel>();
  buildContent(BuildContext context) {
    double gridSize = (MediaQuery.of(context).size.width - 30) / 2;
    return SingleChildScrollView(
      child: Container(
        color: AppColors.white,
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
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.start,
              children: [
                InkWell(
                  onTap: onAddPressed,
                  child: Container(
                    alignment: Alignment.center,
                    width: gridSize,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(gridSize / 10),
                      width: gridSize,
                      height: gridSize,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.clockOuter),
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.clockInner),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 30,
                            ),
                            Text('Add', style: TextStyle(color: Colors.black, fontSize: 18))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ...List.generate(vm.addedTimezones.length, (index) {
                  var timeZone = vm.addedTimezones[index];
                  Location location = vm.locations[timeZone];
                  return InkWell(
                    onTap: () => vm.removeTimezone(timeZone),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: gridSize),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: gridSize,
                        child: Column(
                          children: [
                            SizedBox(
                              width: gridSize,
                              height: gridSize,
                              child: Mclock(location.currentTimeZone.offset),
                            ),
                            Text(timeZone)
                          ],
                        ),
                      ),
                    ),
                  );
                })
              ],
            )
          ],
        ),
      ),
    );
  }

  onAddPressed();
}
