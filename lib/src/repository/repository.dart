import 'package:sqflite/sqflite.dart';
import 'package:todolist_sqflite/src/repository/db_connection.dart';

class Repository{
  DatabaseConnection _databaseConnection;

  Repository(){
    _databaseConnection = DatabaseConnection();
  }

  Database _database;

  Future<Database> get database async{
    if(_database!=null){
      return _database;
      
    }
    _database = await _databaseConnection.setDatabase();
    print(_database);
    return _database;
  }
}