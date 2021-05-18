import 'dart:async';

import 'package:mclock/common/app_preferences.dart';
import 'package:mclock/common/base_viewmodel.dart';

class ClockViewmodel extends BaseViewmodel {
  bool _isAnalog = true;
  bool _analogDisplayNumber = false;
  bool _displayAmPm = true;

  Timer _timer;
  ClockViewmodel() : super() {
    _loadData();
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      updateState();
    });
  }

  _loadData() async {
    _isAnalog = await AppPreferences.isAnalog();
    _analogDisplayNumber = await AppPreferences.isDisplayNumber();
    _displayAmPm = await AppPreferences.isDisplayAmPm();
    updateState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool get isAnalog => _isAnalog;

  set analog(bool isAnalog) {
    _isAnalog = isAnalog;
    updateState();
    AppPreferences.setAnalog(isAnalog);
  }

  bool get isAnalogDisplayNumber => _analogDisplayNumber;

  set analogDisplayNumber(bool isAnalogDisplayNumber) {
    _analogDisplayNumber = isAnalogDisplayNumber;
    updateState();
    AppPreferences.setDisplayNumber(isAnalogDisplayNumber);
  }

  bool get isDisplayAMPm => _displayAmPm;

  set displayAmPm(bool displayAmPm) {
    _displayAmPm = displayAmPm;
    updateState();
    AppPreferences.setDisplayAmPm(displayAmPm);
  }
}
