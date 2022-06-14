// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, unused_field, sized_box_for_whitespace, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/components/manage_business_account.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application_1/network/api.dart';
import 'package:flutter_application_1/screens/business_profile_slider.dart';
import 'package:flutter_application_1/screens/components/edit_profile.dart';

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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
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
        ),
        body: FutureBuilder(
          future: _fetchUser(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('An error has occurred!'),
              );
            } else if (snapshot.hasData) {
              final profile = snapshot.data!;

              return Container(
                color: Colors.grey[300],
                child: Column(
                  children: [
                    SizedBox(height: 24),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                leading: userDetails.image == null
                                    ? CircleAvatar(
                                        radius: 30,
                                        child: Icon(Icons.person),
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.grey,
                                      )
                                    : CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                          "http://localhost:8000/api/fetch-user-image/${userDetails.image}",
                                        ),
                                      ),
                                title: userDetails.name != null
                                    ? Text('${userDetails.name}')
                                    : Text(''),
                                subtitle: userDetails.bio == null
                                    ? Text("")
                                    : Text(
                                        "${userDetails.bio}",
                                        //overflow: TextOverflow.ellipsis,
                                      ),
                                trailing: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(20))),
                                          context: context,
                                          builder: (context) =>
                                              bottomSheetList());
                                    },
                                    icon: Icon(Icons.more_vert_rounded)),
                              ),
                              //  SizedBox(height: 10),
                              userDetails.hasProfessionalAcc == 0
                                  ? ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => IntroScreen(),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                              'Create Professional Account')),
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ManageBusinessAccount(),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                              'Manage Professional Account')),
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Expanded(
                      child: SettingsList(
                        sections: [
                          SettingsSection(
                            title: Text('Common'),
                            tiles: <SettingsTile>[
                              SettingsTile.switchTile(
                                onToggle: (value) {},
                                initialValue: true,
                                leading: Icon(Icons.format_paint),
                                title: Text('Dark Mode'),
                                onPressed: (s) {
                                  debugPrint("pres");
                                },
                              ),
                              SettingsTile.navigation(
                                leading: Icon(Icons.bar_chart),
                                title: Text('Analytics'),
                                onPressed: (id) {},
                                // value: Text('Tools'),
                              ),
                              SettingsTile.navigation(
                                leading: Icon(Icons.language),
                                title: Text('Language'),
                                value: Text('English'),
                                onPressed: (s) {
                                  debugPrint("pres");
                                },
                              ),
                            ],
                          ),
                          SettingsSection(
                            title: Text('Advanced'),
                            tiles: <SettingsTile>[
                              SettingsTile.navigation(
                                leading: Icon(Icons.report),
                                title: Text('Reports'),
                                onPressed: (s) {
                                  debugPrint("pres");
                                },
                              ),
                              SettingsTile.navigation(
                                leading: Icon(Icons.web),
                                title: Text('Link Social'),
                                onPressed: (s) {
                                  debugPrint("pres");
                                },
                              ),
                              SettingsTile.navigation(
                                leading: Icon(Icons.block),
                                title: Text('Blocked'),
                                value: Text('accounts'),
                                onPressed: (s) {
                                  debugPrint("pres");
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
              logoutDialog();
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
