import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  static const _version = 1;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('outfit_planner.db', _version);
    return _database!;
  }

  Future<Database> _initDB(String filepath, int version) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(
      path,
      version: version,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY,
        cuenta TEXT,
        password TEXT,
        correo TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE prendas (
        id INTEGER PRIMARY KEY,
        idUsuario INTEGER,
        tokenImagen TEXT,
        tipo TEXT,
        FOREIGN KEY (idUsuario) REFERENCES usuarios(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE outfits (
        id INTEGER PRIMARY KEY,
        idUsuario INTEGER,
        idPrenda1 INTEGER,
        idPrenda2 INTEGER,
        idPrenda3 INTEGER,
        FOREIGN KEY (idUsuario) REFERENCES usuarios(id),
        FOREIGN KEY (idPrenda1) REFERENCES prendas(id),
        FOREIGN KEY (idPrenda2) REFERENCES prendas(id),
        FOREIGN KEY (idPrenda3) REFERENCES prendas(id)
      )
    ''');
  }

  Future<int> createUsuario(
      String cuenta, String password, String correo) async {
    final db = await instance.database;

    return await db.insert('usuarios', {
      'cuenta': cuenta,
      'password': password,
      'correo': correo,
    });
  }

  Future<int> createPrenda(
      int idUsuario, String tokenImagen, String tipo) async {
    final db = await instance.database;

    return await db.insert('prendas', {
      'idUsuario': idUsuario,
      'tokenImagen': tokenImagen,
      'tipo': tipo,
    });
  }

  Future<int> createOutfit(
      int idUsuario, int idPrenda1, int idPrenda2, int idPrenda3) async {
    final db = await instance.database;

    return await db.insert('outfits', {
      'idUsuario': idUsuario,
      'idPrenda1': idPrenda1,
      'idPrenda2': idPrenda2,
      'idPrenda3': idPrenda3,
    });
  }

  Future<List<Map<String, dynamic>>> getUsuarios() async {
    final db = await instance.database;
    return db.query('usuarios');
  }

  Future<List<Map<String, dynamic>>> getPrendas(int idUsuario) async {
    final db = await instance.database;
    return db.query('prendas', where: 'idUsuario = ?', whereArgs: [idUsuario]);
  }

  Future<List<Map<String, dynamic>>> getOutfits(int idUsuario) async {
    final db = await instance.database;
    return db.query('outfits', where: 'idUsuario = ?', whereArgs: [idUsuario]);
  }

  Future<bool> usuarioExist(String cuenta, String password) async {
    final db = await instance.database;

    final result = await db.query('usuarios',
        where: 'cuenta = ? AND password = ?', whereArgs: [cuenta, password]);

    return result.isNotEmpty;
  }

  Future<int> getIdUsuario(String cuenta, String password) async {
    final db = await instance.database;
    final result = await db.query('usuarios',
        columns: ['id'],
        where: 'cuenta = ? AND password = ?',
        whereArgs: [cuenta, password]);
    return result.first['id'] as int;
  }

  Future<List<String>> getTokensDeImagen(int idUsuario) async {
    final db = await instance.database;
    final result = await db.query('prendas',
        where: 'idUsuario = ?',
        whereArgs: [idUsuario],
        columns: ['tokenImagen']);

    return result.map((row) => row['tokenImagen'] as String).toList();
  }
}
