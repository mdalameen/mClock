import 'package:flutter/material.dart';
import 'package:mclock/injector.dart';
import 'package:mclock/module/world_clock/world_clock_viewmodel.dart';
import 'package:timezone/timezone.dart';

class SelectTimeZonePopup extends StatefulWidget {
  @override
  _SelectTimeZonePopupState createState() => _SelectTimeZonePopupState();

  static Future<SelectTimezoneOut> display(BuildContext context) {
    return showModalBottomSheet(context: context, builder: (_) => SelectTimeZonePopup());
  }
}

class _SelectTimeZonePopupState extends State<SelectTimeZonePopup> {
  final wcVm = inject<WorldClockViewmodel>();
  List<String> timeZones;

  @override
  initState() {
    super.initState();
    timeZones = wcVm.locations.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, i) {
        String timeZone = timeZones[i];
        return ListTile(
          enabled: !wcVm.addedTimezones.contains(timeZone),
          onTap: () => Navigator.pop(context, SelectTimezoneOut(timeZone, wcVm.locations[timeZone])),
          title: Text(timeZone),
        );
      },
    );
  }
}

class SelectTimezoneOut {
  String timeZone;
  Location location;

  SelectTimezoneOut(this.timeZone, this.location);
}
