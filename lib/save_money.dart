import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
import 'database/database_helper_money.dart';
import 'database/money_note.dart';

class SaveMoney extends StatefulWidget {

  final String number;
  SaveMoney(this.number);

  @override
  State<StatefulWidget> createState() {
    return SaveMoneyState(this.number);
  }
}


class SaveMoneyState extends State<SaveMoney> {

  

  MoneyNote moneyNote;
  TextEditingController moneyController = TextEditingController();

  

  var _formKey = GlobalKey<FormState>();

  DatabaseHelperMoney moneyhelper = DatabaseHelperMoney();

  String number;

  SaveMoneyState(this.number);

  @override
  Widget build(BuildContext context) {

    moneyController.text = moneyNote.money;

    return WillPopScope(

      onWillPop: () {
        moveToLastScreen();
      },

        child: Scaffold(
      appBar: AppBar(
        title: Text('Save Money'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            moveToLastScreen();
          },
        ),
      ),
      body: Padding(
        key: _formKey,
        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: TextFormField(
                controller: moneyController,
                onChanged: (String value) {
                  if(value.isEmpty) {
                    return 'Please text something';
                  }
                  
                  updateMoney();
                },
                decoration: InputDecoration(
                    labelText: "Money",
                    
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            
      ),


      Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          saveMoney();
                          // print(moneyNote.money + "-" + moneyNote.number + "-" + moneyNote.date);
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 5,
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          saveMoney();
                          // print(moneyNote.money + "-" + moneyNote.number + "-" + moneyNote.date);
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateMoney() {
    moneyNote.money = moneyController.text;
  }

  void saveMoney() async {

    print(number);

    moneyNote.date = DateFormat.yMMMd().format(DateTime.now());

    moneyNote.number = number;

    int result;
    if(moneyNote.id != null) {
      result = await moneyhelper.updateMoneyNote(moneyNote);
    } else {
      result = await moneyhelper.insertMoneyNote(moneyNote);
    }

    AlertDialog(
      title: Text(moneyNote.money),
    );
  }

}
