import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/student.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'class_manager.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE students(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          email TEXT,
          phone TEXT,
          className TEXT,
          department TEXT,
          gender TEXT,
          dateRegistered TEXT,
          present INTEGER
        )
      ''');
      },
    );
  }

  Future<int> insertStudent(Student student) async {
    final database = await db;
    return await database.insert('students', student.toMap());
  }

  Future<List<Student>> getStudents() async {
    final database = await db;
    final result = await database.query('students');
    return result.map((e) => Student.fromMap(e)).toList();
  }

  Future<int> updateStudent(Student student) async {
    final database = await db;
    return await database.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    final database = await db;
    return await database.delete('students', where: 'id = ?', whereArgs: [id]);
  }
}
