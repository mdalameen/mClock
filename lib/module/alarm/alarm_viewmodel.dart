import 'package:mclock/common/base_viewmodel.dart';
import 'package:mclock/common/model.dart';

class AlarmViewmodel extends BaseViewmodel {
  List<AlarmItem> alarms = [];
  addAlarm(AlarmItem item) {
    alarms.add(item);
    updateState();
  }

  removeAlarm(AlarmItem item) {
    alarms.remove(item);
    updateState();
  }
}
