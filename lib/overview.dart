import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:water_reminder_app/add_money_detail.dart';
import 'package:water_reminder_app/database/database_helper.dart';
import 'package:water_reminder_app/database/databasehelper.dart';
import 'package:water_reminder_app/home.dart';
import 'add_money.dart';
import 'database/database_helper_money.dart';
import 'database/money_note.dart';
import 'database/note.dart';
import 'package:confetti/confetti.dart';

class Overview extends StatefulWidget {
  String type;
  String name;
  String price;

  Overview(this.type, this.name, this.price);

  @override
  State<StatefulWidget> createState() {
    return OverviewState(this.type, this.name, this.price);
  }
}

class OverviewState extends State<Overview> {
  ConfettiController myController;
  DatabaseHelperMoney databaseHelperMoney = DatabaseHelperMoney();

  DatabaseHelper1 databaseHelper1 = DatabaseHelper1();

  DatabaseCome databaseHelper = DatabaseCome();

  List<Note2> noteList;

  int count = 7;

  String type;

  String name;

  String price;

  int intprice;

  int totalprice;

  int remainprice = 0;

  double percent;

  String stringTotal;

  int totalincomeprice = 0;
  int totaloutcomeprice = 0;
  int finalmoney = 0;

  OverviewState(this.type, this.name, this.price);

  @override
  void initState() {
    myController = ConfettiController(duration: Duration(seconds: 10));
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    int aa = totaloutcomeprice + totalallprice;
    finalmoney = totalincomeprice - aa;
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

    if (totalprice == 0) {
      getTotal();
    } else if (totalprice != 0) {
      getTotal();
    }

    stringTotal = totalprice.toString();

    double percenticon;
    int intpercenticon;
    double realpercent;

    intprice = int.parse(price);

    if (totalprice == 0) {
      remainprice = intprice;
      realpercent = 0;
      intpercenticon = 0;
      totalprice = 0;
    }
    if (totalprice == null) {
      remainprice = intprice;
      realpercent = 0;
      intpercenticon = 0;
      totalprice = 0;
    } else if (totalprice == intprice) {
      realpercent = 1;
      intpercenticon = 100;
    } else if (totalprice > intprice) {
      realpercent = 1;
      intpercenticon = 100;
    } else {
      percent = remainprice / intprice;
      realpercent = 1 - percent;
      percenticon = realpercent * 100;
      intpercenticon = percenticon.toInt();
    }

    int remainPrice1;
    if (remainprice < 0) {
      remainPrice1 = -(remainprice);
    }

    // myController.play();

    if (totalprice >= intprice) {
      myController.play();
    }

    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
          databaseHelper1.updateTotal(type, stringTotal);
        },
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text("Overview"),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  moveToLastScreen();
                  databaseHelper1.updateTotal(type, stringTotal);
                },
              ),
              actions: <Widget>[
                remainprice == 0
                    ? Padding(
                        padding: EdgeInsets.only(right: 15),
                      )
                    : Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: IconButton(
                            icon: Image.asset(
                              "assets/images/piggybank.png",
                              color: Colors.white,
                            ),
                            onPressed: () {
                              navigateToDetail(
                                  MoneyNote('', '', type), price, remainprice, finalmoney);
                            }),
                      )
              ],
            ),
            body: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: CircularPercentIndicator(
                    radius: 200.0,
                    percent: realpercent,
                    lineWidth: 10.0,
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey
                            : Colors.grey,
                    progressColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Color(0xffCE8054)
                            : Colors.green[300],
                    center: Text("$intpercenticon %",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w400)),
                    footer: Text("$totalprice MMK / $price MMK"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Divider(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Color(0xffCE8054)
                        : Colors.green[300],
                  ),
                ),
                ListTile(
                  leading:
                      Text("Target Name :", style: TextStyle(fontSize: 20)),
                  trailing: Text("$name", style: TextStyle(fontSize: 20)),
                ),
                Divider(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xffCE8054)
                      : Colors.green[300],
                ),
                ListTile(
                  leading: Text("Target Price :",
                      style: TextStyle(fontSize: 20, color: Colors.green)),
                  trailing: Text("$price MMK",
                      style: TextStyle(fontSize: 20, color: Colors.green)),
                ),
                Divider(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xffCE8054)
                      : Colors.green[300],
                ),
                ListTile(
                  leading: Text(
                      remainprice == 0 ? "Reached Goal " : "Remaining :",
                      style: TextStyle(
                          fontSize: 20,
                          color: remainprice == 0 ? Colors.green : Colors.red)),
                  trailing: Text(
                      remainprice == 0 ? "Congratulation" : "$remainprice MMK",
                      style: TextStyle(
                          fontSize: 20,
                          color: remainprice == 0 ? Colors.green : Colors.red)),
                ),
                Divider(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xffCE8054)
                      : Colors.green[300],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ConfettiWidget(
                    confettiController: myController,
                    blastDirection: -2,
                    emissionFrequency: 0.04,
                    numberOfParticles: 2,
                    maxBlastForce: 100,
                    minBlastForce: 2,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ConfettiWidget(
                    confettiController: myController,
                    blastDirection: -1,
                    emissionFrequency: 0.04,
                    numberOfParticles: 2,
                    maxBlastForce: 100,
                    minBlastForce: 2,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: SizedBox(
              height: 50,
              width: 500,
              child: RaisedButton(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color(0xffCE8054)
                    : Colors.green[300],
                child: Text(
                  "View History",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddMoney(type)));
                },
              ),
            )));
  }

  void getTotal() async {
    var total = (await databaseHelperMoney.getTotal(type))[0]['Total'];

    remainprice = intprice - total;

    setState(() {
      totalprice = total;
      if (total == null) {
        totalprice = 0;
      }
    });
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

  void getAllTotal() async {
    var total = (await databaseHelperMoney.getAllTotal())[0]['AllTotal'];

    setState(() {
      totalallprice = total;
      if (total == null) {
        totalallprice = 0;
      }
    });
  }

  void navigateToDetail(MoneyNote note, String price, int remainprice, int finalmoney) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddMoneyDetail(note, remainprice, finalmoney);
    }));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
}
