// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, avoid_unnecessary_containers
/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/network/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/screens/chat_screen.dart';
import 'package:flutter_application_1/screens/models/message_modal.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({Key? key}) : super(key: key);

  @override
  _ConversationsPageState createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  final client = StreamChatClient(
    'vqe6zf3pjavt',
    logLevel: Level.INFO,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Conversations',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        elevation: 1,
        backgroundColor: Theme.of(context).canvasColor,
        /*leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.blueAccent,
          onPressed: () {
            Drawer();
          },
        ),*/
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.blueAccent,
            onPressed: () {
              showSearch(context: context, delegate: MySearchDelegate());
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen(
                  user: chat.sender,
                  id: chat.sender.id,
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: chat.unread
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 2,
                                    color: Theme.of(context).primaryColor),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  )
                                ],
                              )
                            : BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 0,
                                    color: Theme.of(context).primaryColor),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 0,
                                  )
                                ],
                              ),
                        child: CircleAvatar(
                          /* backgroundImage: AssetImage('assets/images/hulk.jpg'),*/
                          radius: 35,
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 20),
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${chat.sender.name}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      chat.sender.isOnline
                                          ? Container(
                                              margin: EdgeInsets.only(left: 5),
                                              width: 7,
                                              height: 7,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blue[200],
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                  Text(
                                    '${chat.time}',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${chat.text}',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black54),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  late List<String> suggestions;
  late List<String> searchResults = [
    'Brazil',
    'china',
    'Nigeria',
    'usa',
    'uk',
    'canada'
  ];

  @override
  Widget? buildLeading(context) => IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back),
      );
  @override
  List<Widget>? buildActions(context) => [
        IconButton(
          onPressed: () {
            query.isEmpty ? close(context, null) : query = '';
          },
          icon: Icon(Icons.clear),
        )
      ];
  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(query, style: const TextStyle(fontSize: 64)),
      );
  @override
  Widget buildSuggestions(BuildContext context) {
    suggestions = searchResults.where((searchResults) {
      final result = searchResults.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return Expanded(
          child: ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;
              showResults(context);
            },
          ),
        );
      },
    );
  }
}
*/