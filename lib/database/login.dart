
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:water_reminder_app/Animation/FadeAnimation.dart';
import 'package:water_reminder_app/database/db_helper.dart';
import 'package:water_reminder_app/homenew.dart';
import 'package:water_reminder_app/models/note.dart';

var password;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List<Note> items;

  DatabaseHelper helper1 = DatabaseHelper();
  var _formkey = GlobalKey<FormState>();
  var count = 0;
  TextEditingController loginController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (items == null) {
      items = List<Note>();
      updateListView();
    }

    if (this.count >= 1) {
      if (Theme.of(context).brightness == Brightness.light) {
        return Scaffold(
          backgroundColor: Colors.white,
          // resizeToAvoidBottomPadding: false,
          body: Container(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/bb.png'),
                          // image: AssetImage('assets/images/DARK.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 180,
                        child: FadeAnimation(
                            3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 160,
                        child: FadeAnimation(
                            3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 140,
                        child: FadeAnimation(
                            3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            3,
                            Container(
                              margin: EdgeInsets.only(top: 60),
                              child: Center(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          3,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: []),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                        // border: Border(
                                        //     bottom:
                                        //         BorderSide()
                                        //         )
                                        ),
                                    child: TextFormField(
                                      obscureText: true,
                                      style: TextStyle(color: Colors.black),
                                      keyboardType: TextInputType.number,
                                      controller: loginController,
                                      validator: (String value) {
                                        if (value.isEmpty ||
                                            loginController.text != password) {
                                          return "Invalid password";
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: "PassCode",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        fillColor: Colors.grey.shade200,
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
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                        3,
                        GestureDetector(
                          onTap: () {
                            password = items[0].password;
                            print('$password');
                            if (_formkey.currentState.validate()) {
                              setState(() {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return MyApp();
                                }));
                              });
                            }
                          },
                          child: Container(
                            height: 50,
                            ////////////
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.green[200],
                                  Colors.teal[200],
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            //////////////
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        return Scaffold(
          backgroundColor: Colors.white,
          // resizeToAvoidBottomPadding: false,
          body: Container(
            color: Color(0xff303030),
            child: ListView(
              children: <Widget>[
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          // image: AssetImage('assets/images/bb.png'),
                          image: AssetImage('assets/images/DARK.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 180,
                        child: FadeAnimation(
                            3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 160,
                        child: FadeAnimation(
                            3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 140,
                        child: FadeAnimation(
                            3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            3,
                            Container(
                              margin: EdgeInsets.only(top: 60),
                              child: Center(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          3,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: []),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                        // border: Border(
                                        //     bottom:
                                        //         BorderSide()
                                        //         )
                                        ),
                                    child: TextFormField(
                                      obscureText: true,
                                      style: TextStyle(color: Colors.white),
                                      keyboardType: TextInputType.number,
                                      controller: loginController,
                                      validator: (String value) {
                                        if (value.isEmpty ||
                                            loginController.text != password) {
                                          return "Invalid password";
                                        }
                                      },
                                      // decoration: InputDecoration(
                                      //   hintText: "PassCode",
                                      //   hintStyle:
                                      //       TextStyle(color: Colors.grey),
                                      //   fillColor: Colors.grey.shade200,
                                      //   filled: true,
                                      //   border: OutlineInputBorder(
                                      //     borderSide: BorderSide.none,
                                      //     borderRadius: const BorderRadius.all(
                                      //       const Radius.circular(5),
                                      //     ),
                                      //   ),
                                      // ),

                                         decoration: InputDecoration(
                          hintText: "PassCode",
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                        3,
                        GestureDetector(
                          onTap: () {
                            password = items[0].password;
                            print('$password');
                            if (_formkey.currentState.validate()) {
                              setState(() {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return MyApp();
                                }));
                              });
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  // Colors.green[200],
                                  // Colors.teal[200],
                                  // Colors.orange[500],
                                  Color(0xFFCE8054),
                                  Colors.orange[300]
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    } else {
      return MyApp();
    }
  }

  void updateListView() async {
    final Future<Database> dbFuture = helper1.initializedDatabase();
    await dbFuture.then((database) {
      Future<List<Note>> noteListFuture = helper1.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.items = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:sqflite/sqlite_api.dart';
// import 'package:water_reminder_app/Animation/FadeAnimation.dart';
// import 'package:water_reminder_app/database/db_helper.dart';
// import 'package:water_reminder_app/homenew.dart';
// import 'package:water_reminder_app/models/note.dart';

// var password;

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   List<Note> items;

//   DatabaseHelper helper1 = DatabaseHelper();
//   var _formkey = GlobalKey<FormState>();
//   var count = 0;
//   TextEditingController loginController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     if (items == null) {
//       items = List<Note>();
//       updateListView();
//     }

//     if (this.count >= 1) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         // resizeToAvoidBottomPadding: false,
//         body: Container(
//           child: ListView(
//             children: <Widget>[
//               Container(
//                 height: 300,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         // image: AssetImage('assets/images/bb.png'),
//                         image: AssetImage('assets/images/bb.png'),
//                         fit: BoxFit.fill)),
//                 child: Stack(
//                   children: <Widget>[
//                     Positioned(
//                       left: 30,
//                       width: 80,
//                       height: 180,
//                       child: FadeAnimation(
//                           3,
//                           Container(
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         'assets/images/light-1.png'))),
//                           )),
//                     ),
//                     Positioned(
//                       left: 140,
//                       width: 80,
//                       height: 160,
//                       child: FadeAnimation(
//                           3,
//                           Container(
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         'assets/images/light-2.png'))),
//                           )),
//                     ),
//                     Positioned(
//                       right: 40,
//                       top: 40,
//                       width: 80,
//                       height: 140,
//                       child: FadeAnimation(
//                           3,
//                           Container(
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image:
//                                         AssetImage('assets/images/clock.png'))),
//                           )),
//                     ),
//                     Positioned(
//                       child: FadeAnimation(
//                           3,
//                           Container(
//                             margin: EdgeInsets.only(top: 60),
//                             child: Center(
//                               child: Text(
//                                 "",
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 40,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           )),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: Column(
//                   children: <Widget>[
//                     FadeAnimation(
//                         3,
//                         Container(
//                           padding: EdgeInsets.all(5),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: []),
//                           child: Form(
//                             key: _formkey,
//                             child: Column(
//                               children: <Widget>[
//                                 Container(
//                                   padding: EdgeInsets.all(0),
//                                   decoration: BoxDecoration(
//                                       // border: Border(
//                                       //     bottom:
//                                       //         BorderSide()
//                                       //         )
//                                       ),
//                                   child: TextFormField(
//                                     obscureText: true,
//                                     style: TextStyle(color: Colors.black),
//                                     keyboardType: TextInputType.number,
//                                     controller: loginController,
//                                     validator: (String value) {
//                                       if (value.isEmpty ||
//                                           loginController.text != password) {
//                                         return "Invalid password";
//                                       }
//                                     },
//                                     decoration: InputDecoration(
//                                       hintText: "PassCode",
//                                       hintStyle: TextStyle(color: Colors.grey),
//                                       fillColor: Colors.grey.shade200,
//                                       filled: true,
//                                       border: OutlineInputBorder(
//                                         borderSide: BorderSide.none,
//                                         borderRadius: const BorderRadius.all(
//                                           const Radius.circular(5),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     FadeAnimation(
//                       3,
//                       GestureDetector(
//                         onTap: () {
//                           password = items[0].password;
//                           print('$password');
//                           if (_formkey.currentState.validate()) {
//                             setState(() {
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) {
//                                 return MyApp();
//                               }));
//                             });
//                           }
//                         },
//                         child: Container(
//                           height: 50,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 Colors.green[200],
//                                 Colors.teal[200],
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Center(
//                             child: Text(
//                               'Login',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 70,
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       );
//     } else {
//       return MyApp();
//     }
//   }

//   void updateListView() async {
//     final Future<Database> dbFuture = helper1.initializedDatabase();
//     await dbFuture.then((database) {
//       Future<List<Note>> noteListFuture = helper1.getNoteList();
//       noteListFuture.then((noteList) {
//         setState(() {
//           this.items = noteList;
//           this.count = noteList.length;
//         });
//       });
//     });
//   }
// }
