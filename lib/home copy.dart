import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:water_reminder_app/database/database_helper.dart';
import 'package:water_reminder_app/database/database_helper_money.dart';
import 'package:water_reminder_app/database/money_note.dart';
import 'package:water_reminder_app/overview.dart';
import 'add_target.dart';
import 'database/note.dart';

String title;
String price;
String type;
String remain;

enum PopupMenuChoices { edit, delete }

class SavingMoney extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SavingMoneyState();
  }
}

class SavingMoneyState extends State<SavingMoney> {
  DatabaseHelper1 databaseHelper = DatabaseHelper1();
  DatabaseHelperMoney databaseHelperMoney = DatabaseHelperMoney();
  List<Note2> noteList;
  int count = 0;

  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note2>();
      updateListView();
    } else {
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Color(0xff303030)
              : Colors.grey[300],
          elevation: 0,
          title: ListTile(
            title: Text("Money Box",
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w400)),
            trailing: IconButton(
              iconSize: 32,
              icon: Icon(
                Icons.playlist_add,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              onPressed: () {
                navigateToDetail(Note2('', '', ''), 'Add Note');
              },
            ),
          )),
      body: showCard(),
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Color(0xff424242)
          : Colors.grey[300],
    );
  }

  void navigateToDetail(Note2 note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddTarget(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  ListView showCard() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        title = this.noteList[position].title;
        price = this.noteList[position].price;
        int inttype = this.noteList[position].id;

        String total = this.noteList[position].total;

        int intPrice = int.parse(price);
        int intTotal;
        if (total == null) {
          intTotal = 0;
        } else {
          intTotal = int.parse(total);
        }

        double percent = intTotal / intPrice;

        double percentage = percent * 100;

        int per = percentage.toInt();

        type = inttype.toString();

        int remain = intPrice - intTotal;

        int remain1;
        if (remain < 0) {
          remain1 = -(remain);
        }

        if (percent > 1) {
          percent = 1;
          per = 100;
        }

        return Center(
          child: InkWell(
            onTap: () {
              int intId = this.noteList[position].id;

              String stringId = intId.toString();

              String name = this.noteList[position].title;

              String price = this.noteList[position].price;

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Overview(stringId, name, price)));
            },
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              // color: Colors.white,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xff424242)
                  : Colors.grey[300],
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Image(
                      image: AssetImage(percent >= 1
                          ? "assets/images/award.png"
                          : "assets/images/target.png"),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Color(0xffCE8054)
                          : Colors.green[300],
                    ),
                    title: Text(
                      '$title',
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                        remain == 0 ? "Reached Goal" : '$intTotal / $price'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(right: 3),
                            child: PopupMenuButton<dynamic>(
                              onSelected: (value) =>
                                  onMenuSelection(value, position),
                              itemBuilder: (BuildContext contex) {
                                return [
                                  const PopupMenuItem<PopupMenuChoices>(
                                    value: PopupMenuChoices.edit,
                                    child: Text("Edit"),
                                  ),
                                  PopupMenuItem<PopupMenuChoices>(
                                    value: PopupMenuChoices.delete,
                                    child: Text("Delete"),
                                  )
                                ];
                              },
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 70,
                      animation: true,
                      lineHeight: 10.0,
                      animationDuration: 1000,
                      percent: percent,
                      trailing: Text("$per %"),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      backgroundColor: Colors.grey,
                      progressColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Color(0xffCE8054)
                              : Colors.green[300],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10, right: 20),
                  //   child: ListTile(
                  //     leading: Text(remain == 0 ?"Reached Goal" : "$remain MMK to go"),
                  //     trailing: Text("$intTotal / $price"),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initalizeDatabase();
    dbFuture.then((database) {
      Future<List<Note2>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  void _delete(BuildContext context, Note2 note, String id) async {
    int result;

    await databaseHelper.deleteNote(note.id);
    await databaseHelperMoney.deleteMoneyNote1(id);

    if (result != 0) {
      updateListView();
    }
  }

  void onMenuSelection(PopupMenuChoices value, int position) async {
    switch (value) {
      case PopupMenuChoices.edit:
        navigateToDetail(this.noteList[position], 'Edit Note');
        break;
      case PopupMenuChoices.delete:
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
                                    padding: const EdgeInsets.only(bottom:15),
                                    child: Center(
                                      child: Text(
                                        "Do you want to delete?",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        // SizedBox(
                                        //   width: 18,
                                        // ),
                                        SizedBox(
                                          width: 100.0,
                                          child: RaisedButton(
                                            onPressed: () {
                                             int intId = this.noteList[position].id;

                                    String stringId = intId.toString();

                                    _delete(context, noteList[position], stringId);

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

        break;
      default:
    }
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
}
