import 'package:jt_app_basic_structure/utils/save/sql/sql_utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlTemplateModel {
  String id;
  bool booleanValue;
  int integerValue;

  SqlTemplateModel({
    required this.id,
    required this.booleanValue,
    required this.integerValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'booleanValue': booleanValue ? 1 : 0,
      'stringValue': integerValue,
    };
  }

  factory SqlTemplateModel.fromJson(Map<String, dynamic> map) {
    return SqlTemplateModel(
      id: map['id'],
      booleanValue: SqlUtils.isDynamicTrue(map['booleanValue']),
      integerValue: map['stringValue'],
    );
  }
}

/// search and rename all "template"
class GeneralSqlTemplate {
  static const String databaseName = 'template_general.db';

  GeneralSqlTemplate._privateConstructor();
  static final GeneralSqlTemplate _instance =
      GeneralSqlTemplate._privateConstructor();
  factory GeneralSqlTemplate() {
    return _instance;
  }

  Database? _database;

  // Get or initialize the database
  Future<Database> _getDatabase() async {
    if (_database != null) return _database!;
    _database = await _initializeDb();
    return _database!;
  }

  String _getTable() {
    return 'template';
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

  Future<void> _createTableIfNotExists(Transaction txn) async {
    String tableName = _getTable();
    await txn.execute('''
    CREATE TABLE IF NOT EXISTS $tableName (
      id TEXT PRIMARY KEY,
      booleanValue INTEGER,
      stringValue INTEGER
    )
  ''');
  }

  Future<void> addSingle({
    required int epochDay,
    required SqlTemplateModel template,
  }) async {
    final db = await _getDatabase();
    String tableName = _getTable();
    await db.transaction((txn) async {
      await _createTableIfNotExists(txn);
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
    required SqlTemplateModel template,
  }) async {
    final db = await _getDatabase();
    String tableName = _getTable();
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

  Future<List<SqlTemplateModel>> getAll() async {
    final db = await _getDatabase();
    String tableName = _getTable();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return SqlTemplateModel.fromJson(maps[i]);
    });
  }

  Future<void> addAll({
    required List<SqlTemplateModel> templates,
    bool clearBeforeAdd = false,
  }) async {
    final db = await _getDatabase();
    String tableName = _getTable();
    await db.transaction((txn) async {
      await _createTableIfNotExists(txn);
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
