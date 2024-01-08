

// // import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'dart:async';
// import 'package:sqflite/sqflite.dart';
// import 'package:water_reminder_app/database/databasehelper.dart';
// import 'package:water_reminder_app/homenew.dart';
// import 'package:water_reminder_app/income.dart';
// import 'package:water_reminder_app/models/note1.dart';
// import 'package:water_reminder_app/outcome.dart';

// String sala;
// String dada;
// String aa;
// String inco;
// int inco1;
// int totalincomeprice = 0;
// int totaloutcomeprice = 0;
// int finalmoney = 0;
// int inn;
// int out;

// class Homes extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return HomeLists();
//   }
// }

// class HomeLists extends State<Homes> {
//   DatabaseCome databaseHelper = DatabaseCome();
//   List<Note3> passitems = new List();
//   List<Note3> noteList;
//   List<Note3> items = new List();
//   int count = 0;
// bool colo =true ;
//   @override
//   Widget build(BuildContext context) {
//     if (totalincomeprice == 0) {
//       incometotal();
//     } else if (totalincomeprice != 0) {
//       incometotal();
//     }

//     if (totaloutcomeprice == 0) {
//       outcometotal();
//     } else if (totaloutcomeprice != 0) {
//       outcometotal();
//     }
//     finalmoney = totalincomeprice - totaloutcomeprice;
//     // if(finalmoney.toString().substring(0,1) == "-"){
//     //   this.colo = false;
      
//     // }else{
//     //   this.colo = true;
//     // }

//     if (noteList == null) {
//       noteList = List<Note3>();
//       updateListView();
//     }
//     // if (totalincomeprice = null) {
//     //   totalincomeprice == '0';
//     // } else {}
//     return WillPopScope(
//       onWillPop: () {},
//       child: Scaffold(
//         // backgroundColor: Colors.white,
//         body: Container(
//           child: ListView(
//             children: <Widget>[
//               Container(
//                 height: 700,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage('assets/images/nn2.png'),
//                         fit: BoxFit.fill)),
//                 child: Stack(
//                   children: <Widget>[
//                     Positioned(
//                       top: 30,
//                       left: 85,
//                       child: Text(
//                         "  Current Balance",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 25,
//                           // fontWeight: FontWeight.bold
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: 65,
//                       left: 155,
//                       child: Text(
//                         "$finalmoney",
                       
//                         style: TextStyle(
//                           color: Colors.white,
                          
//                           fontSize: 20,
//                         ),
//                       ),
//                     ),

                      
//                          Positioned(
//                         top: 100,
//                         left: 15,
//                         width: 160,
//                         height: 140,
//                         // right: 10,
//                         child: Container(
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10.0)),
//                             color: Colors.white,
//                             elevation: 10,
//                             child: FlatButton(
//                                                 onPressed: () {
//                                       navigate(Note3('', '', '', '', '', ''),
//                                           'Income');
//                                     },
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   Padding(
//                                       padding: EdgeInsets.only(top: 00.1),
//                                       // padding: EdgeInsets.fromLTRB(25, 20,5,10),
//                                       child: Text(
//                                         "+" + "$totalincomeprice",
//                                         style: TextStyle(
//                                             color: Colors.green, fontSize: 20),
//                                       )),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // ),
//                         ),
//                     ),
                      
//                     Positioned(
//                       top: 100,
//                       left: 185,
//                       width: 160,
//                       height: 140,
//                       // right: 10,
//                       child: Container(
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0)),
//                           color: Colors.white,
//                           elevation: 10,
//                           child: FlatButton(
//                             onPressed: () {
//                               navigate1(
//                                   Note3('', '', '', '', '', ''), 'Outcome');
//                             },
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 Padding(
//                                     padding: EdgeInsets.only(top: 00.1),
//                                     // padding: EdgeInsets.fromLTRB(25, 20,5,10),
//                                     child: Text(
//                                       "-" + "$totaloutcomeprice",
//                                       style: TextStyle(
//                                           color: Colors.red, fontSize: 20),
//                                     )),
//                               ],
//                             ),
//                           ),
//                         ),
//                         // ),
//                       ),
//                     ),
//                     Positioned(
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 250),
//                         child: getNoteListView(),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//         ////////////////////////////
//       ),
//     );
//   }

