// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace, camel_case_types, unused_import, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, non_constant_identifier_names, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_final_fields, unnecessary_null_comparison, unused_field, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/components/manage_business_account.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewBusinessAccpage extends StatelessWidget {
  final String? businessName;
  final int? id;

  ViewBusinessAccpage({Key? key, required this.businessName, required this.id})
      : super(key: key);

  var profile;
  DateTime _dateTime = DateTime.now();
  bool isLoading = false;
  var selectedValue;
  var selectedOpeningDayList = [];
  var newselectedOpeningDayList = [];
  var userLocation;
  var latitude;
  var longtitude;
  List businessImages = [];
  int _current = 0;
  var imageTemp;
  var singleImage;
  var secondImage;
  var thirdImage;
  var fourthImage;
  var businessLatitude;
  var businessLongtitude;
  var openingTime;
  var closingTime;
  var postOpeningTime;
  var postClosingTime;
  String? phoneController;
  String? businessDescription;

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Center(
                    child: Icon(Icons.arrow_back_ios,
                        color: Colors.blue, size: 16),
                  ),
                ),
              ),
              title: Text(
                "${businessName}",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              actions: [
                Center(
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.ellipsis,
                        color: Colors.blue,
                        size: 15,
                      )),
                ),
              ],
            ),
          ];
        },
        body: FutureBuilder(
          future: fetchBusinessProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error"),
              );
            } else if (snapshot.hasData) {
              return buildViewPage();
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

  Future fetchBusinessProfile() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    final int? business_id = localStorage.getInt("business_id");

    final response = await http.get(
      Uri.parse(
          "http://localhost:8000/api/business-profile/fetch/${business_id}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("fetch business profile${data}");
      // print("fetch business profile${data["profile"][0]["business_name"]}");
      // print("image business profile${data["images"][0]["image_name"]}");
      profile = BusinessProfile.fromJson(data["profile"][0]);

      final images = data["images"];
      for (var i = 0; i < images.length; i++) {
        // print(images[i]);
        String? image_name = images[i]["image_name"];
        final index = images[i]["image_order_index"];
        print(
            "http://localhost:8000/api/fetch-business-acc-image/${image_name}");
        String name =
            "http://localhost:8000/api/fetch-business-acc-image/${image_name}";
        businessImages.insert(i, name);
      }
      print(businessImages);
      if (profile.businessDescription != null) {
        businessDescription = profile.businessDescription;
      }

      if (profile.phoneController != null) {
        phoneController = profile.phoneController;
      }

      if (profile.openingTime != null) {
        openinghoursController.text = profile.openingTime;
      }

      if (profile.closingTime != null) {
        closinghoursController.text = profile.closingTime;
      }
      return data;
    } else {
      throw response.body.toString();
    }
  }

  buildViewPage() {
    return Container();
  }
}
