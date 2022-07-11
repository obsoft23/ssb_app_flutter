// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, unused_field, sized_box_for_whitespace, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/components/manage_business_account.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application_1/network/api.dart';
import 'package:flutter_application_1/screens/business_profile_slider.dart';
import 'package:flutter_application_1/screens/components/old/edit_profile.dart';

import 'package:flutter_application_1/screens/components/change_password.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/screens/login.dart';

//import 'package:video_player/video_player.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

var userDetails;

class Profile {
  final int? id;
  final String? name;
  final String? email;
  final String? fullname;
  final String? bio;
  final String? image;
  final String? phone;
  final String? token;
  final dynamic hasProfessionalAcc;
  Profile({
    this.id,
    this.name,
    this.email,
    this.fullname,
    this.bio,
    this.image,
    this.phone,
    this.token,
    this.hasProfessionalAcc,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      fullname: json["fullname"],
      bio: json["bio"],
      image: json["image"],
      phone: json["phone"],
      token: json["token"],
      hasProfessionalAcc: json["has_professional_acc"],
    );
  }
}

class _ProfilePageState extends State<ProfilePage> {
  var token;
  var createStatus = 1;

  var listImage = [
    "https://i.pinimg.com/originals/aa/eb/7f/aaeb7f3e5120d0a68f1b814a1af69539.png",
    "https://cdn.fnmnl.tv/wp-content/uploads/2020/09/04145716/Stussy-FA20-Lookbook-D1-Mens-12.jpg",
    "https://www.propermag.com/wp-content/uploads/2020/03/0x0-19.9.20_18908-683x1024.jpg",
    "http://www.thefashionisto.com/wp-content/uploads/2014/06/Marc-by-Marc-Jacobs-Men-2015-Spring-Summer-Collection-Look-Book-001.jpg",
    "https://im0-tub-ru.yandex.net/i?id=e2e0f873e86f34e5001ddc59b42e23a6-l&ref=rim&n=13&w=828&h=828",
    "https://www.thefashionisto.com/wp-content/uploads/2013/07/w012-800x1200.jpg",
    "https://manofmany.com/wp-content/uploads/2016/09/14374499_338627393149784_1311139926468722688_n.jpg",
    "https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2020%2F04%2Faries-fall-winter-2020-lookbook-first-look-14.jpg?q=75&w=800&cbr=1&fit=max",
    "https://i.pinimg.com/originals/95/0f/4d/950f4df946e0a373e47df37fb07ea1f9.jpg",
    "https://i.pinimg.com/736x/c4/03/c6/c403c63b8e1882b6f10c82f601180e2d.jpg",
  ];

  TabController? tabController;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    final response = await Network().fetchUser(token);
    if (response.statusCode == 200) {
      print(response.body);

      userDetails = Profile.fromJson(jsonDecode(response.body));
      // print(userDetails.image);
      return userDetails;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          elevation: 30,
          behavior: SnackBarBehavior.floating,
          content: Text("Error Loading Page"),
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    bool? isProfessional;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        /*   appBar: AppBar(
        leading: null,
        elevation: 1,
        backgroundColor: Theme.of(context).canvasColor,
        actions: [],
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),*/
        body: FutureBuilder(
          future: _fetchUser(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('An error has occurred!'),
              );
            } else if (snapshot.hasData) {
              final profile = snapshot.data!;

              return Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Jenny Wilson",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_horiz,
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://free2music.com/images/singer/2019/02/10/troye-sivan_2.jpg"),
                    radius: 70.0,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "@Wilson_je",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 20.0),
                      Column(
                        children: [
                          Text(
                            "29",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            "Following",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w100),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "121.9k",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            "Followers",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "7.5M",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            "Like",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      SizedBox(width: 20.0),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Follow",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(290.0, 55.0),
                            primary: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.0),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TabBar(
                          isScrollable: true,
                          controller: tabController,
                          indicator:
                              BoxDecoration(borderRadius: BorderRadius.zero),
                          labelColor: Colors.black,
                          labelStyle: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                          unselectedLabelColor: Colors.black26,
                          onTap: (tapIndex) {
                            setState(() {
                              selectedIndex = tapIndex;
                            });
                          },
                          tabs: [
                            Tab(text: "Photos"),
                            Tab(text: "Video"),
                            Tab(text: "Tagged"),
                          ],
                        ),
                        SizedBox(width: 50.0),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_vert),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 250.0, crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                    image: NetworkImage(listImage[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 37.0,
                                      right: 37.0,
                                      top: 185.0,
                                      bottom: 15.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Text("1.234k"),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: 10,
                        ),
                        Center(
                          child: Text("You don't have any videos"),
                        ),
                        Center(
                          child: Text("You don't have any tagged"),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
        ),
      ),
    );
  }

  buildSocialIcons(IconData icon) => CircleAvatar(
        radius: 18,
        //   backgroundColor: Theme.of(context).canvasColor,
        child: Center(
          child: Icon(
            icon,
            size: 32,
          ),
        ),
      );

  buildCoverImage() => Container(
        child: Image.network(
          "https://images.unsplash.com/photo-1641025389903-6d06a65a9c0a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
          width: double.infinity,
          height: 280,
          fit: BoxFit.cover,
        ),
      );

  Container bottomSheetList() {
    return Container(
      height: 200,
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
            leading: Icon(Icons.person),
            title: Text('Edit Profile'),
            onTap: () {
              Navigator.pop(context);
              showBarModalBottomSheet(
                context: context,
                builder: (context) =>
                    Expanded(child: EditProfilePage(user: userDetails)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Change password'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChangePassword()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              // logoutDialog();
            },
          ),
        ],
      ),
    );
  }

  Future logoutDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: const Text('Logout.')),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you confirming logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Logout'),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                // Remove data for the 'counter' key.
                await prefs.remove('token');
                await prefs.remove('id');
                await prefs.remove('email');
                await prefs.remove('has_professional_acc');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
