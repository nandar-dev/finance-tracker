

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_reminder_app/Constants.dart';
import 'package:water_reminder_app/Reset.dart';
import 'package:water_reminder_app/aboutapp.dart';
import 'package:water_reminder_app/addpasscode.dart';
import 'package:water_reminder_app/database/db_helper.dart';
import 'package:water_reminder_app/models/note.dart';
import 'package:water_reminder_app/src/enums/enums.dart';
import 'package:water_reminder_app/src/global_blocs/auth/auth.dart';
import 'package:water_reminder_app/src/global_blocs/theme_changer.dart';
import 'package:water_reminder_app/view_all_balance.dart';

class Third extends StatefulWidget {
  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  List<Note> passitems = new List();
  DatabaseHelper helper1 = DatabaseHelper();
  Auth auth;
  bool isAnonymous = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    auth = Provider.of<Auth>(context);
    final firebaseUser = await auth.currentUser();
    setState(() {
      isAnonymous = firebaseUser.isAnonymous;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 190),
                    // child: PopupMenuButton(
                    //   onSelected: (value) => onMenuSelection(value, auth),
                    //   itemBuilder: (context) {
                    //     return [
                    //       const PopupMenuItem<PopupMenuChoices>(
                    //         value: PopupMenuChoices.signOut,
                    //         child: Text('log out'),
                    //       ),
                    //       PopupMenuItem<PopupMenuChoices>(
                    //         value: PopupMenuChoices.themeChanger,
                    //         child: Text(
                    //           themeChanger.theme.brightness == Brightness.dark
                    //               ? 'light mode'
                    //               : 'dark mode',
                    //         ),
                    //       ),
                    //       if (isAnonymous)
                    //         const PopupMenuItem<PopupMenuChoices>(
                    //           value: PopupMenuChoices.syncPopup,
                    //           child: Text('sync account'),
                    //         ),
                    //     ];
                    //   },
                    // ),
                  ),
                ],
              ),
            ),




            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.lock,
                      color: Color(0xffFA991C),
                      size: 28,
                    ),
                    title: Text('Security',
                        style: TextStyle(fontSize: 15, letterSpacing: 1)),
                    onTap: () {
                      setState(() {
                        helper1.getAllNotes().then((notes) => {
                              notes.forEach((note) =>
                                  {passitems.add(Note.formMapObjedt(note))})
                            });
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SetPassword(Note(''), this.passitems)));
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(

                     leading:   themeChanger.theme.brightness == Brightness.dark
                          ?  Icon(Icons.brightness_4,size: 28,color: Colors.blueAccent,)
                          : Icon(Icons.brightness_5,size: 28,color: Colors.blueAccent,),

                    // leading: Icon(
                    //   Icons.brush,
                    //   color: Colors.teal,
                    //   size: 28,
                    // ), 
                    title: Text(
                      themeChanger.theme.brightness == Brightness.dark
                          ? 'Light Mode'
                          : 'Dark Mode',
                      style: TextStyle(fontSize: 15, letterSpacing: 1),
                    ),
                   
                    onTap: () {
                      themeChanger.switchTheme();
                    },
                  ),
                ],
              ),
            ),
            // ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.restore_from_trash,
                      color: Colors.purple,
                      size: 30,
                    ),
                     
                    title: Text('Reset App',
                        style: TextStyle(
// color: Colors.black,
                            fontSize: 15,
                            letterSpacing: 1)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Reset()));
                    },
                  ),
                ],
              ),
            
            ),
               
            Divider(
             
            ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.featured_play_list, color: Colors.blueGrey,size: 25,),
                    title: Text('View All Balance',
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 1)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ViewAllBalance()));
                    },
                  ),
                ],
              ),
           
            Divider(
             
            ),

            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Colors.redAccent,
                      size: 28,
                    ), //teal
                    title: Text('About App',
                        style: TextStyle(
// color: Colors.black,
                            fontSize: 15,
                            letterSpacing: 1)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => About()));
                    },
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.Light) {}
  }

  void onMenuSelection(PopupMenuChoices value, Auth auth) async {
    final themeChanger = Provider.of<ThemeChanger>(context);
    switch (value) {
      case PopupMenuChoices.signOut:
        auth.signOut();
        break;
      case PopupMenuChoices.themeChanger:
        themeChanger.switchTheme();
        break;
      case PopupMenuChoices.syncPopup:
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            // return SyncAccountPopup();
          },
        );
        final firebaseUser = await auth.currentUser();
        setState(() {
          isAnonymous = firebaseUser.isAnonymous;
        });
        break;
      default:
    }
  }
}
