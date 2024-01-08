import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:water_reminder_app/database/db_helper.dart';
import 'package:water_reminder_app/database/login.dart';
import 'package:water_reminder_app/homenew.dart';
import 'models/note.dart';

class SetPassword extends StatefulWidget {
  final Note note1;

  List<Note> passitems = new List();
  SetPassword(this.note1, this.passitems);

  @override
  State<StatefulWidget> createState() {
    return _SetPasswordState(this.note1, this.passitems);
  }
}

class _SetPasswordState extends State<SetPassword> {
  bool check = true;
  var count = 0;
  Note note1;
  var db_currentpassword;
  List<Note> passitems = new List();
  _SetPasswordState(this.note1, this.passitems);
  DatabaseHelper helper = DatabaseHelper();
  List<Note> items = new List();
  List<Note> noteList = new List();
  var _formkey = GlobalKey<FormState>();

  @override
  TextEditingController newpassword = TextEditingController();
  TextEditingController retypenewpassword = TextEditingController();
  TextEditingController currentpassword = TextEditingController();
  TextEditingController oldController = TextEditingController();
  Widget build(BuildContext context) {
    helper.getAllNotes().then((notes) async {
      notes.forEach((note) {
        items.add(Note.formMapObjedt(note));
      });
    });
    updateListView();
    TextStyle textStyle = Theme.of(context).textTheme.title;

    if (items.length == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Set PassCode'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        setState(() {
                          _save();
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.only(),
            child: ListView(
              children: <Widget>[
//            Second Element
                Padding(
                    padding: EdgeInsets.only(top: 15, left: 0, right: 0),
                    child: Container(
                      height: 85,
                      width: 180,
                      child: ListTile(
                        title: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          controller: newpassword,
                          validator: (String value) {
                            if (value == "" || value == null) {
                              return "Please fill your passcode";
                            } else if (value.length < 4 || value.length > 6) {
                              return "PassCode's length should have between 4 and 6";
                            }
                            // if () {
                            //
                            // }
                          },
                          onChanged: (value) {
                            updateName();
                          },
                          decoration: InputDecoration(
                            hintText: "New PassCode",
                            fillColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade300,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
//            Third Element
                Padding(
                    padding: EdgeInsets.only(top: 15, left: 0, right: 0),
                    child: Container(
                      height: 85,
                      child: ListTile(
                        title: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          controller: retypenewpassword,
                          validator: (String value) {
                            if (value == "" || value == null) {
                              return "Please fill your passcode";
                            } else if (value != newpassword.text) {
                              return "Wrong Retype PassCode";
                            }
                          },
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            hintText: "Retype new PassCode",
                            fillColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade300,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Change PassCode'),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: IconButton(
                icon: Icon(Icons.clear_all),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0)), //this right here
                          child: Container(
                            height: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // TextFormField(

                                  TextFormField(
                                    controller: oldController,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Color(0xffCE8054)
                                                    : Colors.green[300],
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Color(0xffCE8054)
                                                    : Colors.green[300],
                                          ),
                                        ),
                                        border: InputBorder.none,
                                        hintText:
                                            '            Retype Old PassCode'),
                                    obscureText: true,
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 18,
                                      ),
                                      SizedBox(
                                        width: 100.0,
                                        child: RaisedButton(
                                          onPressed: () {
                                            // _delete();

                                            if (oldController.text ==
                                                items[0].password) {
                                              _delete();
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return MyApp();
                                              }));
                                            } else {
                                              print("wrong");
                                            }
                                          },
                                          child: Text(
                                            "Save",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Color(0xffCE8054)
                                              : Colors.green[300],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 100.0,
                                        child: RaisedButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return MyApp();
                                            }));
                                          },
                                          child: Text(
                                            "Cancel",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Color(0xffCE8054)
                                              : Colors.green[300],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
        body: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ListView(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                    child: Container(
                      height: 85,
                      child: TextFormField(
                        obscureText: true,
                        controller: currentpassword,
                        keyboardType: TextInputType.number,
                        validator: (String value) {
                          if (currentpassword.text != db_currentpassword ||
                              currentpassword == null) {
                            return "Wrong PassCode";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Current PassCode",
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey.shade900
                                  : Colors.grey.shade300,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 13, left: 5, right: 5),
                    child: Container(
                      height: 85,
                      child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        controller: newpassword,
                        validator: (String value) {
                          if (value.length < 4 || value.length > 6) {
                            return "PassCode's length should have between 4 and 6 ";
                          }
                        },
                        onChanged: (value) {
                          updateName();
                        },
                        decoration: InputDecoration(
                          hintText: "New PassCode",
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey.shade900
                                  : Colors.grey.shade300,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 13, left: 5, right: 5),
                    child: Container(
                      height: 85,
                      child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        controller: retypenewpassword,
                        validator: (String value) {
                          if (value != newpassword.text) {
                            return "Must be same with new PassCode";
                          }
                        },
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          hintText: "Retype new PassCode",
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey.shade900
                                  : Colors.grey.shade300,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xffCE8054)
                      : Colors.green[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    db_currentpassword = items[0].password;
                    if (_formkey.currentState.validate()) {
                      setState(() {
                        _save2();
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Change',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  void updateListView() async {
    final Future<Database> dbFuture = helper.initializedDatabase();
    await dbFuture.then((database) {
      Future<List<Note>> noteListFuture = helper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  void _save() async {
    print("You Clicked Save Button");
    int result;
    if (this.passitems.length >= 1) {
      result = await helper.updateNote(note1);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Login();
      })); //save function
    } else {
      result = await helper.insertNote(note1);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Login();
      }));
      //update
    }
  }

  void _save2() async {
    print("You Clicked Save Button");
    int result;
    if (this.passitems.length >= 1) {
      result = await helper.updateNote(note1);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Login();
      })); //save function
    } else {
      result = await helper.insertNote(note1);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Login();
      }));
      //update
    }
  }

  void _delete() async {
    Note note;
    await helper.delete();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyApp();
    }));
  }

  void navigateToPassword(Note note1, List<Note> passitems) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SetPassword(note1, passitems);
    }));
    if (result == true) {}
  }

  void movedBack() {
    Navigator.pop(context, true);
  }

  void updateName() {
    note1.password = newpassword.text;
  }
}
