import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';

class AppPreferences {
  static const _keyAnalog = 'analog';
  static const _keyDisplayNumber = 'displayNumber';
  static const _keyDisplayAmPm = 'displayAmPm';
  static const _keyTimeZone = 'timeZone';
  static const _keyAlarms = 'alarms';

  static Future<SharedPreferences> _getPref() async => SharedPreferences.getInstance();

  static Future<bool> isAnalog() async => (await _getPref()).getBool(_keyAnalog) ?? true;

  static Future<bool> setAnalog(bool isAnalog) async => (await _getPref()).setBool(_keyAnalog, isAnalog);

  static Future<bool> isDisplayNumber() async => (await _getPref()).getBool(_keyDisplayNumber) ?? false;

  static Future<bool> setDisplayNumber(bool displayNumber) async => (await _getPref()).setBool(_keyDisplayNumber, displayNumber);

  static Future<bool> isDisplayAmPm() async => (await _getPref()).getBool(_keyDisplayAmPm) ?? true;

  static Future<bool> setDisplayAmPm(bool displayAmPm) async => (await _getPref()).setBool(_keyDisplayAmPm, displayAmPm);

  static Future<List<String>> getAddedTimeZones() async {
    final pref = await _getPref();
    if (pref.containsKey(_keyTimeZone)) pref.getStringList(_keyTimeZone);
    return <String>[];
  }

  static Future<bool> setAddedTimeZones(List<String> list) async {
    final pref = await _getPref();
    if (list.isEmpty) {
      return pref.remove(_keyTimeZone);
    } else {
      return pref.setStringList(_keyTimeZone, list);
    }
  }

  static Future<List<AlarmItem>> getAlarms() async {
    final pref = await _getPref();
    if (pref.containsKey(_keyAlarms)) {
      return AlarmItem.getList(json.decode(pref.getString(_keyAlarms)));
    } else
      return <AlarmItem>[];
  }

  static Future<bool> setAlarms(List<AlarmItem> list) async {
    final pref = await _getPref();
    if (list.isEmpty)
      return pref.remove(_keyAlarms);
    else
      return pref.setString(_keyAlarms, json.encode(AlarmItem.getJsonList(list)));
  }
}
