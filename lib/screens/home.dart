// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_typing_uninitialized_variables, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_application_1/network/api.dart';
import 'package:flutter_application_1/screens/favourites.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/screens/conversations.dart';
import 'package:flutter_application_1/screens/notifications.dart';
import 'package:flutter_application_1/screens/profile.dart';
import 'package:flutter_application_1/screens/search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  final userId;
  const HomePage({Key? key, this.userId}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final prefs = SharedPreferences.getInstance();
  int _selectedIndex = 1;
  var _gottenToken;
  final possibleColor = Color(0xff26A9FF);

  static final _widgetOptions = [
    FavouritesPage(),
    SearchPage(),
    NotificationsPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {});
    _selectedIndex = index;
  }

  @override
  void initState() {
    super.initState();

    _gottenToken = prefs.then((SharedPreferences prefs) {
      return prefs.getString('token') ?? 0;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            // icon: Icon(Icons.bubble_chart_rounded),
            icon: FaIcon(FontAwesomeIcons.penClip, size: 22),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bell),
            label: 'inbox',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: 'profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
        iconSize: 25,
        //selectedFontSize: 20
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
