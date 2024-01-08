import 'package:flutter/material.dart';
import 'package:water_reminder_app/home%20copy.dart';
// import 'package:saving_money/database/note.dart';

import 'add_money.dart';
import 'database/note.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Note2 note;

  @override 
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Saving Money',
      debugShowCheckedModeBanner: false,
      home: SavingMoney(),
    );
  }
}