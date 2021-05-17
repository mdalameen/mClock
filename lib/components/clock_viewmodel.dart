import 'dart:async';

import 'package:mclock/common/base_viewmodel.dart';

class ClockViewmodel extends BaseViewmodel {
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
}
