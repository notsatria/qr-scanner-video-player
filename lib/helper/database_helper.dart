import 'package:path/path.dart';
import 'package:qr_video_player/app/model/video_result.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  static String tableName = 'video_result';

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb('qr_video_player');
    return _database!;
  }

  Future<Database> _initDb(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
        CREATE TABLE video_result(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        title TEXT NOT NULL, 
        description TEXT,
        url TEXT NOT NULL
        )
      ''');
  }

  Future<int> insertVideoResult(VideoResult videoResult) async {
    final db = await instance.database;
    return await db.insert(tableName, videoResult.toMap());
  }

  Future<List<VideoResult>> getAllVideoResults() async {
    final db = await instance.database;
    final result = await db.query(tableName);
    return result.map((map) => VideoResult.fromMap(map)).toList();
  }

  Future<int> updateVideoResultTitle(VideoResult object) async {
    final db = await instance.database;
    return await db.update(tableName, object.toMap(),
        where: 'id = ?', whereArgs: [object.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<VideoResult>> searchVideos(String query) async {
    final db = await instance.database;
    final result = await db.rawQuery(
        'SELECT * FROM $tableName WHERE title LIKE ? OR description LIKE ?',
        ['%$query%', '%$query%']);
    return result.map((map) => VideoResult.fromMap(map)).toList();
  }
}
