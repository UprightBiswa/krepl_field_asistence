import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'notification_model.dart';

class NotificationDatabase {
  static final NotificationDatabase _singleton =
      NotificationDatabase._internal();
  static const String storeName = 'notifications';
  late Database _database;
  final _store = intMapStoreFactory.store(storeName);

  factory NotificationDatabase() {
    return _singleton;
  }

  NotificationDatabase._internal();

  Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDocumentDir.path}/notifications.db';
    _database = await databaseFactoryIo.openDatabase(dbPath);
  }

  Future<void> saveNotification(NotificationModel notification) async {
    await _store.add(_database, notification.toJson());
  }

  Future<List<NotificationModel>> fetchNotifications() async {
    final records = await _store.find(_database);
    return records.map((record) {
      final notification = NotificationModel.fromJson(record.value);
      notification.id = record.key.toString();
      return notification;
    }).toList();
  }

  Future<void> deleteNotification(String id) async {
    final finder = Finder(filter: Filter.byKey(int.parse(id)));
    await _store.delete(_database, finder: finder);
  }
}
