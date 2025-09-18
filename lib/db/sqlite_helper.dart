import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHelper {
  static late Database _database;

  static Future<void> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'auth_database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(username TEXT PRIMARY KEY, password TEXT)",
        );
      },
    );
  }

  static Future<void> saveUser(String username, String password) async {
    await _database.insert('users', {
      'username': username,
      'password': password,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<Map<String, dynamic>?> getUser(String username) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'users',
      where: "username = ?",
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }
}