//   ListView getNoteListView() {
//     Icon icon;

//     return ListView.builder(
//       itemCount: count,
//       itemBuilder: (BuildContext context, int position) {
//         if (this.noteList[position].salary == "Choose Incometype") {
//           icon = Icon(
//             Icons.add_location,
//             color: Colors.green,
//           );
//         }
//          else  if (this.noteList[position].salary == "Choose Outcometype") {
//           icon = Icon(
//             Icons.announcement,
//             color: Colors.red,
//           );
//         }
//         if (this.noteList[position].salary == "Salary") {
//           icon = Icon(
//             Icons.attach_money,
//             color: Colors.green,
//           );
//         } else if (this.noteList[position].salary == "Bonus") {
//           icon = Icon(
//             MdiIcons.percentOutline,
//             color: Colors.blue[200],
//           );
//         } else if (this.noteList[position].salary == "Income from sideline") {
//           icon = Icon(Icons.sentiment_very_satisfied, color: Colors.orange);
//         } else if (this.noteList[position].salary == "Pocket Money") {
//           icon = Icon(
//             Icons.account_balance_wallet,
//             color: Colors.pink,
//           );
//         } else if (this.noteList[position].salary == "Profit Money") {
//           icon = Icon(
//             Icons.insert_chart,
//             color: Colors.deepPurple,
//           );
//         } else if (this.noteList[position].salary == "Borrow Money") {
//           icon = Icon(
//             Icons.money_off,
//             color: Colors.red,
//           );
//         } else if(this.noteList[position].salary =="Food"){
//           icon = Icon(Icons.fastfood , color: Colors.deepOrangeAccent[100]);
//         } else if(this.noteList[position].salary =="Electronic"){
//           icon = Icon(Icons.lightbulb_outline , color: Colors.lightBlue[100]);
//         } else if(this.noteList[position].salary =="Clothing"){
//           icon = Icon(Icons.accessibility_new , color: Colors.black);
//         }else if(this.noteList[position].salary =="Revenue"){
//           icon = Icon(Icons.receipt , color: Colors.grey);
//         }else if(this.noteList[position].salary =="Phone Bill"){
//           icon = Icon(Icons.phone_android , color: Colors.blue[600]);
//         }else if(this.noteList[position].salary =="Present"){
//           icon = Icon(Icons.favorite , color: Colors.red);
//         }else if(this.noteList[position].salary =="Accessories"){
//           icon = Icon(Icons.local_grocery_store , color: Colors.blueGrey);
//         }else if(this.noteList[position].salary =="Vahicle"){
//           icon = Icon(Icons.directions_car , color: Colors.red);
//         }
        
        
        
        
        
        
        
//         else {
//           icon = Icon(  Icons.add_location,color: Colors.green[300]);
//         }

//         if (this.noteList[position].incomeamount == "0") {

         


//           if (this.noteList[position].date == null) {
//             dada = DateTime.now().toString().substring(0, 10);
//           } else if (this.noteList[position].date == "") {
//             dada = DateTime.now().toString().substring(0, 10);
//           } else {
//             dada = this.noteList[position].date.toString();
//           }
//           if (this.noteList[position].salary == "") {
//             sala = "other outcome";
//           } else if (this.noteList[position].salary == "Choose Outcometype") {
//             sala = "other outcome";
//           } else {
//             sala = this.noteList[position].salary.toString();
//           }
//           return Card(
//             color: Colors.white,
//             elevation: 2.0,
//             child: ListTile(
//                 leading: (icon),
//                 title: Text(
//                   "$sala",
//                   // this.noteList[position].salary,
//                   // style: TextStyle(color: Colors.white),
//                   maxLines: 2,
//                 ),
//                 subtitle: Text(
//                   "$dada",
//                   // this.noteList[position].date,
//                   // style: TextStyle(color: Colors.white),
//                 ),
//                 trailing: Text(
//                   this.noteList[position].outcomeamount + "  " + "MMK",
//                   style:
//                       TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
//                   maxLines: 2,
//                 ),
//                 onTap: () {
//                   print("tap");
//                   //  print(this.noteList[position].incomeamount) ;
//                   navigateout(this.noteList[position], 'Outcome edit');
//                 },
//                 onLongPress: () {
//                   showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return Dialog(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                   20.0)), //this right here
//                           child: Container(
//                             height: 150,
//                             child: Padding(
//                               padding: const EdgeInsets.all(12.0),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   TextField(
//                                     decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                         hintText:
//                                             '            Do you want to delete?'),
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       SizedBox(
//                                         width: 18,
//                                       ),
//                                       SizedBox(
//                                         width: 100.0,
//                                         child: RaisedButton(
//                                           onPressed: () {
//                                             _delete(
//                                                 context, noteList[position]);
//                                                     updateListView();
//                                             Navigator.push(context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) {
//                                               return MyApp();
                                              
//                                             }));
//                                                 // updateListView();
//                                           },
//                                           child: Text(
//                                             "Delete",
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                           color: Colors.green[300],
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 20,
//                                       ),
//                                       SizedBox(
//                                         width: 100.0,
//                                         child: RaisedButton(
//                                           onPressed: () {
//                                             Navigator.push(context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) {
//                                               return MyApp();
//                                             }));
//                                           },
//                                           child: Text(
//                                             "Cancel",
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                           color: Colors.green[300],
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       });
//                 }),
//           );
//         } else {
//           if (this.noteList[position].date == null) {
//             dada = DateTime.now().toString().substring(0, 10);
//           } else if (this.noteList[position].date == "") {
//             dada = DateTime.now().toString().substring(0, 10);
//           } else {
//             dada = this.noteList[position].date.toString();
//           }

