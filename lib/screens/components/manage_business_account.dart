// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace, camel_case_types, unused_import, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, non_constant_identifier_names, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/components/email_support.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:flutter_application_1/network/api.dart';
import 'package:flutter_application_1/screens/components/edit_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_application_1/screens/components/change_password.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/screens/components/upload_business_images.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:intl/intl.dart' as intl;
import 'package:http/http.dart' as http;
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:filter_list/filter_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ManageBusinessAccount extends StatefulWidget {
  const ManageBusinessAccount({Key? key}) : super(key: key);

  @override
  _ManageBusinessAccountState createState() => _ManageBusinessAccountState();
}

class _ManageBusinessAccountState extends State<ManageBusinessAccount> {
  late Stream profileStream;
  var profile;
  bool isLoading = false;
  var selectedOpeningDayList = [];
  var newselectedOpeningDayList = [];
  var userLocation;
  var latitude;
  var longtitude;
  List businessImages = [];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  //import 'package:

  StreamController? streamController;

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
    profileStream = fetchBusinessProfile();
  }

  @override
  void dispose() {
    super.dispose();
    load();
  }

  load() async {
    streamController?.add("Loading");
    await Future.delayed(Duration(seconds: 1));
    streamController?.add("Done");
  }

  @override
  void didUpdateWidget(oldWidget) {
    if (true) {
      //something change
      load();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
      latitude = position.latitude;
      longtitude = position.longitude;
      print(userLocation);
    });
  }

  Stream fetchBusinessProfile() async* {
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
      var data = json.decode(response.body);
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
      yield data;
    } else {
      throw response.body.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 8),
            child: Center(
              child: Icon(Icons.arrow_back_ios, color: Colors.blue, size: 16),
            ),
          ),
        ),
        title: Text(
          "Manage Professional Account",
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: isLoading
                ? SizedBox(
                    width: 30,
                    height: 25,
                    child: Image.asset("assets/images/loader2.gif"),
                  )
                : Center(
                    child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20))),
                              context: context,
                              builder: (context) => sourceList());
                        },
                        icon: Icon(
                          FontAwesomeIcons.ellipsis,
                          color: Colors.blue,
                          size: 15,
                        )),
                  ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: profileStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          } else if (snapshot.hasData) {
            return businessPage();
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

  Widget businessPage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .40,
                        child: CarouselSlider(
                          options: CarouselOptions(
                              aspectRatio: 1,
                              enlargeCenterPage: true,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                          items: businessImages
                              .map(
                                (item) => Image.network(
                                  item,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: businessImages.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 200,
                right: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return UploadBusinessImages();
                        }),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 50,
                      color: Colors.white,
                      child: Icon(Icons.edit),
                    ),
                  ),
                ),
              ),
            ],
          ),
          profile.businessName != null
              ? Text(
                  "${profile.businessName}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                )
              : Text(""),
          profile.emailController != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "email : ${profile.emailController}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                )
              : Text(""),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Spacer(),
                Container(
                  width: 275,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Respond to button press
                      setState(() {});
                    },
                    label: Text("Edit Professional Details"),
                    icon: Icon(Icons.add, size: 18),
                  ),
                ),
                Spacer(),
                Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.white,
                    child: Icon(CupertinoIcons.eye),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          profile.phoneController != null
              ? ListTile(
                  leading: Icon(CupertinoIcons.phone),
                  title: Text(
                    '${profile.phoneController}',
                    style: TextStyle(fontSize: 17),
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
                    'Joined on ${profile.joined}',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  onTap: () {},
                  dense: true,
                )
              : Container(child: null),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Container(
                height: 0.2,
                width: MediaQuery.of(context).size.width * .75,
                color: Color(0xffA2A2A2),
              ),
              SizedBox(
                width: 10,
              ),
              TextButton(
                onPressed: () {},
                child: Text("edit"),
              ),
              Spacer(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 8.0, top: 10.0),
                child: Text(
                  "Business description",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ],
          ),
          profile.businessDescription != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${profile.businessDescription}',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : Container(child: null),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Container(
                height: 0.2,
                width: MediaQuery.of(context).size.width * .75,
                color: Color(0xffA2A2A2),
              ),
              SizedBox(
                width: 10,
              ),
              TextButton(
                onPressed: () {},
                child: Text("edit"),
              ),
              Spacer(),
            ],
          ),
          profile.businessCatorgyController != null
              ? ListTile(
                  leading: Icon(Icons.lock_person_outlined),
                  title: Text(
                    'Category : ${profile.businessCatorgyController}',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Reviews and Rating   ",
                style: TextStyle(fontSize: 17),
              ),
              Container(
                height: 0.2,
                width: MediaQuery.of(context).size.width * .50,
                color: Color(0xffA2A2A2),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
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

  Widget sourceList() {
    return Container(
      height: MediaQuery.of(context).size.height * 3.30,
      child: SingleChildScrollView(
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
              leading: Icon(Icons.edit),
              title: Text('Edit Professional Account Details'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.cabin_outlined),
              title: Text('Update Address'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return changePickerAddress();
                  }),
                );

                // chooseImage();
              },
            ),
            ListTile(
              leading: Icon(CupertinoIcons.camera),
              title: Text('Manage Photos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return UploadBusinessImages();
                  }),
                );
              },
            ),
            ListTile(
              leading: Icon(CupertinoIcons.calendar_badge_plus),
              title: Text('Manage Active Days'),
              onTap: () {
                Navigator.pop(context);
                openFilterDialog();
              },
            ),
            ListTile(
              leading: Icon(CupertinoIcons.person_crop_circle_fill_badge_xmark),
              title: Text('Email support'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SupportEmail();
                  }),
                );
              },
            ),
            ListTile(
              leading: Icon(CupertinoIcons.suit_heart),
              title: Text('Help - Information Center'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SupportEmail();
                  }),
                );
              },
            ),
            /* ListTile(
              leading: Icon(CupertinoIcons.settings_solid),
              title: Text('Account Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SupportEmail();
                  }),
                );
              },
            ),*/
            ListTile(
              leading: Icon(CupertinoIcons.battery_charging),
              title: Text('Analytics'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SupportEmail();
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  openFilterDialog() async {
    await FilterListDialog.display<OpeningDay>(
      context,
      listData: openDayList,
      selectedListData: openDayList,
      choiceChipLabel: (openDayList) => openDayList!.weekDay,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (openDayList, query) {
        return openDayList.weekDay!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedOpeningDayList = List.from(list!);
          for (var element in selectedOpeningDayList) {
            print(element.weekDay.toString());
            newselectedOpeningDayList.add(element.weekDay.toString());
          }
        });

        Navigator.pop(context);
      },
    );
  }

  Widget changePickerAddress() {
    return PlacePicker(
        apiKey: "AIzaSyCNpV4UY0noGgT86B134PfGziQODVF1MtE",
        initialPosition: userLocation,
        useCurrentLocation: true,
        region: 'uk',
        selectInitialPosition: true,
        enableMyLocationButton: true,
        enableMapTypeButton: true,
        usePlaceDetailSearch: true,
        onPlacePicked: (result) {
          print(result);
          setState(() {});
          Navigator.pop(context);
        });
  }
}

