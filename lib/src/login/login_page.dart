import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_reminder_app/database/login.dart';
import 'package:water_reminder_app/homenew.dart';
import 'package:water_reminder_app/src/global_blocs/auth/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TapGestureRecognizer _termsOfServiceRecognizer;
  TapGestureRecognizer _privacyPolicyRecognizer;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final auth = Provider.of<Auth>(context);

    return Scaffold(
      body: Login(),
      
    );
  }

  @override
  void dispose() {
    _termsOfServiceRecognizer.dispose();
    _privacyPolicyRecognizer.dispose();
    super.dispose();
  }
}
