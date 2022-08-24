// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, avoid_unnecessary_containers

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/network/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/screens/chat_screen.dart';
import 'package:flutter_application_1/screens/models/message_modal.dart';
import 'package:http/http.dart' as http;

class FavChatList extends StatefulWidget {
  const FavChatList({Key? key}) : super(key: key);

  @override
  State<FavChatList> createState() => _FavChatListState();
}

late Stream favouriteStream;

class _FavChatListState extends State<FavChatList> {
  @override
  void initState() {
    favouriteStream = fetchChatList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final bool pagestatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: null,
          title: Text(
            "Saved List",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )),
      body: StreamBuilder(
        stream: favouriteStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          } else if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(height: 10),
                pagestatus == false
                    ? Center(
                        child: Text("No saved Favourite List"),
                      )
                    : Expanded(
                        child: buildFavouritePage(context),
                      ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.active) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  fetchChatList() async {
    final prefs = await SharedPreferences.getInstance();
    final _id = prefs.getInt('id');

    final response = await http.post(
      Uri.parse("${Network.baseURL}/api/business/fetch/chatlist"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
    }
  }

  buildFavouritePage(context) {
    return Container();
  }
}
