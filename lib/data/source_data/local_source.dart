import 'package:hive_flutter/hive_flutter.dart';

class LocalSource {
  static const String _boxName = 'users';

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.initFlutter();
      await Hive.openBox(_boxName);
    }
  }

  Future<void> saveData(String key, dynamic value) async {
    var box = Hive.box(_boxName);
    await box.put(key, value);
  }

  dynamic getData(String key) {
    var box = Hive.box(_boxName);
    return box.get(key);
  }

  Future<void> deleteData(String key) async {
    var box = Hive.box(_boxName);
    await box.delete(key);
  }

  Future<void> clearData() async {
    var box = Hive.box(_boxName);
    await box.clear();
  }
}