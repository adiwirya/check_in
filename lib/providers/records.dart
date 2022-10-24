import 'package:check_in/models/models.dart';
import 'package:check_in/services/db_services.dart';
import 'package:flutter/material.dart';

class Records with ChangeNotifier {
  List<Record> _items = [];

  List<Record> get items {
    return [..._items];
  }

  void addRecord(Record record) {
    _items.add(record);
    notifyListeners();
    DBServices.insert('user_records', {
      'id': DateTime.now().toString(),
      'location': record.location,
      'dates': record.dates,
      'checks': record.checks,
      'times': record.times,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBServices.getData('user_records');
    _items = dataList
        .map(
          (item) => Record(
            id: item['id'].toString(),
            location: item['location'].toString(),
            dates: item['dates'].toString(),
            checks: item['checks'].toString(),
            times: item['times'].toString(),
          ),
        )
        .toList();
    notifyListeners();
  }
}
