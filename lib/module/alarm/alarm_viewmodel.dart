import 'package:mclock/common/app_preferences.dart';
import 'package:mclock/common/base_viewmodel.dart';
import 'package:mclock/common/model.dart';

class AlarmViewmodel extends BaseViewmodel {
  List<AlarmItem> alarms = [];
  AlarmViewmodel() {
    _loadData();
  }

  _loadData() async {
    alarms.addAll(await AppPreferences.getAlarms());
  }

  addAlarm(AlarmItem item) {
    alarms.add(item);
    updateState();
    AppPreferences.setAlarms(alarms);
  }

  removeAlarm(AlarmItem item) {
    alarms.remove(item);
    updateState();
    AppPreferences.setAlarms(alarms);
  }

  checkRemoveOldAlarms() {
    List<AlarmItem> toRemove = [];
    final now = DateTime.now();
    for (var v in alarms) {
      if (v.time.isBefore(now)) toRemove.add(v);
    }
    if (toRemove.isNotEmpty) {
      for (var v in toRemove) {
        removeAlarm(v);
      }
    }
  }
}
