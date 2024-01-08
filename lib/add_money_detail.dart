import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:water_reminder_app/database/database_helper.dart';
import 'package:water_reminder_app/database/databasehelper.dart';
import 'package:water_reminder_app/home.dart';
import 'package:water_reminder_app/overview.dart';
import 'database/database_helper_money.dart';
import 'database/money_note.dart';

class AddMoneyDetail extends StatefulWidget {
  MoneyNote moneynote;
  int remainprice;
  int money;
  AddMoneyDetail(this.moneynote, this.remainprice, this.money);

  @override
  State<StatefulWidget> createState() {
    return AddMoneyDetailState(this.moneynote, this.remainprice, this.money);
  }
}

bool darkThemeEnabled = false;

class AddMoneyDetailState extends State<AddMoneyDetail> {
  var _formKey = GlobalKey<FormState>();
  MoneyNote moneynote;

  DatabaseHelperMoney moneyhelper = DatabaseHelperMoney();

  DatabaseHelper1 databaseHelper1 = DatabaseHelper1();

  TextEditingController moneyController = TextEditingController();

  int remainprice;

  int money;

  AddMoneyDetailState(this.moneynote, this.remainprice, this.money);

  DatabaseCome databaseHelper = DatabaseCome();

  DatabaseHelper1 databaseHelperMoney = DatabaseHelper1();

  void _save() async {
    String input = moneyController.text;
    int intInput = int.parse(input);

    if (intInput > money || intInput > remainprice) {
      intInput > money ?
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
                          "You have not enough money to save!",
                          style: TextStyle(fontSize: 15, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }) : showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Your saved-money is over $remainprice",
                          style: TextStyle(fontSize: 15, color: Colors.red),
                        ),
                      ),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                            width: 100.0,
                            child: RaisedButton(
                              onPressed: () {
                                moneyController.text = remainprice.toString();
                                moveToLastScreen();
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(color: Colors.white),
                              ),
                              color:
                                  Theme.of(context).brightness == Brightness.dark
                                      ? Color(0xffCE8054)
                                      : Colors.green[300],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    } else {
      moveToLastScreen();

      moneynote.date = DateFormat.yMMMd().format(DateTime.now());

      int result;
      if (moneynote.id != null) {
        result = await moneyhelper.updateMoneyNote(moneynote);
      } else {
        result = await moneyhelper.insertMoneyNote(moneynote);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Save Money"),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
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
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: TextFormField(
                      controller: moneyController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "You must enter add money";
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
                          return "Add money must be number";
                        }
                      },
                      keyboardType: TextInputType.number,
                      onChanged: (_) {
                        updateMoney();
                      },
                      decoration: InputDecoration(
                        hintText: "Add Money",
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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color(0xffCE8054)
                                    : Colors.green[300],
                            textColor: Colors.white,
                            child: Text(
                              "Save",
                              textScaleFactor: 1.5,
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
                        Container(
                          width: 5,
                        ),
                        Expanded(
                          child: RaisedButton(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color(0xffCE8054)
                                    : Colors.green[300],
                            textColor: Colors.white,
                            child: Text(
                              "Cancel",
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              moveToLastScreen();
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateMoney() {
    String input = moneyController.text;
    int intInput = int.parse(input);

    if(intInput > remainprice) {
      moneynote.money = remainprice.toString();
    }else {
      moneynote.money = moneyController.text;
    }
    
    
  }

  

  void _delete() async {
    moveToLastScreen();

    if (moneynote.id == null) {
      _showAlertDialog("Status", 'No Note was deleted');
      return;
    }

    int result = await moneyhelper.deleteMoneyNote(moneynote.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
