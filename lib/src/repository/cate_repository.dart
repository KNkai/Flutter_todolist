import 'package:todolist_sqflite/src/repository/repository.dart';

class CateRepository{

  var repo = Repository();
  // ignore: empty_constructor_bodies
  CateRepository(){}

  save(table, data)async{
    var conn = await repo.database;
    return await conn.insert(table, data);
  }

  getAll(table)async{
    var conn = await repo.database;
    return await conn.query(table);
  }

  getACategory(table, int id)async{
    var conn = await repo.database;
    return await conn.query(table, where: 'id=?', whereArgs: [id]);
  }

  delete(table, int id)async{
    var conn = await repo.database;
    return await conn.delete(table, where: 'id=?', whereArgs: [id]);
  }

  update(table, data, int id)async{
    var conn = await repo.database;
    return await conn.update(table, data, where: 'id=?', whereArgs: [id]);
  }
}