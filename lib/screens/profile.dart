// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, unused_field, sized_box_for_whitespace, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/loading.dart';
import 'dart:typed_data';
import 'package:flutter_application_1/screens/components/manage_business_account.dart';
import 'package:flutter_application_1/screens/components/old/profile2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application_1/network/api.dart';
import 'package:flutter_application_1/screens/business_profile_slider.dart';
import 'package:flutter_application_1/screens/components/old/edit_profile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/screens/components/change_password.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

//import 'package:video_player/video_player.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

var userDetails;

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;
  var token;
  var id;
  var image;
  var imageTemp;
  String? base64image;
  var profilePicture;
  int createStatus = 0;

  TabController? tabController;
  int selectedIndex = 0;

  final _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  @override
  void initState() {
    super.initState();
    mainProfileStream = _fetchUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Stream _fetchUser() async* {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    final response = await Network().fetchUser(token);
    if (response.statusCode == 200) {
      print(response.body);
      data = jsonDecode(response.body);

      nameController.text = data["name"];
      localStorage.setString("user_acc_name", data["name"]);
      emailController.text = data["email"];
      if (data["fullname"] != null) {
        fullNameController.text = data["fullname"];
      }
      if (data["phone"] != null) {
        phoneController.text = data["phone"];
      }
      if (data["bio"] != null) {
        bioController.text = data["bio"];
      }

      id = data["id"];
      // print(""${data})
      if (data["image"] != null) {
        image = NetworkImage(
            "${Network.baseURL}/api/fetch-user-image/${data["image"]}");

        localStorage.setString("profile_image_url", data["image"]);
      }
      /*  image = NetworkImage(
          "${Network.baseURL}/api/public/profilepictures/${data["image"]}");*/
      yield data;

      userDetails = Profile.fromJson(jsonDecode(response.body));
      // print(userDetails.image);
      yield userDetails;
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
        body: StreamBuilder(
          stream: mainProfileStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error"),
              );
            } else if (snapshot.hasData) {
              return buildProfilePage(context);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("connecting."));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Column buildProfilePage(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${userDetails.name}",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      context: context,
                      builder: (context) => bottomSheetList());
                },
                icon: Icon(
                  Icons.more_horiz,
                  size: 24.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        userDetails.image == null
            ? CircleAvatar(
                radius: 70,
                child: Icon(Icons.person, size: 70),
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey,
              )
            : CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                  "${Network.baseURL}/api/fetch-user-image/${userDetails.image}",
                ),
              ),
        SizedBox(height: 10.0),
        Text(
          "@${userDetails.email}",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18.0,
          ),
        ),
        userDetails.bio != null
            ? Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  " ${userDetails.bio}",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              )
            : Container(child: null),
        // SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: userDetails.hasProfessionalAcc == createStatus
                  ? Container(
                      width: 275,
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Respond to button press
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IntroScreen(),
                            ),
                          );
                        },
                        label: Text(
                          "Create Professional Account",
                          style: TextStyle(fontSize: 13),
                        ),
                        icon: Icon(Icons.add, size: 18),
                      ),
                    )
                  : Container(
                      width: 275,
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Respond to button press
                          /*  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => 
                            ),
                          );*/

                          showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) => ManageBusinessAccount(),
                          );
                        },
                        label: Text(
                          "Manage Professional Account",
                          style: TextStyle(fontSize: 13),
                        ),
                        icon: Icon(Icons.add, size: 18),
                      ),
                    ),
            ),
          ],
        ),
        SizedBox(height: 15),
        /*  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TabBar(
              isScrollable: true,
              controller: tabController,
              indicator: BoxDecoration(borderRadius: BorderRadius.zero),
              labelColor: Colors.black,
              labelStyle:
                  TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.black26,
              onTap: (tapIndex) {
                setState(() {
                  selectedIndex = tapIndex;
                });
              },
              tabs: [
                Tab(text: "Posted Reviews"),
                Tab(text: "Vendors"),
              ],
            ),
          ],
        ),*/
        SizedBox(height: 10),
        /* Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: FlutterLogo(size: 72.0),
                      title: Text('Three-line ListTile'),
                      subtitle: Text(
                          'A sufficiently long subtitle warrants three lines.'),
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
                    SizedBox(height: 50)
                  ],
                ),
              ),
              Center(
                child: Text("You don't havent interacted with any vendors"),
              ),
            ],
          ),
        )*/
      ],
    );
  }

  editPage() {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              mainProfileStream = _fetchUser();
            },
            child: Container(
              margin: EdgeInsets.only(left: 8),
              child: Center(
                child: Icon(Icons.arrow_back, color: Colors.blue, size: 22),
              ),
            ),
          ),
          title: Text("Manage Profile",
              style: TextStyle(color: Colors.black, fontSize: 15)),
          actions: [
            GestureDetector(
              onTap: () {
                updateProfile(
                  fullNameController.text,
                  nameController.text,
                  emailController.text,
                  phoneController.text,
                  bioController.text,
                );
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
        ),
        body: StreamBuilder(
          stream: _fetchUser(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('An error has occurred!'),
              );
            } else if (snapshot.hasData) {
              return editProfileMainPage(context);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
        ));
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
            title: Text(
              'Edit Profile',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.pop(context);
              /* showBarModalBottomSheet(
                context: context,
                builder: (context) =>
                    Expanded(child: EditProfilePage(user: userDetails)),
              );*/
              showMaterialModalBottomSheet(
                context: context,
                builder: (context) => editPage(),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              'Change password',
              style: TextStyle(fontSize: 16),
            ),
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
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 16),
            ),
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
                await prefs.remove('business_id');
                await prefs.remove('user_acc_name');
                await prefs.remove('profile_image_url');
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

  SingleChildScrollView editProfileMainPage(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: 115,
                  height: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      image == null
                          ? CircleAvatar(
                              child: Icon(Icons.person),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.grey,
                            )
                          : CircleAvatar(
                              backgroundImage: image,
                            ),
                      _pickprofileimage(),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  controller: fullNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'full name',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'email',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Phone',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextFormField(
                  controller: bioController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Bio',

                    /*  contentPadding: EdgeInsets.symmetric(
                            vertical: 40, horizontal: 10),*/
                  ),
                  maxLines: 5,
                ),
              ),
              /* isLoading
                      ? SizedBox(
                          width: 30,
                          height: 25,
                          child: Image.asset("assets/images/loader2.gif"),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            isLoading = true;
                            updateProfile(
                                fullNameController.text,
                                nameController.text,
                                emailController.text,
                                phoneController.text,
                                bioController.text);
                          },
                          child: Text("Update profile"),
                        ),*/
            ],
          ),
        ),
      ),
    );
  }

  Widget _pickprofileimage() => Positioned(
        right: -1,
        bottom: -7,
        child: SizedBox(
          height: 46,
          width: 46,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
              border: Border.all(
                width: 3,
                color: Colors.white,
              ),
            ),
            child: IconButton(
              color: Colors.white,
              iconSize: 16,
              icon: Icon(Icons.camera_alt_rounded),
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    context: context,
                    builder: (context) => sourceList());
              },
            ),
          ),
        ),
      );

  Container sourceList() {
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
            leading: Icon(Icons.camera),
            title: Text('Camera'),
            onTap: () {
              getImage();
            },
          ),
          ListTile(
            leading: Icon(Icons.image),
            title: Text('Gallery'),
            onTap: () {
              Navigator.pop(context);
              chooseImage();
            },
          ),
        ],
      ),
    );
  }

  displayInternalImage(route) async {
    var asset = route;
    if (asset != null) {
      image = Image.file(
        asset!,
        fit: BoxFit.cover,
      ).image;
    }

    return;
  }

  getImage() async {
    /*  var pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    imageTemp = File(pickedImage!.path);

    //base64image = base64Encode(imageTemp.readAsBytesSync());
    setState(() {
      displayInternalImage(imageTemp);
    });
    uploadImage(imageTemp);*/
  }

  chooseImage() async {
    try {
      final pickedImage =
          await ImagePicker().getImage(source: ImageSource.gallery);
      print(pickedImage);
      if (pickedImage != null) {
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
        } else {
          return;
        }

        setState(() {
          image = Image.file(
            imageTemp,
            fit: BoxFit.cover,
          ).image;
          uploadImage(cropped);
        });
      }
    } catch (error) {
      print("error is${error}");
    }
  }

  Future uploadImage(file) async {
    String filename = file.path.split('/').last;
    final prefs = await SharedPreferences.getInstance();
    final _id = prefs.getInt("id");

    final _token = prefs.getString("token");
    FormData _data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        file.path,
        filename: filename,
        contentType: MediaType("image", "jpg"),
      ),
      "filename": filename,
    });
    //  print(file.path);
    try {
      final request = await Dio()
          .post(
            "${Network.baseURL}/api/profile/image/${_id}",
            data: _data,
            options: Options(
              headers: {'Authorization': 'Bearer ${prefs.getString("token")}'},
            ),
          )
          .then((response) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  elevation: 30,
                  behavior: SnackBarBehavior.floating,
                  content: Text("image successfully uploaded"),
                ),
              ))
          .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  elevation: 30,
                  behavior: SnackBarBehavior.floating,
                  content: Text("${error}"),
                ),
              ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          elevation: 30,
          behavior: SnackBarBehavior.floating,
          content: Text("${error}"),
        ),
      );
    }
  }

  void updateProfile(fullname, name, email, phone, bio) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    final _data;
    image == null
        ? _data = {
            "fullname": fullname,
            "name": name,
            "email": email,
            "phone": phone,
            "bio": bio,
            "id": id,
          }
        : _data = {
            "fullname": fullname,
            "name": name,
            "email": email,
            "phone": phone,
            "bio": bio,
            "id": id,
          };

    final response = await http.put(
        Uri.parse("${Network.baseURL}/api/profile/update/${id}"),
        body: jsonEncode(_data),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString("token")}'
        });

    final update = jsonDecode(response.body);
    debugPrint("update data recived${update}");
    isLoading = false;
    if (update["success"] == true) {
      setState(() {});
      Navigator.pop(context);
      mainProfileStream = _fetchUser();
    } else {
      final returnedError = jsonDecode(response.body);
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          elevation: 30,
          behavior: SnackBarBehavior.floating,
          content: Text("${returnedError.values.first[0]}"),
        ),
      );
    }
  }
}
