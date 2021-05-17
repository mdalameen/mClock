import 'package:flutter/material.dart';
import 'package:mclock/common/base_viewmodel.dart';
import 'package:mclock/module/home/home_page.dart';

class HomeViewmodel extends BaseViewmodel {
  PageType selectedPage = PageType.clock;

  String getPageTitle(PageType page) {
    switch (page) {
      case PageType.clock:
        return 'Clock';
      case PageType.alarm:
        return 'Alarms';
      case PageType.settings:
        return 'Settings';
      default:
        return 'Invalid';
    }
  }

  IconData getPageIcon(PageType page) {
    switch (page) {
      case PageType.clock:
        return Icons.access_time_outlined;
      case PageType.alarm:
        return Icons.access_alarm;
      case PageType.settings:
        return Icons.settings;
      default:
        return Icons.warning;
    }
  }

  onMenuChanged(PageType page) {
    selectedPage = page;
    updateState();
  }
}
