// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application_1/network/api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/screens/components/search_page_body.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

late List<String> searchResults = [];
var latitude;
var longtitude;
var userLocation;
var town;
var area;
var country;

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    getVocationsList();

    getCurrentLocation();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading:
            null /*IconButton(
          icon: Icon(Icons.settings),
          color: Colors.blueAccent,
          onPressed: () {},
        )*/
        ,
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.search),
            color: Colors.blueAccent,
            onPressed: () {
              showSearch(context: context, delegate: MySearchDelegate());
            },
          ),
          /*
          IconButton(
            icon: FaIcon(FontAwesomeIcons.filter),
            color: Colors.blueAccent,
            iconSize: 17,
            onPressed: () {},
          ),*/
        ],
      ),
      body: SearchPageBody(),
    );
  }

  Future getCurrentLocation() async {
    try {
      LocationPermission permission;
      bool serviceEnabled;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            elevation: 30,
            behavior: SnackBarBehavior.floating,
            content: Text("Location services disabled"),
          ),
        );
        await Geolocator.openAppSettings();
        await Geolocator.openLocationSettings();
      }
      permission = await Geolocator.checkPermission();
      if (permission != LocationPermission.denied ||
          permission != LocationPermission.deniedForever) {
        final position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        userLocation = LatLng(position.latitude, position.longitude);
        latitude = position.latitude;
        longtitude = position.longitude;
        print(userLocation);

        List placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude,
            localeIdentifier: "en_UK");
        //  List placemarks = await placemarkFromCoordinates(54.1113876, -3.2178761,
        // localeIdentifier: "en_UK]");
        print(" lets get user locations${placemarks[0].toString()}");
        country = placemarks[0].country.toString();
        town = placemarks[0].locality.toString();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            elevation: 30,
            behavior: SnackBarBehavior.floating,
            content: Text(
                "location permission reaquired - please check your settings"),
          ),
        );
        await Geolocator.openAppSettings();
        await Geolocator.openLocationSettings();
      }
    } catch (e) {
      print(e);
    }
  }

  Future getVocationsList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse("${Network.baseURL}/api/vocations/fetch"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < data.length; i++) {
          final vocation = data[i]["vocations"];
          searchResults.add(vocation);
          print(data[i]["vocations"]);
        }
        setState(() {});
      }

      return data;
    } else {
      debugPrint(response.body);
    }
  }
}

class MySearchDelegate extends SearchDelegate {
  late List<String> suggestions;

  @override
  Widget? buildLeading(context) => IconButton(
        onPressed: () {
          accs.clear();
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
  Widget buildResults(BuildContext context) => StreamBuilder(
        stream: findUserRequest(query),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          } else if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                searchStatus == false
                    ? Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: SizedBox(
                              width: 300,
                              height: 100,
                              child: Text(
                                  "Sorry ... we could not find any $query around you"),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 10,
                      ),
                Expanded(
                  child: businessList(),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.green,
            ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
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
        print("searched result here says $suggestion");
        return Expanded(
          child: Column(
            children: [
              ListTile(
                title: Text(suggestion),
                onTap: () {
                  query = suggestion;
                  showResults(context);
                },
              ),
              Divider()
            ],
          ),
        );
      },
    );
  }
}
