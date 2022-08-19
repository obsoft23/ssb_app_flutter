// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, unused_field, sized_box_for_whitespace, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:flutter_application_1/network/api.dart';
import 'package:flutter_application_1/screens/business_profile_slider.dart';
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
import 'package:flutter_application_1/screens/components/upload_business_images.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:intl/intl.dart' as intl;
import 'package:http/http.dart' as http;
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:filter_list/filter_list.dart';
import 'package:time_range_picker/time_range_picker.dart';

class Professional extends StatefulWidget {
  const Professional({Key? key}) : super(key: key);

  @override
  _ProfessionalState createState() => _ProfessionalState();
}

TextEditingController businessSubCatorgyController = TextEditingController();
TextEditingController scrollController = TextEditingController();

late List<String> searchResults = [];

class _ProfessionalState extends State<Professional> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  DateTime _dateTime = DateTime.now();
  var selectedValue;
  var openingTime;
  var postOpeningTime;
  var postClosingTime;
  var closingTime;
  double? latitude;
  double? longtitude;

  var businessLatitude;
  var businessLongtitude;

  String title = '';
  var description;
//AIzaSyCNpV4UY0noGgT86B134PfGziQODVF1MtE
  double maxValue = 0;
  var userLocation;
  //static var kInitialPosition = LatLng(-33.8567844, 151.213108);

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

  TextEditingController businessCatorgyController = TextEditingController();

  var addressList;
  var selectedOpeningDayList = [];
  var newselectedOpeningDayList = [];

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

  @override
  void initState() {
    getCurrentLocation();
    getVocationsList();
    super.initState();
    // setUserEmail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  setUserEmail() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final email = localStorage.getString('email');
    //  emailController.text = email!;
  }

  Future confirmProfessionalStatus() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    final response = await Network().fetchUser(token);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["has_professional_acc"] == "1") {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            elevation: 30,
            behavior: SnackBarBehavior.floating,
            content: Text("you already have a professional account"),
          ),
        );
        //setState(() {});
      }
      emailController.text = data["email"];

      return data;
    } else {
      debugPrint(response.body);
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
        //setState(() {});
      }

      return data;
    } else {
      debugPrint(response.body);
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
            setState(() {});
          },
          child: Container(
            margin: EdgeInsets.only(left: 8),
            child: Center(
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          "Create Professional Account",
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                if (openingTime == null || closingTime == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      elevation: 30,
                      behavior: SnackBarBehavior.floating,
                      content:
                          Text("Please select opening hours and closing time"),
                    ),
                  );
                } else if (selectedOpeningDayList.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      elevation: 30,
                      behavior: SnackBarBehavior.floating,
                      content: Text("Please select days you available"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                } else {
                  createUserBusinessAccount(
                    businessName.text,
                    businessDescription.text,
                    openingTime,
                    closingTime,
                    emailController.text,
                    phoneController.text,
                    businessSubCatorgyController.text,
                    addressController.text,
                    houseNoController.text,
                    postalController.text,
                    cityController.text,
                    countyController.text,
                    countryController.text,
                  );
                }
              }
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
                        "Create",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          openFilterDialog();
        },
        label: const Text('Select active days'),
        icon: const Icon(FontAwesomeIcons.calendarDay),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
        future: confirmProfessionalStatus(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            final profile = snapshot.data!;

            return Stack(
              children: [
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            controller: businessName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some business name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Business name*',
                                hintText: "enter your business name"),
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
                              description = value;
                            },
                            maxLines: 5,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Opening Time',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  openingTime == null
                                      ? Icon(
                                          Icons.browse_gallery,
                                          size: 15,
                                        )
                                      : Text("${openingTime}")
                                ],
                              ),
                              TextButton(
                                child: const Text('Select*'),
                                onPressed: () async {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoActionSheet(
                                          actions: [buildOpeningTime()],
                                          cancelButton:
                                              CupertinoActionSheetAction(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Done")));
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Closing Time',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  closingTime == null
                                      ? Icon(
                                          Icons.browse_gallery,
                                          size: 15,
                                        )
                                      : Text("${closingTime}")
                                ],
                              ),
                              TextButton(
                                child: const Text('Select'),
                                onPressed: () async {
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoActionSheet(
                                            actions: [buildClosingTime()],
                                            cancelButton:
                                                CupertinoActionSheetAction(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Done")));
                                      });
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            controller: emailController,
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value!);
                                if (!emailValid) {
                                  return 'Please enter your email';
                                }
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email*',
                              hintText: 'Please enter a official email...',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
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
                            controller: businessSubCatorgyController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select an option';
                              }
                              return null;
                            },
                            readOnly: true,
                            onTap: () {
                              showSearch(
                                  context: context,
                                  delegate: MySearchDelegate());
                            },
                            decoration: InputDecoration(
                              labelText: 'Profession*',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            controller: addressController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid address';
                              }
                              return null;
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Address',
                              border: UnderlineInputBorder(),
                            ),
                            onTap: () {
                              final locationPoint = Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PlacePicker(
                                      apiKey:
                                          "AIzaSyCNpV4UY0noGgT86B134PfGziQODVF1MtE",
                                      initialPosition: userLocation,
                                      useCurrentLocation: true,
                                      region: 'uk',
                                      selectInitialPosition: true,
                                      enableMyLocationButton: true,
                                      enableMapTypeButton: true,
                                      usePlaceDetailSearch: true,
                                      onPlacePicked: (result) {
                                        addressController.text =
                                            result.formattedAddress!;
                                        businessLatitude = result
                                            .geometry!.location.lat
                                            .toString();
                                        businessLongtitude = result
                                            .geometry!.location.lng
                                            .toString();

                                        for (var i
                                            in result.addressComponents!) {
                                          print("${i.types.toString()}: " +
                                              i.longName);
                                          if (i.types.first ==
                                              "street_number") {
                                            print(
                                                "her postal code ${i.longName}");
                                            houseNoController.text = i.longName;
                                          }

                                          if (i.types.first == "postal_code") {
                                            print(
                                                "her postal code ${i.longName}");
                                            postalController.text = i.longName;
                                          }

                                          if (i.types.first ==
                                              "administrative_area_level_2") {
                                            print("here is the  ${i.longName}");
                                            countyController.text = i.longName;
                                          }
                                          if (i.types.first == "postal_town" ||
                                              i.types.first == "locality") {
                                            print(
                                                "here is the town ${i.longName}");
                                            cityController.text = i.longName;
                                          }
                                          if (i.types.first == "country") {
                                            print(" country ${i.longName}");
                                            countryController.text = i.longName;
                                          }
                                        }
                                        Navigator.of(context).pop();

                                        setState(() {});
                                      },
                                    );
                                  },
                                ),
                              );
                              //print("here is the lat and lng${locationPoint}");
                            },
                          ),
                        ),
                        houseNoController.text == ""
                            ? Container(child: null)
                            : Container(
                                padding: EdgeInsets.all(8),
                                child: TextFormField(
                                  controller: houseNoController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Street/House No',
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                              ),
                        postalController.text == ""
                            ? Container(child: null)
                            : Container(
                                padding: EdgeInsets.all(8),
                                child: TextFormField(
                                  controller: postalController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Postal Code',
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                              ),
                        cityController.text == ""
                            ? Container(child: null)
                            : Container(
                                padding: EdgeInsets.all(8),
                                child: TextFormField(
                                  controller: cityController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'City/Town',
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                              ),
                        countyController.text == ""
                            ? Container(child: null)
                            : Container(
                                padding: EdgeInsets.all(8),
                                child: TextFormField(
                                  controller: countyController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'County',
                                    // border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                        countryController.text == ""
                            ? Container(child: null)
                            : Container(
                                padding: EdgeInsets.all(8),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: countryController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Country',
                                    // border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),

      /* ,*/
    );
  }

  NextPage() {
    /* return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return UploadBusinessImages();
      }),
    );*/

    return showMaterialModalBottomSheet(
      context: context,
      builder: (context) => UploadBusinessImages(),
    );
  }

  createUserBusinessAccount(
    businessName,
    businessDescription,
    openingTime,
    closingTime,
    email,
    phone,
    businessSubCatorgy,
    address,
    houseNo,
    postalCode,
    city,
    county,
    country,
  ) async {
    try {
      final _data = {
        "business_name": businessName,
        "business_descripition": businessDescription,
        "opening_time": postOpeningTime,
        "closing_time": postClosingTime,
        "email": email,
        "phone": phone,
        "business_sub_category": businessSubCatorgy,
        "full_address": address,
        "house_no": houseNo,
        "postal_code": postalCode,
        "city_or_town": city,
        "county_locality": county,
        "country_nation": country,
        "latitude": businessLatitude,
        "longtitude": businessLongtitude,
        "active_days": newselectedOpeningDayList,
      };

      //print(_data);
      final prefs = await SharedPreferences.getInstance();
      final response = await http.post(
        Uri.parse("${Network.baseURL}/api/business/create"),
        body: jsonEncode(_data),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString("token")}'
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        print(result);
        final prefs = await SharedPreferences.getInstance();
        prefs.setInt("business_id", result["business_user_id"]);
        prefs.setInt("has_professional_acc", result["has_professional_acc"]);
        Navigator.pop(context);
        NextPage();
      } else {
        final returnedError = json.decode(response.body);

        debugPrint("returned : ${returnedError["message"]}");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 1),
            backgroundColor: Colors.red,
            elevation: 30,
            behavior: SnackBarBehavior.floating,
            content: Text("${returnedError.values.first}"),
          ),
        );
      }
    } catch (error) {
      print("trying to create error${error}");
    }
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

  showAddressMap(BuildContext context) async {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) => Container());
  }

  buildOpeningTime() {
    return SizedBox(
      height: 200,
      child: CupertinoDatePicker(
          initialDateTime: _dateTime,
          use24hFormat: true,
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (dateTime) {
            setState(() {
              _dateTime = dateTime;
              final value = intl.DateFormat('HH:mm').format(_dateTime);
              print(value);
              postOpeningTime = value;
              if (_dateTime.hour > 12) {
                openingTime = value + " pm";
              } else {
                openingTime = value + " am";
              }
            });
          }),
    );
  }

  buildClosingTime() {
    return SizedBox(
      height: 200,
      child: CupertinoDatePicker(
        initialDateTime: _dateTime,
        use24hFormat: true,
        mode: CupertinoDatePickerMode.time,
        onDateTimeChanged: (dateTime) {
          setState(() {
            _dateTime = dateTime;
            final value = intl.DateFormat('HH:mm').format(_dateTime);
            postClosingTime = value;
            if (_dateTime.hour > 12) {
              closingTime = value + " pm";
            } else {
              closingTime = value + " am";
            }
          });
        },
      ),
    );
  }
}

uploadProfessionalAccImages() {}

class _FormDatePicker extends StatefulWidget {
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  const _FormDatePicker({
    required this.date,
    required this.onChanged,
  });

  @override
  State<_FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Opening Time',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              intl.DateFormat.yMd().format(widget.date),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        TextButton(
          child: const Text(
            'Edit',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () async {
            var newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            // Don't change the date if the date picker returns null.
            if (newDate == null) {
              return;
            }

            widget.onChanged(newDate);
          },
        )
      ],
    );
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
