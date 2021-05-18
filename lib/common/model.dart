class AlarmItem {
  DateTime time;
  int id;
  AlarmItem(this.id, this.time);

  AlarmItem.fromJson(Map<String, dynamic> map)
      : time = DateTime.parse(map['time']),
        id = map['id'];

  Map<String, dynamic> toJson() => {
        'time': time.toIso8601String(),
        'id': id,
      };

  static List<AlarmItem> getList(List dList) {
    List<AlarmItem> list = [];
    if (dList != null) for (var v in dList) list.add(AlarmItem.fromJson(v));
    return list;
  }

  static List<Map<String, dynamic>> getJsonList(List<AlarmItem> list) {
    List<Map<String, dynamic>> dList = [];
    if (list != null) for (var v in list) dList.add(v.toJson());
    return dList;
  }
}
