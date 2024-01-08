
import 'package:flutter/material.dart';
import 'package:water_reminder_app/addpasscode.dart';
import 'package:water_reminder_app/database/db_helper.dart';

import 'models/note.dart';

class SecondTab extends StatefulWidget {
  @override
  _SecondTabState createState() => _SecondTabState();
}

DatabaseHelper helper1 = DatabaseHelper();

class _SecondTabState extends State<SecondTab> {
  List<Note> passitems = new List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("second"),
      ),
      body: Container(
        child: RaisedButton(
          color: Colors.red,
          onPressed: () {
            setState(() {
              helper1.getAllNotes().then((notes) => {
                    notes.forEach(
                        (note) => {passitems.add(Note.formMapObjedt(note))})
                  });
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SetPassword(Note(''), this.passitems)));
          },
        ),
      ),
    );
  }
}
