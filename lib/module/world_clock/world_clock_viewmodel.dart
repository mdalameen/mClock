import 'package:mclock/common/app_preferences.dart';
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
    addedTimezones.addAll(await AppPreferences.getAddedTimeZones());
    updateState();
  }

  addWorldClock(SelectTimezoneOut selectedLocation) {
    addedTimezones.add(selectedLocation.timeZone);
    updateState();
  }

  removeTimezone(String timezone) {
    addedTimezones.remove(timezone);
    updateState();
  }

  // String currentTimeZone() => tz.getLocation(DateTime.now().timeZoneName).name;
  String currentTimeZone() => DateTime.now().timeZoneName;
  // String currentTimeZone() => tz.timeZoneDatabase.;
}