//           if (this.noteList[position].salary == "") {
//             sala = "other income";
//           } else if (this.noteList[position].salary == "Choose Incometype") {
//             sala = "other income";
//           } else {
//             sala = this.noteList[position].salary;
//           }
//           return Card(
//             color: Colors.white,
//             elevation: 2.0,
//             child: ListTile(
//                 leading: (icon),
//                 title: Text(
//                   "$sala",
//                   // this.noteList[position].salary,
//                   // style: TextStyle(color: Colors.white),
//                   maxLines: 2,
//                 ),
//                 subtitle: Text(
//                     // this.noteList[position].date,
//                     "$dada"
//                     // style: TextStyle(color: Colors.white),
//                     ),
//                 trailing: Text(
//                   this.noteList[position].incomeamount + "  " + "MMK",
//                   style: TextStyle(
//                       color: Colors.green, fontWeight: FontWeight.w700),
//                   maxLines: 2,
//                 ),
                
//                 onTap: () {
//                   navigatein(this.noteList[position], 'Income edit');
//                 },
//                 onLongPress: () {
//                   showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return Dialog(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                   20.0)), //this right here
//                           child: Container(
//                             height: 150,
//                             child: Padding(
//                               padding: const EdgeInsets.all(12.0),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   TextField(
//                                     decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                         hintText:
//                                             '            Do you want to delete?'),
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       SizedBox(
//                                         width: 18,
//                                       ),
//                                       SizedBox(
//                                         width: 100.0,
//                                         child: RaisedButton(
//                                           onPressed: () {
//                                             _delete(
//                                                 context, noteList[position]);
//                                             Navigator.push(context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) {
//                                               return MyApp();
//                                             }));
//                                           },
//                                           child: Text(
//                                             "Delete",
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                           color: Colors.green[300],
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 20,
//                                       ),
//                                       SizedBox(
//                                         width: 100.0,
//                                         child: RaisedButton(
//                                           onPressed: () {
//                                             Navigator.push(context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) {
//                                               return MyApp();
//                                             }));
//                                           },
//                                           child: Text(
//                                             "Cancel",
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                           color: Colors.green[300],
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       });
//                 }),
//           );
//         }
//       },
//     );
//   }

//   void incometotal() async {
//     // print("Sdfsf");
//     var total = (await databaseHelper.totalIncome())[0]['Total'];
//     // print('$total');
//     setState(() {
//       if (total == 0) {
//         totalincomeprice = 0;
//       } else if (total == null) {
//         totalincomeprice =0;
//       } else {
//         totalincomeprice = total;
//       }
//     });
//   }
//   void updateListView() async {
//     final Future<Database> dbFuture = databaseHelper.initalizeDatabase();
//     await dbFuture.then((database) {
//       Future<List<Note3>> noteListFuture = databaseHelper.getNoteList();
//       noteListFuture.then((noteList) {
//         setState(() {
//           this.noteList = noteList;
//           this.count = noteList.length;
//         });
//       });
//     });
//   }
//   void outcometotal() async {
//     // print("Sdfsf");
//     var total = (await databaseHelper.totalOutcome())[0]['Total'];
//     // print('$total');
//     setState(() {
//       if (total == 0) {
//         totaloutcomeprice = 0;
//       } else if (total == null) {
//         totaloutcomeprice = 0;
//       } else {
//         totaloutcomeprice = total;
//       }
//     });
//   }

