import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum AudioFileExtensions { mp3, wav, m4a }

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

String utilsGetFileExtensionAsString(String fileName) {
  return fileName.split('.').last;
}

Future<String?> getCorrectFileExtension(String fileNameWithoutExtension) async {
  final dbPath = await utilsGetDatabasePath();
  for (final ext in AudioFileExtensions.values) {
    final lookupPath = '${join(dbPath, fileNameWithoutExtension)}.${ext.name}';
    final exists = await File(lookupPath).exists();
    if (exists) {
      return ext.name;
    }
  }
  return null;
}
