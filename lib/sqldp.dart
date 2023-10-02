import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqldp {
static Database? _db ;
Future<Database?> get db async{ //!: This Function To Initialized For one time Not More...
  if(_db == null){
     _db = await inital();
     return _db ;
  }else{
    return _db ;
  }

}


//!:1-Create Function For Initialized For Sqflite...
inital() async {
String databasepath = await getDatabasesPath(); //*:getDatabasesPath() => A Ready Function To Locate(Get the default databases location)
//!:2-Choose Database's Name...
String path = join(databasepath ,'Kareem.db');
//!:3-To Create DataBase...
Database mydb = await openDatabase(path ,onCreate: _onCreate , version: 11 , onUpgrade: _onUpgrade);
return mydb ;
}

_onUpgrade(Database db , int oldversion , int newversion) async { //*:This Function For Changing The Version 
print("=====================================");
print("onUpgrade");
print("=====================================");
// await db.execute("ALTER TABLE notes ADD COLUMN 'color' TEXT");
}

_onCreate(Database db , int version)async { //*:OnCreate For Creating Tables & Import For One Time
//!:"Batch" It's For Creating Another Table Or More...

Batch batch = db.batch(); //*: Store 'db' In 'batch' And Use 'batch' For Making Any Table...
 batch.execute('''
Create TABLE "notes" (
"id" INTEGER  Not Null PRIMARY KEY AUTOINCREMENT ,
'title' TEXT NOT NULL,
"note" TEXT NOT NULL,
"color" TEXT NOT NULL




)

''');

await batch.commit(); //!:This To Do All Instruction For One Time Not More...
print("=====================================");
print("Create DataBase And Table");
print("=====================================");
}
readData(String sql) async { //!:4-This Function For Getting The Information From DataBase...
Database? mydb = await db ;
Future<List<Map<String, Object?>>> response = mydb!.rawQuery(sql);
return response ;
}
insertData(String sql) async { //!:4-This Function For Inserting The Information To DataBase...
Database? mydb = await db ;
Future<int> response = mydb!.rawInsert(sql);
return response ;
}
updateData(String sql) async { //!:4-This Function For Updating The Information DataBase...
Database? mydb = await db ;
Future<int> response = mydb!.rawUpdate(sql);
return response ;
}
deleteData(String sql) async { //!:4-This Function For Deleting The Information DataBase...
Database? mydb = await db ;
Future<int> response = mydb!.rawDelete(sql);
return response ;
}

//!:For Deleting DataBase Should Use This Function...
mydelete() async {
String databasepath = await getDatabasesPath(); //*:getDatabasesPath() => A Ready Function To Locate(Get the default databases location)
//!:2-Choose Database's Name
String path = join(databasepath ,'Kareem.db');

await deleteDatabase(path);
}

}