//   void _delete(BuildContext context, Note3 note) async {

//     int result = await databaseHelper.deleteNote(note.id);
//     if (result == 0) {
//       updateListView();
//     }
//   }

//   void delete() async {
//     int result = await databaseHelper.deleteAll();
//     if (result == 0) {
//       updateListView();
//     }
//   }

//   void navigate(Note3 note, String title) async {
//     bool result =
//         await Navigator.push(context, MaterialPageRoute(builder: (context) {
//       return Newnote(note, title);
//     }));
//     if (result == true) {
//       updateListView();
//     }
//   }

//   void navigatein(Note3 note, String title) async {
//     bool result =
//         await Navigator.push(context, MaterialPageRoute(builder: (context) {
//       return Newnote(note, title);
//     }));
//     if (result == true) {
//       updateListView();
//     }
//   }

//   void navigateout(Note3 note, String title) async {
//     bool result =
//         await Navigator.push(context, MaterialPageRoute(builder: (context) {
//       return Outcome(note, title);
//     }));
//     if (result == true) {
//       updateListView();
//     }
//   }

//   void navigate1(Note3 note, String title) async {
//     bool result =
//         await Navigator.push(context, MaterialPageRoute(builder: (context) {
//       return Outcome(note, title);
//     }));
//     if (result == true) {
//       updateListView();
//     }
//   }

//   void movedBack() {}
//   // void updateListView() {
//   //   final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//   //   dbFuture.then((database) {
//   //     Future<List<Note3>> noteListFuture = databaseHelper.getNoteList();
//   //     noteListFuture.then((noteList) {
//   //       setState(() {
//   //         this.noteList = noteList;
//   //         this.count = noteList.length;
//   //       });
//   //     });
//   //   });
//   // }
// }

// class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final double height;

