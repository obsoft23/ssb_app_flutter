// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, avoid_print, unused_local_variable, prefer_typing_uninitialized_variables, unused_element, unnecessary_brace_in_string_interps, sized_box_for_whitespace

import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/components/old/profile2.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_application_1/network/api.dart';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/screens/profile.dart';

class EditProfilePage extends StatefulWidget {
  final Profile? user;
  const EditProfilePage({Key? key, this.user}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

var data;
var id;
late Stream mainProfileStream;

class _EditProfilePageState extends State<EditProfilePage> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  bool isLoading = false;
  var token;
  var id;
  var image;
  var imageTemp;
  String? base64image;
  var profilePicture;

  @override
  void initState() {
    super.initState();
    mainProfileStream = _fetchUser();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.dispose();
    mainProfileStream = _fetchUser();
  }

  void _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token') ?? 0);
    token = prefs.getString('token');
  }

  Stream _fetchUser() async* {
    try {
      final prefs = await SharedPreferences.getInstance();
      var response = await http
          .get(Uri.parse("http://localhost:8000/api/profile/fetch"), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}'
      });
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);

        nameController.text = data["name"];
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
              "http://localhost:8000/api/fetch-user-image/${data["image"]}");
        }
        /*  image = NetworkImage(
          "http://localhost:8000/api/public/profilepictures/${data["image"]}");*/
        yield data;
      } else {
        throw Exception("failed to load data");
      }
    } catch (error) {
      print("error${error}");
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
          stream: mainProfileStream,
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

  SingleChildScrollView editProfileMainPage(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
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
            "http://localhost:8000/api/profile/image/${_id}",
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
      setState(() {});
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
        Uri.parse("http://localhost:8000/api/profile/update/${id}"),
        body: jsonEncode(_data),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString("token")}'
        });

    final update = jsonDecode(response.body);
    debugPrint("update data recived${update}");
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
