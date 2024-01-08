import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_reminder_app/home.dart';
import 'package:water_reminder_app/src/enums/enums.dart';
import 'package:water_reminder_app/src/global_blocs/theme_changer.dart';
import 'package:water_reminder_app/third.dart';

import 'home copy.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends State<MyApp> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Homes(),
    SavingMoney(),
    Third(),
  ];
  bool isAnonymous = false;

  @override
  void didChangeDependencies() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).brightness == Brightness.dark
              ? Color(0xffCE8054)
              : Colors.green,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on),
              title: Text('Saving'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_applications),
              title: Text('Setting'),
            ),
          ],
        ),
      ),
    );
  }
}
