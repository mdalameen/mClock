import 'package:get_it/get_it.dart';
import 'package:mclock/components/clock_viewmodel.dart';
import 'package:mclock/module/alarm/alarm_viewmodel.dart';
import 'package:mclock/module/home/home_viewmodel.dart';
import 'package:mclock/module/world_clock/world_clock_viewmodel.dart';

import 'module/settings/settings_viewmodel.dart';

final GetIt inject = GetIt.I;

setupInjection() {
  final _onDispose = (v) => v.dispose();
  inject.registerSingleton(ClockViewmodel(), dispose: _onDispose);

  inject.registerLazySingleton(() => HomeViewmodel(), dispose: _onDispose);
  inject.registerLazySingleton(() => WorldClockViewmodel(), dispose: _onDispose);
  inject.registerLazySingleton(() => AlarmViewmodel(), dispose: _onDispose);
  inject.registerLazySingleton(() => SettingsViewmodel(), dispose: _onDispose);
}
