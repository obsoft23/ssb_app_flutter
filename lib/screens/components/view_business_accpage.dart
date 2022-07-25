// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace, camel_case_types, unused_import, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, non_constant_identifier_names, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_final_fields, unnecessary_null_comparison, unused_field, must_be_immutable, avoid_unnecessary_containers

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/components/manage_business_account.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.directions),
      ),
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
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                Center(
                  child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20))),
                            context: context,
                            builder: (context) => bottomSheetList(context));
                      },
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
              return buildViewPage(context);
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
    print("fetch business id${id}");

    final response = await http.get(
      Uri.parse("http://localhost:8000/api/business-profile/fetch/${id}"),
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

  buildViewPage(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // SizedBox(height: 24),
          Stack(
            children: [
              SizedBox(height: 24),
              Container(
                margin: EdgeInsets.only(top: 0),
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: Column(
                  children: [
                    businessImages.isNotEmpty
                        ? GestureDetector(
                            onTap: () {},
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: Container(
                                  //  padding: EdgeInsets.all(10),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .40,
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .45,
                                        viewportFraction: 2,
                                        initialPage: 0,
                                        enableInfiniteScroll: true,
                                        reverse: false,
                                        autoPlay: true,
                                        autoPlayInterval: Duration(seconds: 3),
                                        autoPlayAnimationDuration:
                                            Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: true,
                                        scrollDirection: Axis.horizontal,
                                        onPageChanged: (index, reason) {
                                          /*  setState(() {
                                            _current = index;
                                          });*/
                                        }),
                                    items: businessImages
                                        .map(
                                          (item) => Image.network(
                                            item,
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )),
                          )
                        : Container(
                            width: 600,
                            height: MediaQuery.of(context).size.height * .30,
                            color: Colors.grey,
                            child: Center(
                              child: Icon(
                                CupertinoIcons.camera,
                                color: Colors.white,
                                size: 75,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),

          profile.emailController != null
              ? ListTile(
                  leading: Icon(CupertinoIcons.envelope_badge),
                  title: Text(
                    '${profile.emailController}',
                    style: TextStyle(fontSize: 17, color: Colors.blue),
                  ),
                  onTap: () {},
                  dense: true,
                )
              : Container(child: null),

          profile.phoneController != null
              ? ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(
                    '${profile.phoneController}',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () {},
                  dense: true,
                )
              : Container(child: null),
          profile.addressController != null
              ? ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text(
                    '${profile.addressController}',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  onTap: () {},
                  dense: true,
                )
              : Container(child: null),
          profile.joined != null
              ? ListTile(
                  leading: Icon(Icons.access_time_filled_rounded),
                  title: Text(
                    'Joined ${profile.joined}',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  onTap: () {},
                  dense: true,
                )
              : Container(child: null),
          Stack(
            children: [
              Container(
                height: 50,
                color: Colors.grey[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Bio ",
                      style: GoogleFonts.acme(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          profile.businessDescription != null
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        '${profile.businessDescription}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                )
              : Container(child: null),
          Stack(
            children: [
              Container(
                height: 50,
                color: Colors.grey[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Business Description ",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          profile.businessSubCatorgyController != null
              ? ListTile(
                  leading: Icon(Icons.lock_person_outlined),
                  title: Text(
                    'Category : ${profile.businessSubCatorgyController}',
                    style: TextStyle(fontSize: 17),
                  ),
                  onTap: () {},
                  dense: true,
                )
              : Container(child: null),
          profile.openingTime != null || profile.closingTime != null
              ? ListTile(
                  leading: Icon(Icons.add_task_sharp),
                  title: Text(
                    'Opened  between ${profile.openingTime} am - ${profile.closingTime} pm',
                    style: TextStyle(fontSize: 17),
                  ),
                  onTap: () {},
                  dense: true,
                )
              : Container(child: null),
          profile.activeDays != null
              ? ListTile(
                  //  leading: Icon(Icons.add_task_sharp),
                  title: Text(
                    'We opened on : ${profile.activeDays.toString()}',
                    style: TextStyle(fontSize: 17),
                  ),
                  onTap: () {},
                  dense: true,
                )
              : Container(child: null),
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Container(
                height: 50,
                color: Colors.grey[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Reviews and Rating ",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          ListTile(
            leading: FlutterLogo(size: 72.0),
            title: Text('Three-line ListTile'),
            subtitle:
                Text('A sufficiently long subtitle warrants three lines.'),
            trailing: RatingBar.builder(
              initialRating: 4,
              minRating: 3,
              itemSize: 10,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            isThreeLine: true,
          ),
          ListTile(
            leading: FlutterLogo(size: 72.0),
            title: Text('Three-line ListTile'),
            subtitle:
                Text('A sufficiently long subtitle warrants three lines.'),
            trailing: RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              itemSize: 10,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            isThreeLine: true,
          ),
          ListTile(
            leading: FlutterLogo(size: 72.0),
            title: Text('Three-line ListTile'),
            subtitle:
                Text('A sufficiently long subtitle warrants three lines.'),
            trailing: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              itemSize: 10,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            isThreeLine: true,
          ),

          SizedBox(height: 50),
        ],
      ),
    );
  }

  Container bottomSheetList(context) {
    return Container(
      height: 160,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 45,
            height: 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Container(
              color: Colors.grey[400],
            ),
          ),
          ListTile(
            leading: Icon(Icons.report_problem),
            title: Text('Report'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.block_sharp),
            title: Text('Block'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
