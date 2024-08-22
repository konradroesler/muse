import 'package:flutter/widgets.dart';
import 'package:muse/bootstrap.dart';
import 'package:local_storage_tracks_api/local_storage_tracks_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'tracks_database.db');

  final tracksApi = LocalStorageTracksApi(
    database: await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tracks (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            audioFile BLOB NOT NULL
          );
        ''');
      }
    )
  );

  bootstrap(tracksApi: tracksApi);
}
