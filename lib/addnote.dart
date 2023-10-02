// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqflite/main.dart';

import 'sqldp.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  Sqldp sqldp = Sqldp();  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Container(child: ListView(
        children: [
          Form(
            key: formstate,
            child: Column(
            children: [
              TextFormField(
                controller: note,
            decoration: InputDecoration(
              hintText: "Note",
            ),
          ),
          TextFormField(
            controller: title,
            decoration: InputDecoration(
              hintText: "Title",
            ),
          ),
          TextFormField(
            controller: color,
            decoration: InputDecoration(
              hintText: "Color",
            ),
          ),
          ElevatedButton(onPressed: () async {
           int response =await sqldp.insertData('''
            INSERT INTO notes (`note`,`title`,`color`)
            VALUES 
            ("${note.text}" , "${title.text}" ,"${color.text}")
            

''');
if(response > 0){
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home(),));
               

            }
          }, child: Text("Add Note"))
            ],
          ))
        ],
      )),
    );
  }
}