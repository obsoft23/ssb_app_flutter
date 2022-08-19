// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, unused_field

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/network/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/profile.dart';

class BusinessProfilepage extends StatefulWidget {
  const BusinessProfilepage({Key? key}) : super(key: key);

  @override
  State<BusinessProfilepage> createState() => _BusinessProfilepageState();
}

class _BusinessProfilepageState extends State<BusinessProfilepage> {
  final Map<String, dynamic> _user = {
    "name": "Olafemi Arowosegbe",
    "email": "eclat@inteswitch.com",
    "about":
        "Quick check is a soft-search tool that determines if you'll be pre-approved for the thinkmoney Credit Card in 60 seconds, without affecting your Credit Score. This means it's risk-free to check your eligibility, so you can apply with confidence. Top Features: 1.) Up to £1,500 credit limit 2.) No annual fee 3.) One interest rate for all transactions 4.) Manage your account online with our easy-to-use mobile ap",
    "isDarkMode": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Edit Business Profile',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: SizedBox(
              width: 115,
              height: 115,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(),
                  _pickprofileimage(),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          _builduserprofile(),
          SizedBox(height: 24),
          _numbersWidget(),
          biosection(),
        ],
      ),
    );
  }

  _builduserprofile() => Column(
        children: [
          Text(
            _user['name'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 4),
          Text(
            _user['email'],
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Edit Professional Account'),
            ),
          )
        ],
      );

  Widget _pickprofileimage() => Positioned(
        right: -1,
        bottom: -7,
        child: SizedBox(
          height: 46,
          width: 46,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
              border: Border.all(
                width: 3,
                color: Colors.white,
              ),
            ),
            child: IconButton(
              color: Colors.white,
              iconSize: 16,
              icon: Icon(Icons.edit),
              onPressed: () {
                //leading
              },
            ),
          ),
        ),
      );

  Widget _numbersWidget() => IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "2.0",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  Text(
                    "Rating",
                    style: TextStyle(),
                  )
                ],
              ),
            ),
            buildDivider(),
            MaterialButton(
              onPressed: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "35",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  Text(
                    "Likes",
                    style: TextStyle(),
                  )
                ],
              ),
            ),
            buildDivider(),
            MaterialButton(
              onPressed: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "10",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  Text(
                    "Reviews",
                    style: TextStyle(),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildDivider() => SizedBox(
        child: VerticalDivider(),
        height: 24,
      );

  Widget biosection() => Container();
}
  
  /* */

