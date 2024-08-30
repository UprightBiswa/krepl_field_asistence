import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class UserDatabase {
  static const String dbName = 'user_database.db';
  final StoreRef<String, Map<String, dynamic>> _store =
      stringMapStoreFactory.store('users');
  Database? _db;

  Future<Database> _openDatabase() async {
    if (_db == null) {
      final String path = join(
        (await getApplicationDocumentsDirectory()).path,
        dbName,
      );
      final DatabaseFactory dbFactory = databaseFactoryIo;
      _db = await dbFactory.openDatabase(path);
    }
    return _db!;
  }

  Future<void> saveUserDetails(
      String username, Map<String, dynamic> data) async {
    final Database db = await _openDatabase();
    await _store.record(username).put(db, data);
    print('User details saved: $data');
    _printObjectCount();
  }

  Future<Map<String, dynamic>?> getUserDetailsByUsername(
      String username) async {
    final Database db = await _openDatabase();
    final snapshot = await _store.record(username).getSnapshot(db);

    print('User details retrieved: ${snapshot?.value}');
    return snapshot?.value;
  }

  Future<void> clearUserDetails(String username) async {
    final Database db = await _openDatabase();
    await _store.record(username).delete(db);
    print('User details cleared for username: $username');
    _printObjectCount();
  }

  void _printObjectCount() async {
    final Database db = await _openDatabase();
    final count = await _store.count(db);
    print('Total objects saved: $count');
  }

  Future<void> closeDatabase() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }
}