//   const MyCustomAppBar({
//     Key key,
//     @required this.height,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           color: Colors.white,
//           child: Column(
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.only(top: 10),
//                 child: Text("Remain\n",
//                     style: TextStyle(
//                       fontSize: 30,
//                       color: Colors.orange,
//                       letterSpacing: 0.7,
//                       decoration: TextDecoration.none,
//                     )),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 0),
//                 child: Text("$finalmoney",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.black,
//                       decoration: TextDecoration.none,
//                     )),
//               ),
//               Text("kyat",
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.black,
//                     decoration: TextDecoration.none,
//                   )),
//               Padding(
//                 padding: EdgeInsets.only(),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.only(
//                         left: 0,
//                         right: 0,
//                       ),
//                       child: Column(
//                         children: <Widget>[
//                           Container(
//                             width: 170,
//                             height: 180,
//                             child: Padding(
//                               padding: const EdgeInsets.only(),
//                               child: Card(
//                                 // Income
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15.0)),
//                                 color: Colors.green[200],
//                                 elevation: 10,
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: <Widget>[
//                                     const ListTile(
//                                       // leading: Icon(Icons.attach_money),
//                                       title: Text('    Income',
//                                           style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 23,
//                                               letterSpacing: 1)),
//                                     ),
//                                     FlatButton(
//                                       child: Icon(
//                                         Icons.expand_less,
//                                         color: Colors.green,
//                                         size: 50,
//                                       ),
//                                       color: Color.fromRGBO(68, 153, 213, 1.0),
//                                       shape: CircleBorder(),
//                                     ),
//                                     Padding(
//                                         padding: EdgeInsets.only(top: 20),
//                                         // padding: EdgeInsets.fromLTRB(25, 20,5,10),
//                                         child: Text(
//                                           "$totalincomeprice",
//                                           style: TextStyle(
//                                               color: Colors.orange,
//                                               fontSize: 20),
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(),
//                       child: Column(
//                         children: <Widget>[
//                           Container(
//                             width: 170,
//                             height: 180,
//                             child: Card(
//                               // Outcome

//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15.0)),
//                               color: Colors.green[200],
//                               elevation: 10,
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   const ListTile(
//                                     // leading: Icon(Icons.attach_money),
//                                     title: Text('   Outcome',
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 23,
//                                             letterSpacing: 1)),
//                                   ),
//                                   FlatButton(
//                                     child: Icon(
//                                       Icons.expand_more,
//                                       size: 50,
//                                       color: Colors.red,
//                                     ),
//                                     color: Color.fromRGBO(68, 153, 213, 1.0),
//                                     shape: CircleBorder(),
//                                     onPressed: () {},
//                                   ),
//                                   Padding(
//                                       padding: EdgeInsets.only(top: 20),
//                                       child: Text(
//                                         "$totaloutcomeprice",
//                                         style: TextStyle(
//                                             color: Colors.orange, fontSize: 20),
//                                       )),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // @override
//   Size get preferredSize => Size.fromHeight(height);
// }





















// import 'package:flutter/material.dart';
// import 'package:water_reminder_app/outcome.dart';

// class Sample1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         // backgroundColor: Colors.blue,
//         drawer: Drawer(),
//         appBar: MyCustomAppBar(
//           height: 400,
//         ),
//         body: Center(
//           child: FlutterLogo(
//             size: MediaQuery.of(context).size.width / 2,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final double height;

//   const MyCustomAppBar({
//     Key key,
//     @required this.height,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           color: Colors.white,
//           child: Column(
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.only(top: 10),
//                 child: Text("Remain\n",
//                     style: TextStyle(
//                       fontSize: 30,
//                       color: Colors.orange,
//                       letterSpacing: 0.7,
//                       decoration: TextDecoration.none,
//                     )),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 0),
//                 child: Text("200000",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.black,
//                       decoration: TextDecoration.none,
//                     )),
//               ),
//               Text("kyat",
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.black,
//                     decoration: TextDecoration.none,
//                   )),
//               Padding(
//                 padding: EdgeInsets.only(),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.only(
//                         left: 10,
//                         right: 10,
//                       ),
//                       child: Column(
//                         children: <Widget>[
//                           Container(
//                             width: 180,
//                             height: 180,
//                             child: Padding(
//                               padding: const EdgeInsets.only(),
//                               child: Card(
//                                 // Income
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15.0)),
//                                 color: Colors.white,
//                                 elevation: 10,
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: <Widget>[
//                                     const ListTile(
//                                       // leading: Icon(Icons.attach_money),
//                                       title: Text('    Income',
//                                           style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 23,
//                                               letterSpacing: 1)),
//                                     ),
//                                     FlatButton(
//                                       child: Icon(
//                                         Icons.expand_less,
//                                         color: Colors.green,
//                                         size: 50,
//                                       ),
//                                       color: Color.fromRGBO(68, 153, 213, 1.0),
//                                       shape: CircleBorder(),
//                                       onPressed: () {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     Income()));
//                                       },
//                                     ),
//                                     Padding(
//                                         padding: EdgeInsets.only(top: 20),
//                                         child: Text(
//                                           "600000",
//                                           style: TextStyle(
//                                               color: Colors.orange,
//                                               fontSize: 20),
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(right: 10, left: 10),
//                       child: Column(
//                         children: <Widget>[
//                           Container(
//                             width: 180,
//                             height: 180,
//                             child: Card(
//                               // Outcome
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15.0)),
//                               color: Colors.white,
//                               elevation: 10,
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   const ListTile(
//                                     // leading: Icon(Icons.attach_money),
//                                     title: Text('   Outcome',
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 23,
//                                             letterSpacing: 1)),
//                                   ),
//                                   FlatButton(
//                                     child: Icon(
//                                       Icons.expand_more,
//                                       size: 50,
//                                       color: Colors.red,
//                                     ),
//                                     color: Color.fromRGBO(68, 153, 213, 1.0),
//                                     shape: CircleBorder(),
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => Outcome()),
//                                       );
//                                     },
//                                   ),
//                                   Padding(
//                                       padding: EdgeInsets.only(top: 20),
//                                       child: Text(
//                                         "400000",
//                                         style: TextStyle(
//                                             color: Colors.orange, fontSize: 20),
//                                       )),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(height);
// }
