import 'package:flutter/material.dart';
import 'package:mclock/common/app_colors.dart';
import 'package:mclock/injector.dart';
import 'package:mclock/module/world_clock/world_clock_viewmodel.dart';
import 'package:timezone/timezone.dart';

class SelectTimeZonePopup extends StatefulWidget {
  @override
  _SelectTimeZonePopupState createState() => _SelectTimeZonePopupState();

  static Future<SelectTimezoneOut> display(BuildContext context) {
    return showModalBottomSheet(context: context, builder: (_) => SelectTimeZonePopup());
  }
}

class _SelectTimeZonePopupState extends State<SelectTimeZonePopup> {
  final wcVm = inject<WorldClockViewmodel>();
  List<String> timeZones;
  List<String> displayingTimezone = [];
  TextEditingController controller = TextEditingController();

  @override
  initState() {
    super.initState();
    timeZones = wcVm.locations.keys.toList();
    filterList();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  filterList() {
    displayingTimezone.clear();
    String text = filterText.trim();
    if (text.isEmpty) {
      displayingTimezone.addAll(timeZones);
    } else {
      for (var v in timeZones) {
        if (v.toLowerCase().contains(text)) displayingTimezone.add(v);
      }
    }
  }

  String filterText = '';
  _onTextChanged(String text) {
    filterText = text;
    filterList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            color: AppColors.clockOuter,
            child: Text(
              'Select Timezone',
              style: TextStyle(color: Colors.black, fontSize: 16),
            )),
        SizedBox(height: 5),
        Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Expanded(
                child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Enter to search',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              controller: controller,
              onChanged: _onTextChanged,
            )),
            if (filterText != '')
              IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    controller.text = '';
                    _onTextChanged('');
                  })
            else
              SizedBox(
                width: 15,
              ),
          ],
        ),
        Expanded(
            child: ListView.separated(
          padding: EdgeInsets.zero,
          separatorBuilder: (_, i) => Divider(),
          itemCount: displayingTimezone.length,
          itemBuilder: (_, i) {
            String timeZone = displayingTimezone[i];
            return ListTile(
              enabled: !wcVm.addedTimezones.contains(timeZone),
              onTap: () => Navigator.pop(context, SelectTimezoneOut(timeZone, wcVm.locations[timeZone])),
              trailing: Icon(Icons.chevron_right),
              title: Text(
                timeZone,
              ),
            );
          },
        ))
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class SelectTimezoneOut {
  String timeZone;
  Location location;

  SelectTimezoneOut(this.timeZone, this.location);
}
