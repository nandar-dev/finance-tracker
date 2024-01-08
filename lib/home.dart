import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:water_reminder_app/database/database_helper_money.dart';
import 'package:water_reminder_app/database/databasehelper.dart';
import 'package:water_reminder_app/database/money_note.dart';
import 'package:water_reminder_app/income.dart';
import 'package:water_reminder_app/models/note1.dart';
import 'package:water_reminder_app/outcome.dart';

int fromint;
int toint;
String fromdate;
String todate;
String mon;
String dday;
String sala;
String dada;
String aa;
String inco;
int inco1;
int fromincomeprice = 0;
int toincomeprice = 0;
int totalincomeprice = 0;
int totaloutcomeprice = 0;
int finalmoney = 0;
int inn;
int out;
int totalallprice = 0;
int totalBalance;
String dropdownValue = 'Daily';
String check = '';
int hwpincome;
int hwpoutcome;

class Homes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeLists();
  }
}

enum PopupMenuChoices { first, second, third, fourth }

class HomeLists extends State<Homes> {
  Note3 note;
  String date = DateTime.now().toString().substring(0, 10);
  DatabaseCome databaseHelper = DatabaseCome();
  List<MoneyNote> money = new List();
  DatabaseHelperMoney databaseHelperMoney = DatabaseHelperMoney();
  List<Note3> passitems = new List();
  List<Note3> noteList;
  List<Note3> menuList;

  List<Note3> items = new List();
  int count = 0;
  bool colo = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    updateListView();
    int aa = totaloutcomeprice + totalallprice;
    finalmoney = totalincomeprice - aa;
    totalBalance = finalmoney + totalallprice;

    //  if (fromincomeprice == 0) {
    //   incomefrom();
    // } else if (totalincomeprice != 0) {
    //   incomefrom();
    // }
    if (totalincomeprice == 0) {
      incometotal();
    } else if (totalincomeprice != 0) {
      incometotal();
    }

    if (totaloutcomeprice == 0) {
      outcometotal();
    } else if (totaloutcomeprice != 0) {
      outcometotal();
    }

    if (totalallprice == 0) {
      getAllTotal();
    } else if (totalallprice != 0) {
      getAllTotal();
    }
    hwpincome = fromincomeprice == 0 ? totalincomeprice : fromincomeprice;

    hwpoutcome = toincomeprice == 0 ? totaloutcomeprice : toincomeprice;
    if (noteList == null) {
      noteList = List<Note3>();
      updateListView();
    }

