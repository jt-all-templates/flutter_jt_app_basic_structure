import 'package:jt_app_basic_structure/utils/save/sql/general_sql_template.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// search and rename all "template"
class DayBasedSqlTemplate {
  static const String databaseName = 'template_day.db';

  DayBasedSqlTemplate._privateConstructor();
  static final DayBasedSqlTemplate _instance =
      DayBasedSqlTemplate._privateConstructor();
  factory DayBasedSqlTemplate() {
    return _instance;
  }

  Database? _database;

  // Get or initialize the database
  Future<Database> _getDatabase() async {
    if (_database != null) return _database!;
    _database = await _initializeDb();
    return _database!;
  }

  String _getTable(int epochDay) {
    return 'template_$epochDay';
  }

  // Initialize the database
  Future<Database> _initializeDb() async {
    return openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: 1,
      onCreate: (db, version) async {
        // You can create initial tables here if needed
      },
    );
  }

  Future<void> _createTableIfNotExists(Transaction txn, int epochDay) async {
    String tableName = _getTable(epochDay);
    await txn.execute('''
    CREATE TABLE IF NOT EXISTS $tableName (
      id TEXT PRIMARY KEY,
      booleanValue INTEGER,
      stringValue INTEGER
    )
  ''');
  }

  Future<void> addSingleToDay({
    required int epochDay,
    required SqlTemplateModel template,
  }) async {
    final db = await _getDatabase();
    String tableName = _getTable(epochDay);
    await db.transaction((txn) async {
      await _createTableIfNotExists(txn, epochDay);
      await txn.insert(
        tableName,
        {
          'id': template.id,
          'booleanValue': template.booleanValue ? 1 : 0,
          'stringValue': template.integerValue,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<bool> modifyATemplateValue({
    required int epochDay,
    required SqlTemplateModel template,
  }) async {
    final db = await _getDatabase();
    String tableName = _getTable(epochDay);
    final List<Map<String, dynamic>> data =
        await db.query(tableName, where: "id = ?", whereArgs: [template.id]);

    if (data.isEmpty) {
      return false;
    } else {
      await db.transaction((txn) async {
        await txn.update(
          tableName,
          {
            'booleanValue': template.booleanValue ? 1 : 0,
            'stringValue': template.integerValue,
          },
          where: "id = ?",
          whereArgs: [template.id],
        );
      });
      return true;
    }
  }

  Future<List<SqlTemplateModel>> getAllOfTheDay(int epochDay) async {
    final db = await _getDatabase();
    String tableName = _getTable(epochDay);
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return SqlTemplateModel.fromJson(maps[i]);
    });
  }

  Future<void> addAlToTheDay({
    required int epochDay,
    required List<SqlTemplateModel> templates,
    bool clearBeforeAdd = false,
  }) async {
    final db = await _getDatabase();
    String tableName = _getTable(epochDay);
    await db.transaction((txn) async {
      await _createTableIfNotExists(txn, epochDay);
      if (clearBeforeAdd) {
        await txn.delete(tableName);
      }
      for (SqlTemplateModel template in templates) {
        await txn.insert(
          tableName,
          {
            'id': template.id,
            'booleanValue': template.booleanValue ? 1 : 0,
            'stringValue': template.integerValue,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = join(await getDatabasesPath(), databaseName);
    await deleteDatabase(dbPath);
    _database = null;
  }
}
