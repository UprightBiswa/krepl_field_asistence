// import 'package:path_provider/path_provider.dart';
// import 'package:sembast/sembast.dart';
// import 'package:sembast/sembast_io.dart';
// import 'dart:async';

// import '../model/location_data_model.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _singleton = DatabaseHelper._internal();
//   static Database? _db;
//   static final _store = intMapStoreFactory.store('location_store');

//   DatabaseHelper._internal();

//   factory DatabaseHelper() {
//     return _singleton;
//   }

//   Future<Database> get database async {
//     if (_db == null) {
//       final appDocDir = await getApplicationDocumentsDirectory();
//       final dbPath = '${appDocDir.path}/location.db';
//       _db = await databaseFactoryIo.openDatabase(dbPath);
//     }
//     return _db!;
//   }

//   Future<int> addLocation(LocationDataModel location) async {
//     final db = await database;
//     return await _store.add(db, location.toJson());
//   }

//   Future<List<LocationDataModel>> getLocations() async {
//     final db = await database;
//     final records = await _store.find(db);
//     return records.map((snapshot) {
//       final location = LocationDataModel.fromJson(snapshot.value);
//       return location;
//     }).toList();
//   }

//   Future<void> clearLocations() async {
//     final db = await database;
//     await _store.delete(db);
//   }
// }

import 'package:sembast/sembast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';
import '../model/location_data_model.dart';

class DatabaseHelper {
  static const String _dbName = 'location.db';
  static const String _storeName = 'locations';
  Database? _database;
  final StoreRef<int, Map<String, dynamic>> _store =
      intMapStoreFactory.store(_storeName);

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDir.path, _dbName);
    return await databaseFactoryIo.openDatabase(dbPath);
  }

  Future<void> addLocation(LocationDataModel location) async {
    final db = await database;
    await _store.add(db, location.toMap());
  }

  Future<List<LocationDataModel>> getAllLocations() async {
    final db = await database;
    final snapshots = await _store.find(db);
    return snapshots
        .map((snapshot) => LocationDataModel.fromMap(snapshot.value))
        .toList();
  }

  Future<void> clearLocations() async {
    final db = await database;
    await _store.delete(db);
  }
}