class OpeningDay {
  final String? weekDay;
  final String? avatar;
  OpeningDay({this.weekDay, this.avatar});
}

List<OpeningDay> openDayList = [
  OpeningDay(weekDay: "Sunday", avatar: ""),
  OpeningDay(weekDay: "Monday ", avatar: ""),
  OpeningDay(weekDay: "Tuesday ", avatar: ""),
  OpeningDay(weekDay: "Wednesday ", avatar: ""),
  OpeningDay(weekDay: "Thursday ", avatar: ""),
  OpeningDay(weekDay: "Friday ", avatar: ""),
  OpeningDay(weekDay: "Saturday ", avatar: ""),
];

class closingDay {
  final String? weekDay;
  final String? avatar;
  closingDay({this.weekDay, this.avatar});
}

List<closingDay> closeDayList = [
  closingDay(weekDay: "Sunday", avatar: ""),
  closingDay(weekDay: "Monday ", avatar: ""),
  closingDay(weekDay: "Tuesday ", avatar: ""),
  closingDay(weekDay: "Wednesday ", avatar: ""),
  closingDay(weekDay: "Thursday ", avatar: ""),
  closingDay(weekDay: "Friday ", avatar: ""),
  closingDay(weekDay: "Saturday ", avatar: ""),
];

class BusinessProfile {
  final String? businessName;
  final String? businessDescription;
  final String? openingTime;
  final String? closingTime;
  final String? emailController;
  final String? phoneController;
  final String? addressController;
  final String? postalController;
  final String? cityController;
  final String? countyController;
  final String? countryController;
  final String? houseNoController;
  final String? businessCatorgyController;
  final String? businessSubCatorgyController;
  final String? latitude;
  final String? longtitude;
  final String? rating;
  final String? joined;
  final List<dynamic>? activeDays;

  BusinessProfile(
      {this.businessName,
      this.businessDescription,
      this.openingTime,
      this.closingTime,
      this.emailController,
      this.phoneController,
      this.addressController,
      this.postalController,
      this.cityController,
      this.countyController,
      this.countryController,
      this.houseNoController,
      this.businessCatorgyController,
      this.businessSubCatorgyController,
      this.latitude,
      this.longtitude,
      this.rating,
      this.joined,
      this.activeDays});

  factory BusinessProfile.fromJson(Map<String, dynamic> json) {
    return BusinessProfile(
      businessName: json["business_name"],
      businessDescription: json["business_descripition"],
      openingTime: json["opening_time"],
      closingTime: json["closing_time"],
      emailController: json["email"],
      phoneController: json["phone"],
      addressController: json["full_address"],
      postalController: json["postal_code"],
      cityController: json["city_or_town"],
      countyController: json["county_locality"],
      countryController: json["country_nation"],
      houseNoController: json["house_no"],
      businessCatorgyController: json["business_category"],
      businessSubCatorgyController: json["business_sub_category"],
      latitude: json["latitude"],
      longtitude: json["longtitude"],
      rating: json["rating"],
      joined: json["created_at"],
      activeDays: json["active_days"].toList(),
    );
  }
}
