// ignore_for_file: prefer_const_constructors, unused_import, use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loading.dart';
import 'package:flutter_application_1/screens/components/create_professional_account.dart';
import 'package:flutter_application_1/screens/components/manage_business_account.dart';
import 'package:flutter_application_1/screens/components/pick_address_map.dart';
import 'package:flutter_application_1/screens/components/upload.dart';
import 'package:flutter_application_1/screens/components/old/upload_business_images.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_application_1/screens/signup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Workspace',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          //  brightness: Brightness.dark,
          /* textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context)
                .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
          )*/
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context)
                .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
          ),
        ),
        home: LandingPage());
    //  home: PickAddress());
  }
}
