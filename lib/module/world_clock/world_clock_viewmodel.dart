import 'package:mclock/common/base_viewmodel.dart';
import 'package:mclock/module/world_clock/select_timezone/select_timezone_popup.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class WorldClockViewmodel extends BaseViewmodel {
  Map<String, tz.Location> locations;
  List<String> addedTimezones = [];
  WorldClockViewmodel() {
    initTimezones();
  }

  Future<void> initTimezones() async {
    tz.initializeTimeZones();
    locations = tz.timeZoneDatabase.locations;
  }

  addWorldClock(SelectTimezoneOut selectedLocation) {
    addedTimezones.add(selectedLocation.timeZone);
    updateState();
  }
}
