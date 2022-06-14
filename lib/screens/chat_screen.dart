// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, avoid_unnecessary_containers

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/models/user_model.dart';
import 'package:flutter_application_1/screens/models/message_modal.dart';
import 'package:flutter_application_1/screens/components/details.dart';

class ChatScreen extends StatefulWidget {
  final User user;
  final int id;

  const ChatScreen({Key? key, required this.user, required this.id})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _sendmessagecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _sendmessagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.user.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextSpan(text: '\n'),
              widget.user.isOnline
                  ? TextSpan(
                      text: 'online',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                    )
                  : TextSpan(
                      text: 'offline',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                    ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsPage(user: widget.user),
                  ),
                );
              },
              icon: Icon(
                (Icons.more_horiz_rounded),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: messages.length,
              reverse: true,
              itemBuilder: (context, index) {
                final Message message = messages[index];
                final isMe = message.sender.id == currentUser.id;
                return chatBubble(message, isMe);
              },
            ),
          ),
          sendMessageContainer(context),
        ],
      ),
    );
  }

  Widget sendMessageContainer(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.photo),
              iconSize: 30,
              color: Colors.blue,
            ),
            Expanded(
              child: TextField(
                controller: _sendmessagecontroller,
                decoration:
                    InputDecoration.collapsed(hintText: 'send a message'),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.send),
                iconSize: 30,
                color: Colors.blue),
          ],
        ),
      ),
    );
  }

  chatBubble(message, bool isMe) {
    if (isMe) {
      return Column(
        children: [
          /*sending isME */
          Container(
            alignment: Alignment.topRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.80,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ]),
                    child: Text('${message.text}',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                Container(
                  child: Text(
                    '${message.time}',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      /*recieving column */
      return Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.80,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          )
                        ]),
                    child: Text('${message.text}'),
                  ),
                ),
                Container(
                  child: Text(
                    '${message.time}',
                    style: TextStyle(color: Colors.grey[500], fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget sendMessageArea() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        height: 7,
        color: Colors.white,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.photo),
              iconSize: 25,
              color: Colors.blueAccent,
            ),
            TextField(
              decoration: InputDecoration.collapsed(hintText: 'Send Message'),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.send),
              iconSize: 25,
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }

  /* */
}
