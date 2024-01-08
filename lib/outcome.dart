import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:water_reminder_app/database/database_helper.dart';
import 'package:water_reminder_app/database/databasehelper.dart';
import 'package:water_reminder_app/home.dart';
import 'package:water_reminder_app/models/note1.dart';

class Outcome extends StatefulWidget {
  final String appBarTitle;
  final Note3 note;
  Outcome(this.note, this.appBarTitle);
  @override
  State<StatefulWidget> createState() {
    return Newnotedetail(this.note, this.appBarTitle);
  }
}

class Newnotedetail extends State<Outcome> {
  var _formkey = GlobalKey<FormState>();

  DatabaseCome helper = DatabaseCome();
  DatabaseHelper1 databaseHelperMoney = DatabaseHelper1();
  String date = DateTime.now().toString().substring(0, 10);
  String appBarTitle;
  Note3 note;
  Map<String, dynamic> formData;

  TextEditingController salaryController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  String dropdownValue = "Choose Outcome Type";

  Newnotedetail(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    String mon;
    String dday;
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

    print(finalmoney);

    amountController.text = note.outcomeamount;
    noteController.text = note.note;

    note.come = "outcome";
    note.incomeamount = "0";
    note.day = days;

    if (note.salary.isEmpty || note.salary == null || note.salary == "") {
      dropdownValue = "Choose Outcome Type";
    } else {
      dropdownValue = note.salary;
    }
    if (dropdownValue == "Choose Outcome Type") {
      note.salary = "Others";
    }

    if (note.date == null) {
      date = DateTime.now().toString().substring(0, 10);
    } else if (note.date == "") {
      date = DateTime.now().toString().substring(0, 10);
    } else {
      date = note.date;
    }
    Newnotedetail(this.note, this.appBarTitle);
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.green[300],
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
                    _save();
                  });
                  // moveToLastScreen();
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
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade900
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
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
                            });
                          },
                          items: <String>[
                            'Choose Outcome Type',
                            'Food',
                            'Electronic',
                            'Clothing',
                            'Accessories',
                            'Revenue',
                            'Phone Bill',
                            'Present',
                            'Vahicle',
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
                        keyboardType: TextInputType.number,
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
                          }
                        },
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
                      // decoration: InputDecoration(
                      //   //Add th Hint text here.
                      //   hintText: "Note",
                      //   border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(10.0),
                      //   ),
                      // ),
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
                        elevation: 4.0,
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              theme: DatePickerTheme(
                                containerHeight: 210.0,
                                // backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300,
                              ),
                              showTitleActions: true,
                              minTime: DateTime(2000, 1, 1),
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
                                          size: 20.0,
                                          // color: Colors.teal,
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
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey.shade900
                            : Colors.grey.shade300,
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void updateSalary() {
    // note.salary = salaryController.text;

    note.salary = formData.toString();
    print("$formData");
  }

  void updateAmount() {
    note.outcomeamount = amountController.text;
  }

  void updateNote() {
    note.note = noteController.text;
  }

  void updateDate() {
    note.date = date;
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _delete() async {
    await helper.deleteNote(note.id);
    print(note.incomeamount);

    moveToLastScreen();
  }

  void _save() async {
    String input = amountController.text;

    int intInput = int.parse(input);

    if (intInput > finalmoney) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "You have not enough money to spend!",
                          style: TextStyle(fontSize: 15, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    } else {
      moveToLastScreen();
      if (note.id != null) {
        await helper.updateNote(note);
      } else {
        await helper.insertNote(note);
      }
    }

    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return MyApp();
    // }));
  }
  // void moveToLastScreen() {
  //   Navigator.pop(context, true);
  // }
}
