// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqflite/main.dart';

import 'sqldp.dart';

class EditNote extends StatefulWidget {
  final note ;
  final title;
  final color ;
  final id ;
  const EditNote({super.key, this.note, this.title, this.color, this.id});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  Sqldp sqldp = Sqldp();  

@override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
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
           int response =await sqldp.updateData('''
           UPDATE notes SET note = "${note.text}" , title = "${title.text}" , color = "${color.text}" WHERE id = ${widget.id} 
                







''');
if(response > 0){
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home(),), (route) => false);
               

            }
          }, child: Text("Edit Note"))
            ],
          ))
        ],
      )),
    );
  }
}