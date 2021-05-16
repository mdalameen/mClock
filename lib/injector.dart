import 'package:get_it/get_it.dart';
import 'package:mclock/module/alarm/alarm_viewmodel.dart';
import 'package:mclock/module/home/home_viewmodel.dart';
import 'package:mclock/module/world_clock/world_clock_viewmodel.dart';

import 'manager/clock_manager.dart';

final GetIt inject = GetIt.I;

setupInjection() {
  final _onDispose = (v) => v.dispose();
  inject.registerSingleton(ClockManger(), dispose: _onDispose);

  inject.registerLazySingleton(() => HomeViewmodel(), dispose: _onDispose);
  inject.registerLazySingleton(() => WorldClockViewmodel(), dispose: _onDispose);
  inject.registerLazySingleton(() => AlarmViewmodel(), dispose: _onDispose);
}
