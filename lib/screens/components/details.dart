// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, avoid_unnecessary_containers

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/models/user_model.dart';
import 'package:flutter_application_1/screens/models/message_modal.dart';
import 'package:flutter_application_1/network/api.dart';

class DetailsPage extends StatefulWidget {
  final User user;
  const DetailsPage({Key? key, required this.user}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    bool _lights = true;
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          profileArea(context),
          SizedBox(
            height: 20,
          ),
          Divider(
            height: 0,
          ),
          Container(
            /// padding: EdgeInsets.all(8),
            child: Column(
              children: [
                SwitchListTile(
                  title: Text("Mute Notifications",
                      style: TextStyle(fontSize: 16)),
                  value: _lights,
                  onChanged: (bool value) {
                    setState(() {
                      _lights = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text("Block", style: TextStyle(fontSize: 16)),
                  value: _lights,
                  onChanged: (bool value) {
                    setState(() {
                      _lights = value;
                    });
                  },
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Text("Report", style: TextStyle(fontSize: 16)),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container profileArea(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 150,
            height: 100,
            child: Image.asset("assets/images/hulk.jpg"),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(width: 1, color: Theme.of(context).primaryColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                )
              ],
            ),
          ),
          Column(
            children: [
              Text("${widget.user.name}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              // Text('\n'),
              Text("Tap to view profile")
            ],
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Column(
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blueAccent,
                  size: 16,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


/*Container(
                  child: Row(
                    children: [
                      Text("Mute Notifications",
                          style: TextStyle(fontSize: 17)),
                      Spacer(),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Text("Report", style: TextStyle(fontSize: 17)),
                      Spacer(),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Text("Block", style: TextStyle(fontSize: 17)),
                      Spacer(),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                ) */