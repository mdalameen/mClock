import 'package:flutter/material.dart';
import 'package:mclock/common/app_colors.dart';
import 'package:mclock/components/clock_viewmodel.dart';
import 'package:mclock/injector.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({GlobalKey key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final vm = inject<ClockViewmodel>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (_, d) => CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Settings'),
            primary: true,
            pinned: true,
          ),
          SliverFillRemaining(
            child: Container(
              color: AppColors.background,
              // padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  SwitchListTile(
                    value: vm.isAnalog,
                    onChanged: (value) => vm.analog = value,
                    title: Text('Show Analog'),
                  ),
                  SwitchListTile(
                    value: vm.isAnalogDisplayNumber,
                    onChanged: (value) => vm.analogDisplayNumber = value,
                    title: Text('Hide numbers for analog clock'),
                  ),
                  SwitchListTile(
                    value: vm.isDisplayAMPm,
                    onChanged: (value) => vm.displayAmPm = value,
                    title: Text('Display AM/PM'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      stream: vm.stream,
    );
  }
}
