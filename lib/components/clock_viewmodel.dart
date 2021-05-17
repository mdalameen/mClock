import 'dart:async';

import 'package:mclock/common/base_viewmodel.dart';

class ClockViewmodel extends BaseViewmodel {
  bool _isAnalog = true;
  bool _analogDisplayNumber = false;

  Timer _timer;
  ClockViewmodel() : super() {
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      updateState();
    });
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
  }

  bool get isAnalogDisplayNumber => _analogDisplayNumber;

  set analogDisplayNumber(bool isAnalogDisplayNumber) {
    _analogDisplayNumber = isAnalogDisplayNumber;
    updateState();
  }
}
