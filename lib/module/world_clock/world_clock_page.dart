import 'package:flutter/material.dart';
import 'package:mclock/module/world_clock/select_timezone/select_timezone_popup.dart';
import 'package:mclock/module/world_clock/world_clock_widget.dart';

class WorldClockPage extends StatefulWidget {
  WorldClockPage({GlobalKey key}) : super(key: key);
  @override
  _WorldClockPageState createState() => _WorldClockPageState();
}

class _WorldClockPageState extends State<WorldClockPage> with WorldClockWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (_, d) => CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('World Clock'),
            primary: true,
            floating: true,
            snap: true,
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: buildContent(context),
          )
        ],
      ),
      stream: vm.stream,
    );
  }

  @override
  onAddPressed() async {
    final location = await SelectTimeZonePopup.display(context);
    if (location != null) vm.addWorldClock(location);
  }
}
