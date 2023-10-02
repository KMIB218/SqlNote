import 'package:flutter/material.dart';
import 'package:flutter_sqflite/addnote.dart';
import 'package:flutter_sqflite/sqldp.dart';

import 'editnote.dart';

void main()async {
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
title: "Sqflite Course",
home: Home(),
routes: {
"addnote" : (context) => AddNote(),
"editnote": (context) =>  EditNote(),


},
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 List notes = [];
 bool islodaing = true ;
 Sqldp sqldp = Sqldp(); //!:Create Instance From 'Class Sqldp' 
  //!: Get The Information I Added It From 'Class Sqldp' 
  Future readData() async {
    List<Map> response = await sqldp.readData("SELECT * FROM 'notes'");
    notes.addAll(response);
    islodaing = false ;
    if(this.mounted){
setState(() {
  
});
    }
    
  }
@override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNote(),));
      },),
      appBar: AppBar(
        title: const Text('Notes App'),
      ),
      body:islodaing == true ? Center(child: CircularProgressIndicator(),) : Container(
        child: ListView(
          children: [
            // ElevatedButton(onPressed: () async {
            //  await sqldp.mydelete();
            //  print("=========================");
            //  print("Deleted");
            //  print("=========================");
             
            // }, child: Text("Delet DataBase")),
               ListView.builder(itemCount: notes.length,shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemBuilder: (context, index) {
                     return Card(child: ListTile(leading: IconButton(onPressed: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditNote(
                        color:notes[index]['color'], 
                        note: notes[index]['note'],
                        title:notes[index]['title'],
                        id: notes[index]['id'],
                        

                        ),));
                     }, icon: Icon(Icons.edit,color: Colors.black,)),trailing: IconButton(onPressed: () async {
                       int response =await sqldp.deleteData("DELETE FROM notes WHERE id = ${notes[index]['id']} ");
                       if(response > 0){
                            notes.removeWhere((element) => element['id'] == notes[index]['id'] );
                            setState(() {
                              
                            });
                       }
                     }, icon: Icon(Icons.delete,color:Colors.red,)),title: Text("${notes[index]['note']}"),subtitle:Text("${notes[index]['title']}"), ),);
                   },)
                
                
              
          ],
        ),
      )
    );
  }
}

