// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, avoid_unnecessary_containers, unused_field, unnecessary_import, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/components/review_parse.dart';
import 'package:flutter_application_1/screens/models/user_model.dart';
import 'package:flutter_application_1/screens/models/message_modal.dart';
import 'package:flutter_application_1/screens/components/details.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:comment_box/comment/test.dart';
import 'package:comment_box/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/network/api.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

late Stream favouriteStream;

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    favouriteStream = fetchUserFavourites();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 11,
              backgroundColor: Colors.transparent,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              leading: null,
              title: Text(
                "Saved List",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ];
        },
        body: StreamBuilder(
          stream: favouriteStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error"),
              );
            } else if (snapshot.hasData) {
              return buildFavouritePage(context);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.active) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildFavouritePage(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
            //   color: Theme.of(context).colorScheme.outline,
            ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: const SizedBox(
        width: 300,
        height: 50,
        child: Center(child: Text('Outlined Card')),
      ),
    );
  }
}

Stream fetchUserFavourites() async* {
  final prefs = await SharedPreferences.getInstance();
  final _id = prefs.getInt('id');

  print("fetch business id${_id}");

  final response = await http.post(
    Uri.parse("http://localhost:8000/api/business/fetch/favourite"),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.getString("token")}'
    },
  );
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    yield data;
  } else {
    throw response.body.toString();
  }
}
