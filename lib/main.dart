// ignore_for_file: prefer_const_constructors, unused_import, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loading.dart';
import 'package:flutter_application_1/screens/components/create_professional_account.dart';
import 'package:flutter_application_1/screens/components/manage_business_account.dart';
import 'package:flutter_application_1/screens/components/pick_address_map.dart';
import 'package:flutter_application_1/screens/components/upload.dart';
import 'package:flutter_application_1/screens/components/upload_business_images.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:flutter_application_1/screens/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final client = StreamChatClient(
    'b67pax5b2wdq',
    logLevel: Level.INFO,
  );

  final prefs = await SharedPreferences.getInstance();

  await client.connectUser(
    User(id: 'tutorial-flutter'),
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidHV0b3JpYWwtZmx1dHRlciJ9.S-MJpoSwDiqyXpUURgO5wVqJ4vKlIVFLSEyrFYCOE1c',
  );

  final channel = client.channel('messaging', id: 'flutterdevs');

  channel.watch();
  runApp(
    MyApp(
      client: client,
      channel: channel,
    ),
  );
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.client,
    required this.channel,
  }) : super(key: key);
  // This widget is the root of your application.

  final StreamChatClient client;
  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        return StreamChat(
          client: client,
          child: widget,
        );
      },
      home: StreamChannel(
        channel: channel,
        child: const ChannelPage(),
      ),
    );
    /* return MaterialApp(
      title: 'Workspace',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        //brightness: Brightness.dark,
        /* textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context)
                .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
          )*/
        textTheme: GoogleFonts.aclonicaTextTheme(
          Theme.of(context)
              .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
        ),
      ),
      home: LandingPage(),
    );
    //  home: PickAddress());*/
  }
}

//// Displays the list of messages inside the channel

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StreamChannelHeader(),
      body: Column(
        children: const <Widget>[
          Expanded(
            child: StreamMessageListView(),
          ),
          StreamMessageInput(),
        ],
      ),
    );
  }
}
