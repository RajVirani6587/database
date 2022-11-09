import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper{
  Database?db;

  Future<Database> checkDatabase()async{
    if(db!=null)
      {
        return db!;
      }
    else
      {
        return await createDatabase();
      }
  }

 Future<Database> createDatabase()async{
    Directory  folder = await getApplicationDocumentsDirectory();
    String  path =   join(folder.path,"rnw.db");
    return  openDatabase(path,version:1,onCreate:(db,version){
      String query = "CREATE TABLE std(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,std TEXT,mobile TEXT)";
      db.execute(query);
    });
  }

  void insertData(String n1,String s1 ,String m1)async{
    db =  await checkDatabase();
    db!.insert("std", {"name":n1,"std":s1,"mobile":m1,});
  }

  Future<List<Map>> readData()async{
    db= await checkDatabase();
     String query = "SELECT * FROM std";
     List<Map> StdList = await db!.rawQuery(query,null);
     return StdList;
  }

  void deletedata(String id)async{
    db= await checkDatabase();
     db!.delete("std",where: "id = ?",whereArgs: [int.parse(id)]);
  }

  void updatedata(String id,String n1, String m1,String s1)async{
    db= await checkDatabase();
    db!.update("std", {"name":n1,"mobile":m1,"std":s1},where:"id = ?",whereArgs: [int.parse(id)]);
  }

}