    if (Theme.of(context).brightness == Brightness.light) {
      return WillPopScope(
        onWillPop: () {
          exit(0);
        },
        child: Scaffold(
          body: Center(
            child: Container(
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 700,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/nn2.png'),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 30,
                          // left: 80,
                          left: 10,
                          child: Center(
                            child: Text(
                              "  Current Balance",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 10,
                          child: PopMenu(),
                        ),
                        Positioned(
                          top: 65,
                          // left: 155,
                          left: 22,
                          child: Center(
                            child: Text(
                              "$finalmoney",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 115, horizontal: 10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    height: size.height / 9 + 50,
                                    width: size.width / 2 - 20,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      elevation: 10,
                                      child: FlatButton(
                                        onPressed: () {
                                          navigate(
                                              Note3(
                                                  '', '', '', '', '', '', null),
                                              'Income');
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 20),
                                              child: Center(
                                                child: Text(
                                                  "Income",
                                                  style: TextStyle(
                                                      color: Colors.green[300],
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 00.1),
                                                child: Text(
                                                  "+" + "$hwpincome",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 20),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Outcome

                                  Container(
                                    height: size.height / 9 + 50,
                                    width: size.width / 2 - 20,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      elevation: 10,
                                      child: FlatButton(
                                        onPressed: () {
                                          navigate1(
                                              Note3(
                                                  '', '', '', '', '', '', null),
                                              'Outcome');
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 20),
                                              child: Center(
                                                child: Text(
                                                  "Outcome",
                                                  style: TextStyle(
                                                      color: Colors.red[400],
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 00.1),
                                                child: Text(
                                                  "-" + "$hwpoutcome",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 20),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          child: Padding(
                            padding: EdgeInsets.only(top: 250),
                            child: getNoteListView(),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ////////////////////////////
        ),
      );
    } else {
      return WillPopScope(
        onWillPop: () {
          exit(0);
        },
        child: Scaffold(
          body: Container(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 700,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/hhh.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 30,
                        // left: 80,
                        left: 10,
                        child: Center(
                          child: Text(
                            "  Current Balance",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 10,
                        child: PopMenu(),
                      ),
                      Positioned(
                        top: 65,
                        // left: 155,
                        left: 22,
                        child: Center(
                          child: Text(
                            "$finalmoney",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 115, horizontal: 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  height: size.height / 9 + 50,
                                  width: size.width / 2 - 20,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    elevation: 10,
                                    child: FlatButton(
                                      onPressed: () {
                                        navigate(
                                            Note3('', '', '', '', '', '', null),
                                            'Income');
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 20),
                                            child: Center(
                                              child: Text(
                                                "Income",
                                                style: TextStyle(
                                                    color: Colors.green[300],
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(top: 00.1),
                                              child: Text(
                                                "+" + "$hwpincome",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 20),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // Outcome

                                Container(
                                  height: size.height / 9 + 50,
                                  width: size.width / 2 - 20,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    elevation: 10,
                                    child: FlatButton(
                                      onPressed: () {
                                        navigate1(
                                            Note3('', '', '', '', '', '', null),
                                            'Outcome');
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 20),
                                            child: Center(
                                              child: Text(
                                                "Outcome",
                                                style: TextStyle(
                                                    color: Colors.red[400],
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(top: 00.1),
                                              child: Text(
                                                "-" + "$hwpoutcome",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 20),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        child: Padding(
                          padding: EdgeInsets.only(top: 250),
                          child: getNoteListView(),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  ListView getNoteListView() {
    Icon icon;

    return ListView.builder(
      // padding: EdgeInsets.symmetric(vertical: 33),
      padding: EdgeInsets.only(bottom: 95),
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        if (this.noteList[position].salary == "Choose Income Type") {
          icon = Icon(
            Icons.add_location,
            color: Colors.green,
          );
        } else if (this.noteList[position].salary == "Choose Outcome Type") {
          icon = Icon(
            Icons.announcement,
            color: Colors.red,
          );
        }
        if (this.noteList[position].salary == "Salary") {
          icon = Icon(
            Icons.attach_money,
            color: Colors.green,
          );
        } else if (this.noteList[position].salary == "Bonus") {
          icon = Icon(
            MdiIcons.percentOutline,
            color: Colors.blue[200],
          );
        } else if (this.noteList[position].salary == "Income from sideline") {
          icon = Icon(Icons.sentiment_very_satisfied, color: Colors.orange);
        } else if (this.noteList[position].salary == "Pocket Money") {
          icon = Icon(
            Icons.account_balance_wallet,
            color: Colors.pink,
          );
        } else if (this.noteList[position].salary == "Profit Money") {
          icon = Icon(
            Icons.insert_chart,
            color: Colors.deepPurple,
          );
        } else if (this.noteList[position].salary == "Borrow Money") {
          icon = Icon(
            Icons.money_off,
            color: Colors.red,
          );
        } else if (this.noteList[position].salary == "Food") {
          icon = Icon(Icons.fastfood, color: Colors.deepOrangeAccent[100]);
        } else if (this.noteList[position].salary == "Electronic") {
          icon = Icon(Icons.lightbulb_outline, color: Colors.lightBlue[100]);
        } else if (this.noteList[position].salary == "Clothing") {
          icon = Icon(Icons.accessibility_new, color: Colors.black);
        } else if (this.noteList[position].salary == "Revenue") {
          icon = Icon(Icons.receipt, color: Colors.grey);
        } else if (this.noteList[position].salary == "Phone Bill") {
          icon = Icon(Icons.phone_android, color: Colors.blue[600]);
        } else if (this.noteList[position].salary == "Present") {
          icon = Icon(Icons.favorite, color: Colors.red);
        } else if (this.noteList[position].salary == "Accessories") {
          icon = Icon(Icons.local_grocery_store, color: Colors.blueGrey);
        } else if (this.noteList[position].salary == "Vahicle") {
          icon = Icon(Icons.directions_car, color: Colors.red);
        } else {
          icon = Icon(Icons.add_location, color: Colors.green[300]);
        }

        if (this.noteList[position].incomeamount == "0") {
          if (this.noteList[position].date == null) {
            dada = DateTime.now().toString().substring(0, 10);
          } else if (this.noteList[position].date == "") {
            dada = DateTime.now().toString().substring(0, 10);
          } else {
            dada = this.noteList[position].date.toString();
          }
          if (this.noteList[position].salary == "") {
            sala = "other outcome";
          } else if (this.noteList[position].salary == "Choose Outcome Type") {
            sala = "other outcome";
          } else {
            sala = this.noteList[position].salary.toString();
          }
          return Card(
            color: Theme.of(context).brightness == Brightness.dark
                ? Color(0xff424242)
                : Colors.grey[300],
            elevation: 0,
            child: ListTile(
                leading: (icon),
                title: Text(
                  "$sala",
                  maxLines: 2,
                ),
                subtitle: Text(
                  "$dada",
                ),
                trailing: Text(
                  this.noteList[position].outcomeamount + "  " + "MMK",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
                  maxLines: 2,
                ),
                onTap: () {
                  navigateout(this.noteList[position], 'Outcome Edit');
                  updateDate();

                  int aa = this.noteList[position].outcomeamount as int;
                  // print("date form database$aa");
                },
                onLongPress: () {
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
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      "Do you want to delete?",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Center(
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 18,
                                        ),
                                        SizedBox(
                                          width: 100.0,
                                          child: RaisedButton(
                                            onPressed: () {
                                              _delete(
                                                  context, noteList[position]);

                                              updateListView();
                                              moveToLastScreen();
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color:
                                                Theme.of(context).brightness ==
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
                                              moveToLastScreen();
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Color(0xffCE8054)
                                                    : Colors.green[300],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }),
          );
        } else {
          if (this.noteList[position].date == null) {
            dada = DateTime.now().toString().substring(0, 10);
          } else if (this.noteList[position].date == "") {
            dada = DateTime.now().toString().substring(0, 10);
          } else {
            dada = this.noteList[position].date.toString();
          }

          if (this.noteList[position].salary == "") {
            sala = "other income";
          } else if (this.noteList[position].salary == "Choose Income Type") {
            sala = "other income";
          } else {
            sala = this.noteList[position].salary;
          }
          return Card(
            color: Theme.of(context).brightness == Brightness.dark
                ? Color(0xff424242)
                : Colors.grey[300],
            elevation: 0,
            child: ListTile(
                leading: (icon),
                title: Text(
                  "$sala",
                  maxLines: 2,
                ),
                subtitle: Text("$dada"),
                trailing: Text(
                  this.noteList[position].incomeamount + "  " + "MMK",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.w700),
                  maxLines: 2,
                ),
                onTap: () {
                  // print(this.noteList[position].day);
                  navigatein(this.noteList[position], 'Income Edit');
                  // print(this.noteList[position].id);
                },
                onLongPress: () {
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
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Center(
                                      child: Text(
                                        "Do you want to delete?",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        // SizedBox(
                                        //   width: 18,
                                        // ),
                                        SizedBox(
                                          width: 100.0,
                                          child: RaisedButton(
                                            onPressed: () {
                                              _delete(
                                                  context, noteList[position]);

                                              moveToLastScreen();
                                              updateListView();
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Color(0xffCE8054)
                                                    : Colors.green[300],
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 20,
                                        // ),
                                        SizedBox(
                                          width: 100.0,
                                          child: RaisedButton(
                                            onPressed: () {
                                              moveToLastScreen();
                                              // Navigator.push(context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) {
                                              //   return Homes();
                                              // }));
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Color(0xffCE8054)
                                                    : Colors.green[300],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }),
          );
        }
      },
    );
  }

  void incometotal() async {
    var total = (await databaseHelper.totalIncome())[0]['Total'];

    setState(() {
      if (total == 0) {
        totalincomeprice = 0;
      } else if (total == null) {
        totalincomeprice = 0;
      } else {
        totalincomeprice = total;
      }
    });
  }

  void incomefrom() async {
    var total =
        (await databaseHelper.totalFromIncome(fromint, toint))[0]['Total'];

    setState(() {
      if (total == 0) {
        fromincomeprice = 0;
      } else if (total == null) {
        fromincomeprice = 0;
      } else {
        fromincomeprice = total;
        print(fromincomeprice);
      }
    });
  }

  void outcomefrom() async {
    var total =
        (await databaseHelper.totalToIncome(fromint, toint))[0]['Total'];

    setState(() {
      if (total == 0) {
        toincomeprice = 0;
      } else if (total == null) {
        toincomeprice = 0;
      } else {
        toincomeprice = total;
        print(fromincomeprice);
      }
    });
  }

  void updateListView() async {
    final Future<Database> dbFuture = databaseHelper.initalizeDatabase();
    if (check == "income") {
      await dbFuture.then((database) {
        Future<List<Note3>> noteListFuture = databaseHelper.soesantun();
        noteListFuture.then((noteList) {
          setState(() {
            this.noteList = noteList;
            this.count = noteList.length;
          });
        });
      });
    } else if (check == "outcome") {
      await dbFuture.then((database) {
        Future<List<Note3>> noteListFuture = databaseHelper.getOutcome();
        noteListFuture.then((noteList) {
          setState(() {
            this.noteList = noteList;
            this.count = noteList.length;
          });
        });
      });
    } else if (check == "daily") {
      await dbFuture.then((database) {
        Future<List<Note3>> noteListFuture = databaseHelper.getNoteList();
        noteListFuture.then((noteList) {
          setState(() {
            this.noteList = noteList;
            this.count = noteList.length;
          });
        });
      });
    } else if (check == "monthly") {
      await dbFuture.then((database) {
        Future<List<Note3>> noteListFuture =
            databaseHelper.getMonth(fromint, toint);
        noteListFuture.then((noteList) {
          setState(() {
            this.noteList = noteList;
            this.count = noteList.length;
          });
          // for (int i = 0; i <= noteList.length; i++) {
          //   String sum = noteList[i].incomeamount;
          //   int income = int.parse(sum);

          //   fromincomeprice = fromincomeprice + income;
          //   print("incom" + "$income");
          //   // result = result + fromincomeprice;
          //   String sum1 = noteList[i].outcomeamount;
          //   toincomeprice = int.parse(sum1);
          //   // print(toincomeprice);

          //   // result1 = result1 + toincomeprice;
          // }
        });
      });
      incomefrom();
      outcomefrom();
    } else {
      await dbFuture.then((database) {
        Future<List<Note3>> noteListFuture = databaseHelper.getNoteList();
        noteListFuture.then((noteList) {
          setState(() {
            this.noteList = noteList;
            this.count = noteList.length;
          });
        });
      });
    }
  }

  void outcometotal() async {
    // print("Sdfsf");
    var total = (await databaseHelper.totalOutcome())[0]['Total'];
    // print('$total');
    setState(() {
      if (total == 0) {
        totaloutcomeprice = 0;
      } else if (total == null) {
        totaloutcomeprice = 0;
      } else {
        totaloutcomeprice = total;
      }
    });
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _delete(BuildContext context, Note3 note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result == 0) {
      updateListView();
      moveToLastScreen();
    }
  }

  void delete() async {
    int result = await databaseHelper.deleteAll();
    if (result == 0) {
      updateListView();
    }
  }

  void navigate(Note3 note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Newnote(note, title);
    }));
    if (result == true) {
      updateListView();
    }
  }

  void updateDate() {
    note.date = date;
  }

  void navigatein(Note3 note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Newnote(note, title);
    }));
    if (result == true) {
      updateListView();
    }
  }

  void navigateout(Note3 note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Outcome(note, title);
    }));
    if (result == true) {
      updateListView();
    }
  }

  void navigate1(Note3 note, String title) async {
    if (finalmoney == 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "You have no balance!",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    } else {
      bool result =
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Outcome(note, title);
      }));
      if (result == true) {
        updateListView();
      }
    }
  }

  void movedBack() {}

  void getAllTotal() async {
    var total = (await databaseHelperMoney.getAllTotal())[0]['AllTotal'];

    setState(() {
      totalallprice = total;
      if (total == null) {
        totalallprice = 0;
      }
    });
  }
}

class PopMenu extends StatefulWidget {
  @override
  _PopMenuState createState() => _PopMenuState();
}

class _PopMenuState extends State<PopMenu> {
  String date;
  bool time = true;
  String appBarTitle;
  String mon;
  String dday;
  Note3 note;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) => onMenuSelection(
        value,
      ),
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      itemBuilder: (context) {
        return [
          const PopupMenuItem<PopupMenuChoices>(
            value: PopupMenuChoices.first,
            child: Text(
              'Daily',
              style: TextStyle(color: Color(0xffCE8054)),
            ),
          ),
          PopupMenuItem<PopupMenuChoices>(
            value: PopupMenuChoices.second,
            child: Text(
              'Income List',
              style: TextStyle(color: Colors.green),
            ),
          ),
          PopupMenuItem<PopupMenuChoices>(
            value: PopupMenuChoices.third,
            child: Text(
              'Outcome List',
              style: TextStyle(color: Colors.red),
            ),
          ),
          const PopupMenuItem<PopupMenuChoices>(
            value: PopupMenuChoices.fourth,
            child: Text(
              'Monthly List',
              style: TextStyle(color: Color(0xffCE8054)),
            ),
          ),
        ];
      },
    );
  }

  void onMenuSelection(
    PopupMenuChoices value,
  ) async {
    switch (value) {
      case PopupMenuChoices.first:
        // Navigator.push(context, MaterialPageRoute(builder: (context){
        check = "daily";
        Homes();
        // }));
        break;
      case PopupMenuChoices.second:
        check = "income";
        break;
      case PopupMenuChoices.third:
        check = "outcome";
        break;
      case PopupMenuChoices.fourth:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: FromTo(),
              );
            });

        break;
      default:
    }
  }
}

class FromTo extends StatefulWidget {
  @override
  _FromToState createState() => _FromToState();
}

class _FromToState extends State<FromTo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              // labelText: "   From Date",
              hintText: fromdate == null
                  ? "    From Date"
                  : "    From Date  ->   $fromdate",
              hintStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,

                // fontWeight: FontWeight.bold
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.green[300]
                      : Color(0xffCE8054),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xfff0e68c)),
              ),
            ),
            onTap: () {
              DatePicker.showDatePicker(context,
                  theme: DatePickerTheme(
                    containerHeight: 210.0,
                  ),
                  showTitleActions: true,
                  minTime: DateTime(2000, 01, 01),
                  maxTime: DateTime(2022, 12, 31), onConfirm: (date2) {
                // date =
                //     '${date1.year}-${date1.month}-${date1.day}';
                if (date2.month.toString().length == 1) {
                  mon = "0" + date2.month.toString();
                } else {
                  mon = date2.month.toString();
                }
                if (date2.day.toString().length == 1) {
                  dday = "0" + date2.day.toString();
                } else {
                  dday = date2.day.toString();
                }
                fromdate = '${date2.year}-$mon-$dday';

                setState(() {
                  String aa = fromdate.substring(0, 4);
                  String ab = fromdate.substring(5, 7);
                  String ac = fromdate.substring(8, 10);

                  int a = int.parse(aa);
                  int b = int.parse(ab);
                  int d = int.parse(ac);
                  int bb;
                  int cc;
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
                  fromint = bb + cc + d;
                });
              }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
          ),
          SizedBox(height: 5),
          TextFormField(
            decoration: InputDecoration(
              hintText: todate == null
                  ? "    To Date   "
                  : "    To Date      ->   $todate",
              hintStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,

                // fontWeight: FontWeight.bold
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.green[300]
                      : Color(0xffCE8054),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xfff0e68c)),
              ),
            ),
            onTap: () {
              DatePicker.showDatePicker(context,
                  theme: DatePickerTheme(
                    containerHeight: 210.0,
                  ),
                  showTitleActions: true,
                  minTime: DateTime(2000, 01, 01),
                  maxTime: DateTime(2022, 12, 31), onConfirm: (date1) {
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
                todate = '${date1.year}-$mon-$dday';

                setState(() {
                  String aa = todate.substring(0, 4);
                  String ab = todate.substring(5, 7);
                  String ac = todate.substring(8, 10);

                  int a = int.parse(aa);
                  int b = int.parse(ab);
                  int d = int.parse(ac);
                  int bb;
                  int cc;
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
                  toint = bb + cc + d;
                });
              }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
          ),
          SizedBox(height: 8),
          RaisedButton(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.green[300]
                  : Color(0xffCE8054),
              child: Text(
                "Search",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  check = "monthly";

                  Navigator.pop(context, true);
                });
              })
        ],
      ),
    );
  }
}
