// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_intro.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    confirmToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  confirmToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('token');
    if (token == null) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return WelcomeScreen();
         // return LoginPage();
        }),
      );
    } else {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return HomePage();
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 100,
      width: 100,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
