import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

Future<String> utilsGetDatabasePath() async {
  String dbPath;
  if (Platform.isIOS) {
    final libDir = await getLibraryDirectory();
    dbPath = libDir.path;
  } else {
    dbPath = await getDatabasesPath();
  }
  return dbPath;
} 
