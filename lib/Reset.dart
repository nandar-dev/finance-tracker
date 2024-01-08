import 'package:flutter/material.dart';
import 'package:water_reminder_app/database/database_helper.dart';
import 'package:water_reminder_app/database/database_helper_money.dart';
import 'package:water_reminder_app/database/databasehelper.dart';
import 'package:water_reminder_app/homenew.dart';

class Reset extends StatelessWidget {
  DatabaseCome helper = DatabaseCome();
  DatabaseHelper1 help = DatabaseHelper1();
  DatabaseHelperMoney help1 =DatabaseHelperMoney();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reset App"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color:Colors.white,),
            onPressed: () {
          Navigator.pop(context,true);
        
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
              ),
              Text(
                "Do you want to delete your all records?",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontSize: 16),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Color(0xffCE8054)
                          : Colors.green[300],
                      child: Text(
                        "Reset",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textScaleFactor: 1.3,
                      ),
                      onPressed: () {
                        delete();

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MyApp();
                        }));
                      },
                    ),
                  ),
                  Container(
                    width: 5,
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Color(0xffCE8054)
                          : Colors.green[300],
                      child: Text(
                        "Cancle",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textScaleFactor: 1.3,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MyApp();
                        }));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void delete() async {
    int result = await helper.deleteAll();
    await help.deleteAll();
        await help1.deleteAll();
  }
}
