// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace, camel_case_types, unused_import, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, non_constant_identifier_names, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_final_fields, unnecessary_null_comparison, unused_field, must_be_immutable, avoid_unnecessary_containers, unused_element

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/components/manage_business_account.dart';
import 'package:flutter_application_1/screens/components/reviews.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter_application_1/network/api.dart';
import 'package:favorite_button/favorite_button.dart';

class ViewBusinessAccpage extends StatefulWidget {
  final String? businessName;
  final int? id;

  const ViewBusinessAccpage(
      {Key? key, required this.businessName, required this.id})
      : super(key: key);

  @override
  State<ViewBusinessAccpage> createState() => _ViewBusinessAccpageState();
}

class _ViewBusinessAccpageState extends State<ViewBusinessAccpage> {
  late bool pageLiked = seeLikeStatus();
  late Stream profileStream;
  late var isFav = false;

  bool bookmark = false;
  var profile;
  final Uri tel = Uri(
    scheme: 'tel',
    path: '0118 999 881 999 119 7253',
    queryParameters: <String, String>{
      'body': Uri.encodeComponent('Example Subject & Symbols are allowed!'),
    },
  );

  DateTime _dateTime = DateTime.now();

  bool isLoading = false;
  bool is_Favorite = true;

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

  String? emailController;

  String? businessDescription;

  @override
  void initState() {
    profileStream = fetchBusinessProfile();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // load();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation),
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
                  setState(() {
                    profileStream = fetchBusinessProfile();
                  });
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
                "${widget.businessName}",
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
        body: StreamBuilder(
          stream: profileStream,
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

  Stream fetchBusinessProfile() async* {
    print("fetch business id${widget.id}");

    final response = await http.get(
      Uri.parse(
          "http://localhost:8000/api/business-profile/fetch/${widget.id}"),
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
      pageLiked = await Network().confirmIfUserLiked(profile.businessId);
      seeFavStatus();
      // isFav = await Network().confirmIfFav(profile.businessId);

      yield data;
    } else {
      throw response.body.toString();
    }
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    final bool success = await Network().likes(isLiked, profile.businessId);
    setState(() {});
    profileStream = fetchBusinessProfile();

    return success ? !isLiked : isLiked;
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
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 0, left: 20),
            padding: EdgeInsets.only(
              right: 8,
              bottom: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LikeButton(
                    size: 40,
                    circleColor: CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (isLiked) {
                      print("users db says ${isLiked = pageLiked}");

                      return Icon(
                        FontAwesomeIcons.solidHeart,
                        color: isLiked ? Colors.red : Colors.grey,
                        size: 30,
                      );
                    },
                    likeCount: profile.likes,
                    onTap: onLikeButtonTapped),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReviewPage(id: profile.businessId),
                      ),
                    );
                  },
                  icon: Icon(FontAwesomeIcons.comment),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share),
                ),
                Spacer(),
                IconButton(
                  onPressed: () async {
                    isFav ? isFav = false : isFav = true;
                    await Network().confirmIfFav(profile.businessId);
                    //   Network().confirmIfFav(profile.businessId);
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.bookmark,
                    size: 30,
                    color: isFav ? Colors.yellow : Colors.black,
                  ),
                ),
              ],
            ),
          ),

          profile.emailController != null
              ? ListTile(
                  leading: Icon(CupertinoIcons.envelope_badge),
                  title: Text(
                    '${profile.emailController}',
                    style: TextStyle(fontSize: 17, color: Colors.black87),
                  ),
                  onTap: () {
                    String? encodeQueryParameters(Map<String, String> params) {
                      return params.entries
                          .map((MapEntry<String, String> e) =>
                              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                          .join('&');
                    }

                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'holarmidhey@gmail.com',
                      query: encodeQueryParameters(<String, String>{
                        'subject': 'Example Subject & Symbols are allowed!',
                      }),
                    );

                    launchUrl(emailLaunchUri);
                  },
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    print('hi');

                    String? telephoneNumber = profile.phoneController;
                    final _url1 = "tel:$telephoneNumber";
                    final Uri _url = Uri.parse(_url1);

                    if (await canLaunchUrl(_url)) {
                      print("launch cal");
                      launchUrl(_url);
                    }
                  },
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

  Widget commentModal(context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
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
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                children: const <Widget>[
                  ListTile(
                    leading: FlutterLogo(size: 72.0),
                    title: Text(
                      'Three-line ListTile,',
                      style: TextStyle(fontSize: 12),
                    ),
                    subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.',
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: Icon(CupertinoIcons.heart),
                    isThreeLine: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.face_outlined), Text("Message...")],
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
              ),
            ),
          ],
        ),
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
                //  controller: _sendmessagecontroller,
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

  seeLikeStatus() async {
    await Network().confirmIfUserLiked(profile.businessId);
  }

  seeFavStatus() async {
    isFav = await Network().confirmIfFav(profile.businessId);
  }
}
