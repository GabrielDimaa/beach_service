import 'dart:io';
import 'package:beach_service/app/modules/login/repositories/login_repository.dart';
import 'package:beach_service/app/modules/user/repositories/user_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQFLiteHelper {
  final String _nameDb = "beach_service_db.db";
  final int _versionDb = 1;
  static Database _db;

  SQFLiteHelper();

  Future<Database> getDb() async {
    if (_db == null) {
      await openDb();
    }

    return _db;
  }

  Future<void> openDb() async {
    _db = await openDatabase(
      await getPath(),
      version: _versionDb,
      onCreate: _onCreate,
    );
  }

  Future<void> closeDb() async {
    await _db?.close();
    _db = null;
  }

  Future<String> getPath() async {
    String pathDb = await getDatabasesPath();
    String path = join(pathDb, _nameDb);

    try {
      await Directory(pathDb).create(recursive: true);
    } catch (e) {
      print("Erro ao criar diretório: $e");
    }

    return path;
  }

  Future<void>_onCreate(Database db, int version) async {
    var batch = db.batch();

    LoginRepository().create(batch);
    UserRepository().create(batch);

    await batch.commit();
  }
}