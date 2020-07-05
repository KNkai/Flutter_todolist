import 'package:todolist_sqflite/src/repository/repository.dart';

class TodoRepository {
  var repo = Repository();

  // ignore: empty_constructor_bodies
  TodoRepository() {}

  save(table, data) async {
    var conn = await repo.database;
    return await conn.insert(table, data);
  }

  getAllTodo(table, int idcate) async {
    var conn = await repo.database;
    return await conn.query(table, where: 'idcate=?', whereArgs: [idcate]);
  }

  getATodo(table, int id) async {
    var conn = await repo.database;
    return await conn.query(table, where: 'id=?', whereArgs: [id]);
  }

  deleteTodoByid(table, int id) async {
    var conn = await repo.database;
    return await conn.delete(table, where: 'id=?', whereArgs: [id]);
  }

  deleteTodoByIdCate(table, int id) async {
    var conn = await repo.database;
    return await conn.delete(table, where: 'idcate=?', whereArgs: [id]);
  }

  updateTodo(table, data, int id) async {
    var conn = await repo.database;
    return await conn.update(table, data, where: 'id=?', whereArgs: [id]);
  }
}
