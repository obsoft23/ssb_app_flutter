// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, unused_field, sized_box_for_whitespace, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart' as intl;
import 'package:http/http.dart' as http;

class UploadBusinessImages extends StatefulWidget {
  const UploadBusinessImages({Key? key}) : super(key: key);

  @override
  _UploadBusinessImagesState createState() => _UploadBusinessImagesState();
}

class _UploadBusinessImagesState extends State<UploadBusinessImages> {
  var imageTemp;
  var singleImage;
  var secondImage;
  var thirdImage;
  var fourthImage;

  final singlePicker = ImagePicker();
  final mutiplePicker = ImagePicker();
  List images = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchPhotos() async {
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
        return data;
      } catch (error) {
        print(error);
      }
    } else {
      return print(response.body);
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
            setState(() {
             
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
      body: FutureBuilder(
        future: fetchPhotos(),
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

  Widget buildManagePhotos(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(4.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //image 1
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        "click above to add or remove Photos 1",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
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
                            height: MediaQuery.of(context).size.height * .30,
                            child: singleImage!),
                  ),

                  Divider(),

                  //adding image 2
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        "click above to add or remove Photos 2",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
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
                            height: MediaQuery.of(context).size.height * .30,
                            child: secondImage),
                  ),

                  Divider(),

                  //adding image 3
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        "click above to add or remove Photos 3",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
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
                            height: MediaQuery.of(context).size.height * .30,
                            child: thirdImage),
                  ),

                  Divider(),

                  //adding image 4
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        "click above to add or remove Photos 4",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
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
                            height: MediaQuery.of(context).size.height * .30,
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
            setState(() {});
            uploadBusinessPhotos(cropped, index);
            break;
          case 2:
            secondImage = Image.file(
              imageTemp!,
              fit: BoxFit.cover,
            );
            setState(() {});
            uploadBusinessPhotos(cropped, index);
            break;
          case 3:
            thirdImage = Image.file(
              imageTemp!,
              fit: BoxFit.cover,
            );
            setState(() {});
            uploadBusinessPhotos(cropped, index);
            break;
          case 4:
            fourthImage = Image.file(
              imageTemp!,
              fit: BoxFit.cover,
            );
            setState(() {});
            uploadBusinessPhotos(cropped, index);
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
          .then(
            (response) => print("image successfully uploaded${response}"),
          );

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
