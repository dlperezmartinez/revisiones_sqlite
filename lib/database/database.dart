import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:arnesrevisionsqlite/model/arnes.dart';

class ArnesDataBase {
  static final ArnesDataBase instance = ArnesDataBase._init();

  static Database? _database;

  ArnesDataBase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('arnes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType =
        'INTEGER PRIMARY KEY AUTOINCREMENT'; //TODO No va a ser AUTOINCREMENTAL, lo deberá introducir el usuario
    final textType = 'TEXT';
    //TODO Probablemente falta añadir dateType o algo así.

    await db.execute('''
  CREATE TABLE $tableArneses (
  ${ArnesFields.id} $idType,
  ${ArnesFields.nombre} $textType,
  ${ArnesFields.revision} $textType,
  ${ArnesFields.observaciones} $textType,
  )
  ''');
  }

  Future create(Arnes arnes) async {
    final db = await instance.database;

    final id = await db.insert(tableArneses, arnes.toJson());
    return arnes.copy(id: id);
  }

  Future<Arnes> readArnes(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableArneses,
      columns: ArnesFields.values,
      where: '${ArnesFields.id} = ?',
      whereArgs: [id], //Esta forma de hacerlo previene ataques de inyección SQL
    );

    if (maps.isNotEmpty) {
      return Arnes.fromJson(maps.first);
    } else {
      throw Exception('Arnés no encontrado');
    }
  }

  Future<List<Arnes>> readAllArnes() async {
    final db = await instance.database;
    final orderBy = '${ArnesFields.revision} ASC';

    final result = await db.query(tableArneses, orderBy: orderBy);

    return result.map((json) => Arnes.fromJson(json)).toList();
  }

  Future<int> update(Arnes arnes) async {
    final db = await instance.database;

    return db.update(
      tableArneses,
      arnes.toJson(),
      where: '${ArnesFields.id} = ?',
      whereArgs: [arnes.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableArneses,
      where: '${ArnesFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
