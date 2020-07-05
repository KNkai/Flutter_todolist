import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection{
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "todoDb");
    var database = openDatabase(path, version:1, onCreate: _onCreateDatabase);
    return database;
  }
    
  _onCreateDatabase(Database db, int version)async{
    await db.execute("CREATE TABLE categories(id INTEGER PRIMARY KEY, title TEXT, description TEXT)");
    await db.execute("""
      CREATE TABLE todo(
        id INTEGER PRIMARY KEY, 
        idcate INTEGER,
        detail TEXT, 
        date_create TEXT, 
        date_fake_finish TEXT, 
        date_real_finish TEXT, 
        isdone INTEGER,
        FOREIGN KEY (idcate) REFERENCES categories (id) ON DELETE NO ACTION ON UPDATE NO ACTION
      )""");
  }
}