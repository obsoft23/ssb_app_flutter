// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace, camel_case_types, unused_import, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, non_constant_identifier_names, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_final_fields, unnecessary_null_comparison, unused_field

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/components/view_business_accpage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_application_1/screens/components/email_support.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:flutter_application_1/network/api.dart';
import 'package:flutter_application_1/screens/components/old/edit_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_application_1/screens/components/change_password.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/screens/components/old/upload_business_images.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:intl/intl.dart' as intl;
import 'package:http/http.dart' as http;
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:filter_list/filter_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_application_1/screens/components/form_date.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ManageBusinessAccount extends StatefulWidget {
  const ManageBusinessAccount({Key? key}) : super(key: key);

  @override
  _ManageBusinessAccountState createState() => _ManageBusinessAccountState();
}

late List<String> searchResults = [];
TextEditingController businessSubCatorgyController = TextEditingController();

//hours
TextEditingController openinghoursController = TextEditingController();

TextEditingController closinghoursController = TextEditingController();

class _ManageBusinessAccountState extends State<ManageBusinessAccount> {
  late Stream profileStream;
  late Stream photosStream;

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

  final singlePicker = ImagePicker();
  final CarouselController _controller = CarouselController();
  final _formKey = GlobalKey<FormState>();
  final _key1 = GlobalKey<FormState>();

  //import 'package:

  TextEditingController businessName = TextEditingController();
  TextEditingController businessDescription = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postalController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countyController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();

  StreamController? streamController;

  List<Text> businessSubCategories = [
    Text("Nursing"),
    Text("Medicine"),
    Text("Physiotherapist"),
    Text("Uk"),
    Text("Australia"),
    Text("Africa"),
    Text("New zealand"),
    Text("Germany"),
    Text("Italy"),
    Text("Russia"),
    Text("China"),
  ];

  @override
  void initState() {
    getCurrentLocation();
    getVocationsList();
    profileStream = fetchBusinessProfile();
    photosStream = fetchPhotos();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // load();
  }

