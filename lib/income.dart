import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:water_reminder_app/database/databasehelper.dart';
import 'package:water_reminder_app/home.dart';
import 'package:water_reminder_app/models/note1.dart';

class Newnote extends StatefulWidget {
  final String appBarTitle;
  final Note3 note;
  Newnote(this.note, this.appBarTitle);
  @override
  State<StatefulWidget> createState() {
    return Newnotedetail(this.note, this.appBarTitle);
  }
}

class Newnotedetail extends State<Newnote> {
  var _formkey = GlobalKey<FormState>();

  static final validCharacters = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');

  DatabaseCome helper = DatabaseCome();
  String date = DateTime.now().toString().substring(0, 10);
  bool time = true;
  String appBarTitle;
  String mon;
  String dday;
  Note3 note;
  List<Note3> noteList;
  Map<String, dynamic> formData;

  TextEditingController salaryController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  String dropdownValue = "Choose Income Type";

  Newnotedetail(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    // String day = DateTime.now().toString().substring(0, 10);
    int bb;
    int a;
    int cc;
    int d;
    int b;
    int days;
    print(date);

    if (date == DateTime.now().toString().substring(0, 10)) {
      String aa = date.substring(0, 4);
      String ab = date.substring(5, 7);
      String ac = date.substring(8, 10);

      a = int.parse(aa);
      b = int.parse(ab);
      d = int.parse(ac);
      print(ac);
    } else if (date.length == 10) {
      String aa = date.substring(0, 4);
      String ab = date.substring(5, 7);
      String ac = date.substring(8, 10);

      a = int.parse(aa);
      b = int.parse(ab);
      d = int.parse(ac);
      print(ac);
    }

    if (a == 2020) { 
      bb = a * 366;
    } else {
      bb = a * 365;
    }
    if (b == 1 || b == 01) {
      cc = b * 31;
    } else if (b == 2 || b == 02) {
      cc = b * 28;
    } else if (b == 3 ||
        b == 03 ||
        b == 12 ||
        b == 8 ||
        b == 08 ||
        b == 7 ||
        b == 07) {
      cc = b * 31;
    } else if (b == 5 || b == 05) {
      cc = b * 29;
    } else if (b == 6 ||
        b == 06 ||
        b == 11 ||
        b == 10 ||
        b == 09 ||
        b == 9 ||
        b == 4 ||
        b == 04) {
      cc = b * 30;
    }
    days = bb + cc + d;
    amountController.text = note.incomeamount;
    noteController.text = note.note;
    // dateController.text = note.date;
    // note.date = date;
    note.come = "income";
    note.outcomeamount = "0";
    note.day = days;

    Newnotedetail(this.note, this.appBarTitle);

    if (note.salary.isEmpty || note.salary == null || note.salary == "") {
      dropdownValue = "Choose Income Type";
    } else {
      dropdownValue = note.salary;
    }
    if (dropdownValue == "Choose Income Type") {
      note.salary = "Others";
    }

    if (note.date == null) {
      date = DateTime.now().toString().substring(0, 10);
    } else if (note.date == "") {
      date = DateTime.now().toString().substring(0, 10);
    } else {
      date = note.date;
    }

    //  if(note.incomeamount == "0"){

    //  }

    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              moveToLastScreen();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {
                if (_formkey.currentState.validate()) {
                  setState(() {
                    // note.day = days;
                    _save();
                  });
                }
              },
            ),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 15, left: 10, right: 10),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade900
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: []),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 0),
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          iconSize: 24,
                          style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 18),
                          underline: Container(
                            height: 1.5,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                              note.salary = newValue;
                              // note.day = days;
                            });
                          },
                          items: <String>[
                            'Choose Income Type',
                            'Salary',
                            'Bonus',
                            'Income from sideline',
                            'Pocket Money',
                            'Profit Money',
                            'Borrow Money',
                            'Others'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
///////////////////////////////////////////////////////////////////////////

                Form(
                  key: _formkey,
                  child: Container(
                    child: Padding(
                      //Add padding around textfield
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: TextFormField(
                        controller: amountController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Enter your Amount";
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
                            return "Amount must be number";
                          } else if (value == "0") {
                            return "Please , check amount !";
                          }
                        },
                        keyboardType: TextInputType.number,
                        onChanged: (_) {
                          updateAmount();
                        },
                        decoration: InputDecoration(
                          hintText: "Amout",
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
                          counter: Offstage(),
                        ),
                        maxLength: 10,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 7,
                ),

                Container(
                  child: Padding(
                    //Add padding around textfield
                    padding: EdgeInsets.symmetric(horizontal: 0),

                    child: TextField(
                      controller: noteController,
                      onChanged: (_) {
                        updateNote();
                      },
                      decoration: InputDecoration(
                        hintText: "Note",
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
                      maxLines: 3,
                    ),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),

                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        elevation: 0,
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              theme: DatePickerTheme(
                                containerHeight: 210.0,
                              ),
                              showTitleActions: true,
                              minTime: DateTime(2000, 01, 01),
                              maxTime: DateTime(2022, 12, 31),
                              onConfirm: (date1) {
                            if (date1.month.toString().length == 1) {
                              mon = "0" + date1.month.toString();
                            } else {
                              mon = date1.month.toString();
                            }
                            if (date1.day.toString().length == 1) {
                              dday = "0" + date1.day.toString();
                            } else {
                              dday = date1.day.toString();
                            }
                            date = '${date1.year}-$mon-$dday';

                            print(date);
                            setState(() {
                              updateDate();
                            });
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.date_range,
                                          size: 20,
                                        ),
                                        Text(
                                          " $date",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        // color: Colors.white,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey.shade900
                            : Colors.grey.shade300,
                      ),
                    ],
                  ),
                ),
                // Container(
                //   child: Card(
                //     child: ListTile(
                //         title: Text(
                //           " $date",
                //           style: TextStyle(
                //               color: Theme.of(context).brightness ==
                //                       Brightness.dark
                //                   ? Colors.white
                //                   : Colors.black,
                //               fontWeight: FontWeight.w400,
                //               fontSize: 17),
                //         ),
                //         onTap: () {
                //           DatePicker.showDatePicker(context,
                //               theme: DatePickerTheme(
                //                 containerHeight: 210.0,
                //               ),
                //               showTitleActions: true,
                //               minTime: DateTime(2000, 1, 1),
                //               maxTime: DateTime(2022, 12, 31),
                //               onConfirm: (date1) {
                //             date = '${date1.year}-${date1.month}-${date1.day}';

                //             print(date);
                //             setState(() {
                //               updateDate();
                //             });
                //           },
                //               currentTime: DateTime.now(),
                //               locale: LocaleType.en);
                //         }),
                //   ),
                // )
              ],
            )),
      ),
    );
  }

  void updateSalary() {
    note.salary = formData.toString();
    print("$formData");
  }

  void updateAmount() {
    note.incomeamount = amountController.text;
  }

  void updateNote() {
    note.note = noteController.text;
  }

  void updateDate() {
    note.date = date;
    print(date);
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _delete() async {
    await helper.deleteNote(note.id);
    print(note.incomeamount);
    // moveToLastScreen();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Homes();
    }));
  }

  void _save() async {
    moveToLastScreen();
    if (note.id != null) {
      await helper.updateNote(note);
    } else {
      await helper.insertNote(note);
    }
  }
}
