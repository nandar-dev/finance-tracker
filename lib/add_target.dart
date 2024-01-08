import 'package:flutter/material.dart';
import 'package:water_reminder_app/database/database_helper.dart';
import 'database/note.dart';

enum Choose { Camera, Gallery }

class AddTarget extends StatefulWidget {
  final String appBarTitle;
  final Note2 note;
  AddTarget(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return AddTargetState(this.note, this.appBarTitle);
  }
}

class AddTargetState extends State<AddTarget> {
  String stringImg;

  var _formKey = GlobalKey<FormState>();

  DatabaseHelper1 helper = DatabaseHelper1();

  String appBarTitle;
  Note2 note;

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  AddTargetState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title;
    priceController.text = note.price;

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Target"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              moveToLastScreen();
            },
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(top: 15, left: 10, right: 10),
            child: ListView(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 15, left: 100, right: 100),
                    child: Image(
                      image: AssetImage("assets/images/target.png"),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Color(0xffCE8054)
                          : Colors.green[300],
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: TextFormField(
                    controller: titleController,
                    onChanged: (_) {
                      updateTitle();
                    },
                    decoration: InputDecoration(
                      hintText: "Title",
                      fillColor: Theme.of(context).brightness == Brightness.dark
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
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: TextFormField(
                    controller: priceController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please Enter Price";
                      } else if (value.contains(".") ||
                          value.contains("-") ||
                          value.contains("*") ||
                          value.contains("!") ||
                          value.contains("@") ||
                          value.contains("#") ||
                          value.contains("%") ||
                          value.contains("^") ||
                          value.contains("&") ||
                          value.contains("(") ||
                          value.contains(")") ||
                          value.contains("+")) {
                        return "Price must be number";
                      }
                    },
                    keyboardType: TextInputType.number,
                    onChanged: (_) {
                      updatePrice();
                    },
                    decoration: InputDecoration(
                      hintText: "Target Price",
                      fillColor: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade900
                          : Colors.grey.shade300,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(5),
                        ),
                      ),
                      counter: Offstage(),
                    ),
                    maxLength: 10,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 47,
                          child: RaisedButton(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color(0xffCE8054)
                                    : Colors.green[300],
                            child: Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.white,
                              ),
                              // textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  debugPrint('Save button clicked');
                                  _save();
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: 5,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updatePrice() {
    note.price = priceController.text;
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _save() async {
    moveToLastScreen();

    int result;
    if (note.id != null) {
      result = await helper.updateNote(note);
    } else {
      note.total = '0';
      result = await helper.insertNote(note);
    }
  }
}