  @override
  Widget build(BuildContext context) {
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
                "Manage Professional Account",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
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
                                    builder: (context) => optionList());
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
          ];
        },
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
      ),
    );
  }

  Widget businessPage() {
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
                                          setState(() {
                                            _current = index;
                                          });
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
              Positioned(
                top: 250,
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
                    "email : ${profile.emailController!}",
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
                      showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) => openEditDetails(),
                      );
                      // Respond to button press
                    },
                    label: Text("Edit Personal Details"),
                    icon: Icon(Icons.add, size: 18),
                  ),
                ),
                Spacer(),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) => ViewBusinessAccpage(
                          businessName: profile.businessName,
                          id: profile.businessId,
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.white,
                      child: Icon(CupertinoIcons.eye),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          /* Container(
            height: 50,
            color: Colors.grey[400],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Professional Details ",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),*/
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
              ? Row(
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

  Widget optionList() {
    return Container(
      height: MediaQuery.of(context).size.height * 3.30,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 85,
              height: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Container(
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              // leading: Icon(Icons.cabin_outlined),
              leading: Icon(Icons.location_on),
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

                showMaterialModalBottomSheet(
                  context: context,
                  builder: (context) => openBusinessImages(),
                );
              },
            ),
            ListTile(
              leading: Icon(CupertinoIcons.clock),
              title: Text('Manage Business Hours'),
              onTap: () {
                Navigator.pop(context);
                showMaterialModalBottomSheet(
                  context: context,
                  builder: (context) => businessHours(),
                );
              },
            ),
            ListTile(
              leading: Icon(CupertinoIcons.calendar_badge_plus),
              title: Text('Manage Active Days'),
              onTap: () {
                Navigator.pop(context);
                activeDaysDialog();
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

  editActiveTimes() {}

  buildClosingTime() {}

  Widget businessHours() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              fetchBusinessProfile();
            });
          },
          child: Container(
            margin: EdgeInsets.only(left: 8),
            child: Center(
              child: Icon(Icons.arrow_back_ios, color: Colors.blue, size: 16),
            ),
          ),
        ),
        actions: [],
        title: Text(
          "Manage Business Hours",
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Form(
            key: _key1,
            child: Container(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                readOnly: true,
                controller: openinghoursController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select opening hours';
                  }
                  return null;
                },
                onTap: () {
                  DatePicker.showTimePicker(
                    context,
                    showTitleActions: true,
                    onChanged: (date) {
                      print(date);
                    },
                    onConfirm: (date) {
                      var newOpeningDate;
                      /* if (date.microsecond.toString() == "0") {
                        newOpeningDate =
                            date.hour.toString() + ":" + date.minute.toString();
                      } else {
                        newOpeningDate = date.hour.toString() +
                            ":" +
                            date.minute.toString() +
                            ":" +
                            date.microsecond.toString();
                      }*/
                      newOpeningDate = date.toString();
                      openinghoursController.text = newOpeningDate;
                    },
                    currentTime: DateTime.now(),
                  );
                },
                decoration: InputDecoration(
                  labelText: 'Opening Hours*',
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              controller: closinghoursController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select  closing hours';
                }
                return null;
              },
              readOnly: true,
              onTap: () {
                DatePicker.showTimePicker(
                  context,
                  showTitleActions: true,
                  onChanged: (date) {
                    print('change $date');
                  },
                  onConfirm: (date) {
                    var newClosingTime;
                    newClosingTime = date.toString();
                    closinghoursController.text = newClosingTime;
                  },
                  currentTime: DateTime.now(),
                  locale: LocaleType.en,
                );
              },
              decoration: InputDecoration(
                labelText: 'Closing Hours*',
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                if (_key1.currentState!.validate()) {
                  updateBusinessHours(
                      openinghoursController.text, closinghoursController.text);
                }
              },
              child: Text(
                'Update Business Hours',
                style: TextStyle(color: Colors.blue),
              )),
        ],
      ),
    );
  }

  Widget openEditDetails() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              fetchBusinessProfile();
            });
          },
          child: Container(
            margin: EdgeInsets.only(left: 8),
            child: Center(
              child: Icon(Icons.arrow_back_ios, color: Colors.blue, size: 16),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                updateUserBusinessDetails();
              } else {}
            },
            child: isLoading
                ? SizedBox(
                    width: 30,
                    height: 25,
                    child: Image.asset("assets/images/loader2.gif"),
                  )
                : Center(
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        "Done",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
        title: Text(
          "Edit Professional Details",
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
      body: StreamBuilder(
        stream: fetchBusinessProfile(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return buildEditDetails(context);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }

  Future getVocationsList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse("http://localhost:8000/api/vocations/fetch"),
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
        //setState(() {});
      }

      return data;
    } else {
      debugPrint(response.body);
    }
  }

  openBusinessImages() {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              profileStream = fetchBusinessProfile();
            });
          },
          child: Container(
            margin: EdgeInsets.only(left: 8),
            child: Center(
              child: Icon(Icons.arrow_back_ios, color: Colors.blue, size: 16),
            ),
          ),
        ),
        title: Text(
          "Manage Business Images",
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
      body: StreamBuilder(
        stream: fetchPhotos(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return buildManagePhotos(context);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),

      /*,*/
    );
  }

  activeDaysDialog() async {
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

        updateActiveDays();

        Navigator.pop(context);
      },
    );
  }

  Future updateUserBusinessDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final _data = {
      "phone": phoneController.text,
      "business_descripition": businessDescription.text,
      "business_sub_category": businessSubCatorgyController.text,
      "business_id": prefs.getInt("business_id"),
    };
    print(_data);
    final request = await http.post(
      Uri.parse("http://localhost:8000/api/business/update/details"),
      body: jsonEncode(_data),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },
    );

    if (request.statusCode == 200) {
      final data = json.decode(request.body);

      print("data receieved from updating acc details${data}");

      if (data["success"] == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            elevation: 30,
            behavior: SnackBarBehavior.floating,
            content: Text("details  succesfully updated"),
          ),
        );
        Navigator.of(context).pop();
        setState(() {
          profileStream = fetchBusinessProfile();
        });
      } else {
        debugPrint("error data ${data}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black,
            elevation: 30,
            behavior: SnackBarBehavior.floating,
            content: Text("Active not Updated"),
          ),
        );
        setState(() {
          profileStream = fetchBusinessProfile();
        });
      }
    } else {
      print(request.body);
    }
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
          addressController.text = result.formattedAddress!;
          businessLatitude = result.geometry!.location.lat.toString();
          businessLongtitude = result.geometry!.location.lng.toString();

          for (var i in result.addressComponents!) {
            print("${i.types.toString()}: " + i.longName);
            if (i.types.first == "street_number") {
              print("her postal code ${i.longName}");
              houseNoController.text = i.longName;
            }

            if (i.types.first == "postal_code") {
              print("her postal code ${i.longName}");
              postalController.text = i.longName;
            }

            if (i.types.first == "administrative_area_level_2") {
              print("here is the  ${i.longName}");
              countyController.text = i.longName;
            }
            if (i.types.first == "postal_town" || i.types.first == "locality") {
              print("here is the town ${i.longName}");
              cityController.text = i.longName;
            }
            if (i.types.first == "country") {
              print(" country ${i.longName}");
              countryController.text = i.longName;
            }
          }
          setState(() {
            profileStream = fetchBusinessProfile();
          });
          updateBusinessAddress(
            addressController.text,
            houseNoController.text,
            postalController.text,
            cityController.text,
            countyController.text,
            countryController.text,
          );
          Navigator.pop(context);
        });
  }

  updateBusinessHours(openingTime, closingTime) async {
    final prefs = await SharedPreferences.getInstance();
    final _data = {
      "opening_time": openingTime,
      "closing_time": closingTime,
      "business_id": prefs.getInt("business_id"),
    };

    final request = await http.post(
      Uri.parse("http://localhost:8000/api/business/update/hours"),
      body: jsonEncode(_data),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },
    );

    if (request.statusCode == 200) {
      final data = json.decode(request.body);
      print("data receieved from updating address${data}");
      if (data["success"] == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            elevation: 30,
            behavior: SnackBarBehavior.floating,
            content: Text("Business Hours succesfully updated"),
          ),
        );
        Navigator.pop(context);
        setState(() {
          profileStream = fetchBusinessProfile();
        });
      } else {
        debugPrint(data);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black,
            elevation: 30,
            behavior: SnackBarBehavior.floating,
            content: Text("Business Hours not updated"),
          ),
        );
        setState(() {
          profileStream = fetchBusinessProfile();
        });
      }
    }
  }

  updateBusinessAddress(
    address,
    houseNo,
    postalCode,
    city,
    county,
    country,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final _data = {
      "full_address": address,
      "house_no": houseNo,
      "postal_code": postalCode,
      "city_or_town": city,
      "county_locality": county,
      "country_nation": country,
      "latitude": businessLatitude,
      "longtitude": businessLongtitude,
      "business_id": prefs.getInt("business_id"),
    };

    final request = await http.post(
      Uri.parse("http://localhost:8000/api/business/update/address"),
      body: jsonEncode(_data),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },
    );

    if (request.statusCode == 200) {
      final data = json.decode(request.body);
      print("data receieved from updating address${data}");
      if (data["success"] == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            elevation: 30,
            behavior: SnackBarBehavior.floating,
            content: Text("Address  succesfully updated"),
          ),
        );
        setState(() {
          profileStream = fetchBusinessProfile();
        });
      } else {
        print("unable to uodate address$data");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            elevation: 30,
            behavior: SnackBarBehavior.floating,
            content: Text("Address not Updated"),
          ),
        );
        setState(() {
          profileStream = fetchBusinessProfile();
        });
      }
    }
  }

  Stream fetchPhotos() async* {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final int? business_id = localStorage.getInt("business_id");
    final response = await http.get(
      Uri.parse(
          "http://localhost:8000/api/business-photos/fetch/${business_id}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      // final body = response.body;

      List data = jsonDecode(response.body);
      try {
        for (var i = 0; i < data.length; i++) {
          print(data[i][0]);
          String? image_name = data[i]["image_name"];
          final index = data[i]["image_order_index"];
          if (index != null) {
            switch (index) {
              case "1":
                singleImage = Image.network(
                  "http://localhost:8000/api/fetch-business-acc-image/${image_name}",
                  fit: BoxFit.cover,
                );

                print("here is single image url${index}");

                break;
              case "2":
                secondImage = Image.network(
                  "http://localhost:8000/api/fetch-business-acc-image/${image_name}",
                  fit: BoxFit.cover,
                );

                print("here is single image url${index}");

                break;
              case "3":
                thirdImage = Image.network(
                  "http://localhost:8000/api/fetch-business-acc-image/${image_name}",
                  fit: BoxFit.cover,
                );

                print("here is single image url${index}");
                break;
              case "4":
                fourthImage = Image.network(
                  "http://localhost:8000/api/fetch-business-acc-image/${image_name}",
                  fit: BoxFit.cover,
                );

                print("here is single image url${index}");

                break;
              default:
                print("index fetched ${index} but  no correct index");
                break;
            }
          }
        }
        yield data;
      } catch (error) {
        print(error);
      }
    } else {
      yield response.body;
    }
  }

  Future chooseSingleImage(index) async {
    final pickedImage = await singlePicker.getImage(
      source: ImageSource.gallery,
      imageQuality: 0,
    );

    if (pickedImage != null) {
      print(pickedImage.path);
      var cropped = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ),
        compressQuality: 100,
        maxHeight: 700,
        maxWidth: 700,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.blue,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          )
        ],
      );
      if (cropped != null) {
        imageTemp = File(cropped.path);

        switch (index) {
          case 1:
            singleImage = Image.file(
              imageTemp!,
              fit: BoxFit.cover,
            );

            uploadBusinessPhotos(cropped, index);
            setState(() {});
            break;
          case 2:
            secondImage = Image.file(
              imageTemp!,
              fit: BoxFit.cover,
            );

            uploadBusinessPhotos(cropped, index);
            setState(() {});
            break;
          case 3:
            thirdImage = Image.file(
              imageTemp!,
              fit: BoxFit.cover,
            );

            uploadBusinessPhotos(cropped, index);
            setState(() {});
            break;
          case 4:
            fourthImage = Image.file(
              imageTemp!,
              fit: BoxFit.cover,
            );

            uploadBusinessPhotos(cropped, index);
            setState(() {});
            break;
          default:
            print("index inserted is${index} but  no match");
        }
      } else {
        return;
      }
    } else {
      print("NO IMAGE SELECTED INDEX - ${index}");
    }

    setState(() {});
  }

  Widget buildEditDetails(context) {
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter phone no';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Phone*',
                hintText: 'Please enter official phone...',
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              controller: businessDescription,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some description';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // filled: true,
                hintText: 'Please enter a short description...',
                labelText: 'Description*',
              ),
              onChanged: (value) {
                profile.description = value;
              },
              maxLines: 5,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            //color: Colors.black,
            child: TextFormField(
              controller: businessSubCatorgyController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select an option';
                }
                return null;
              },
              readOnly: true,
              onTap: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
              decoration: InputDecoration(
                labelText: 'Profession*',
                border: UnderlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget buildManagePhotos(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //image 1
            Container(
              height: 50,
              color: Colors.grey[400],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Image  - 1 ",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    context: context,
                    builder: (context) => sourceList(1));
              },
              child: singleImage == null
                  ? Container(
                      padding: EdgeInsets.all(10),
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
                    )
                  : Container(
                      padding: EdgeInsets.all(10),
                      width: 600,
                      height: MediaQuery.of(context).size.height * .45,
                      child: singleImage!),
            ),

            Divider(),

            //adding image 2
            Container(
              height: 50,
              color: Colors.grey[400],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Image - 2 ",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    context: context,
                    builder: (context) => sourceList(2));
              },
              child: secondImage == null
                  ? Container(
                      padding: EdgeInsets.all(10),
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
                    )
                  : Container(
                      padding: EdgeInsets.all(10),
                      width: 600,
                      height: MediaQuery.of(context).size.height * .45,
                      child: secondImage),
            ),

            Divider(),

            //adding image 3
            Container(
              height: 50,
              color: Colors.grey[400],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Image  - 3 ",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    context: context,
                    builder: (context) => sourceList(3));
              },
              child: thirdImage == null
                  ? Container(
                      padding: EdgeInsets.all(10),
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
                    )
                  : Container(
                      padding: EdgeInsets.all(10),
                      width: 600,
                      height: MediaQuery.of(context).size.height * .45,
                      child: thirdImage),
            ),

            Divider(),

            //adding image 4
            Container(
              height: 50,
              color: Colors.grey[400],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Image  - 4 ",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    context: context,
                    builder: (context) => sourceList(4));
              },
              child: fourthImage == null
                  ? Container(
                      padding: EdgeInsets.all(10),
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
                    )
                  : Container(
                      padding: EdgeInsets.all(10),
                      width: 600,
                      height: MediaQuery.of(context).size.height * .45,
                      child: fourthImage),
            ),

            Divider(),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget sourceList(index) {
    return Container(
      height: 150,
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
            leading: Icon(CupertinoIcons.capsule),
            title: Text('Choose From Gallery - Frame ${index}'),
            onTap: () {
              Navigator.pop(context);
              print("image 1");
              chooseSingleImage(index);
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.list_bullet),
            title: Text('Remove Image'),
            onTap: () {
              singleImage = null;

              (index);
              setState(() {});
              Navigator.pop(context);
              switch (index) {
                case 1:
                  singleImage = null;

                  break;
                case 2:
                  secondImage = null;
                  break;
                case 3:
                  thirdImage = null;
                  break;
                case 4:
                  fourthImage = null;
                  break;
                default:
                  print("index inserted is${index} but  no match");
              }

              // chooseImage();
            },
          ),
        ],
      ),
    );
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

  updateActiveDays() async {
    //print(_data);
    final prefs = await SharedPreferences.getInstance();
    final _data = {
      "active_days": newselectedOpeningDayList,
      "business_id": prefs.getInt("business_id")
    };

    final response = await http.post(
      Uri.parse("http://localhost:8000/api/business/update/active_days"),
      body: jsonEncode(_data),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["success"] == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            elevation: 30,
            behavior: SnackBarBehavior.floating,
            content: Text("Active Days Updated"),
          ),
        );
        setState(() {
          profileStream = fetchBusinessProfile();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black,
            elevation: 30,
            behavior: SnackBarBehavior.floating,
            content: Text("Active not Updated"),
          ),
        );
      }
    }
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
      if (profile.businessDescription != null) {
        businessDescription.text = profile.businessDescription;
      }

      if (profile.phoneController != null) {
        phoneController.text = profile.phoneController;
      }

      if (profile.openingTime != null) {
        openinghoursController.text = profile.openingTime;
      }

      if (profile.closingTime != null) {
        closinghoursController.text = profile.closingTime;
      }
      yield data;
    } else {
      throw response.body.toString();
    }
  }

  Future uploadBusinessPhotos(image, index) async {
    print("photo with the index of - ${index} trying to upload a photo");
    String filename = image.path.split('/').last;
    final prefs = await SharedPreferences.getInstance();
    final _id = prefs.getInt("business_id");

    final _token = prefs.getString("token");
    FormData _data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        image.path,
        filename: filename,
        contentType: MediaType("image", "jpg"),
      ),
      "filename": filename,
      "index": index,
      "business_id": _id
    });
    print(_id);
    try {
      final request = await Dio()
          .post(
        "http://localhost:8000/api/business/photos/add",
        data: _data,
        options: Options(
          headers: {'Authorization': 'Bearer ${prefs.getString("token")}'},
        ),
      )
          .then((response) {
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text("image uploaded  successfully..."),
              duration: const Duration(seconds: 6),
            ),
          );
          setState(() {});
        } else {
          print(response);
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            elevation: 30,
            behavior: SnackBarBehavior.floating,
            content: Text("${error.values.first[0]}"),
          ),
        );
      });

      // setState(() {});
    } catch (error) {
      print("whats going on ${error}");
    }
  }

  Future removeBusinessImage(index) async {
    final prefs = await SharedPreferences.getInstance();
    final _id = prefs.getInt("business_id");
    final _token = prefs.getString("token");
    final data = {
      "business_id": _id,
      "index": index,
    };

    final response = await http.post(
        Uri.parse("http://localhost:8000/api/business/delete/add/${_id}"),
        body: data,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_token}'
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
  final int? businessId;
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
  final int? likes;

  final String? businessSubCatorgyController;
  var latitude;
  var longtitude;
  final double? rating;
  final String? joined;
  final List<dynamic>? activeDays;

  BusinessProfile({
    this.businessId,
    this.businessName,
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
    this.businessSubCatorgyController,
    this.latitude,
    this.longtitude,
    this.rating,
    this.joined,
    this.activeDays,
    this.likes,
  });

  factory BusinessProfile.fromJson(Map<String, dynamic> json) {
    return BusinessProfile(
      businessId: json["business_account_id"],
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
      businessSubCatorgyController: json["business_sub_category"],
      latitude: json["latitude"],
      longtitude: json["longtitude"],
      rating: json["rating"],
      joined: json["created_at"],
      likes: json["likes"],
      activeDays: json["active_days"].toList(),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  late List<String> suggestions;

  // final response = await http.get(Uri.parse(""));

  @override
  Widget? buildLeading(context) => IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios, size: 15),
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
  buildResults(context) {
    return Center(child: Text(query, style: const TextStyle(fontSize: 64)));
    //  businessSubCatorgyController.text = query;
  }

  selectAction() {}

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
          child: Column(
            children: [
              ListTile(
                title: Text(suggestion),
                onTap: () {
                  query = suggestion;
                  businessSubCatorgyController.text = query;
                  print(suggestion);
                  close(context, null);
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

class CustomPicker extends DatePickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime? currentTime, LocaleType? locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    setLeftIndex(this.currentTime.hour);
    setMiddleIndex(this.currentTime.minute);
    setRightIndex(this.currentTime.second);
  }

  @override
  String? leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            currentLeftIndex(), currentMiddleIndex(), currentRightIndex())
        : DateTime(
            currentLeftIndex(), currentMiddleIndex(), currentRightIndex());
  }
}
