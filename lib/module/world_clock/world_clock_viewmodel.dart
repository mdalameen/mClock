import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:mclock/common/app_preferences.dart';
import 'package:mclock/common/base_viewmodel.dart';
import 'package:mclock/module/world_clock/select_timezone/select_timezone_popup.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class WorldClockViewmodel extends BaseViewmodel {
  Map<String, tz.Location> locations;
  List<String> addedTimezones = [];
  String _currentTimeZone;

  WorldClockViewmodel() {
    initTimezones();
  }

  Future<void> initTimezones() async {
    _currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.initializeTimeZones();
    locations = tz.timeZoneDatabase.locations;
    addedTimezones.addAll(await AppPreferences.getAddedTimeZones());
    updateState();
  }

  addWorldClock(SelectTimezoneOut selectedLocation) {
    addedTimezones.add(selectedLocation.timeZone);
    updateState();
    AppPreferences.setAddedTimeZones(addedTimezones);
  }

  removeTimezone(String timezone) {
    addedTimezones.remove(timezone);
    updateState();
    AppPreferences.setAddedTimeZones(addedTimezones);
  }

  // String currentTimeZone() => DateTime.now().timeZoneName;
  String currentTimeZone() => _currentTimeZone ?? '';
}
