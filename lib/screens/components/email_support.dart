// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace, unused_import, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/components/upload_business_images.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:filter_list/filter_list.dart';

class SupportEmail extends StatefulWidget {
  const SupportEmail({Key? key}) : super(key: key);

  @override
  _SupportEmailState createState() => _SupportEmailState();
}

class _SupportEmailState extends State<SupportEmail> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailSubjectController = TextEditingController();
  TextEditingController emailDetailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            "Email Support",
            style: TextStyle(color: Colors.black, fontSize: 15),
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
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          "Send",
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
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: emailSubjectController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter subject';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Subject*',
                      // hintText: "enter your business name",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: emailDetailsController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      // filled: true,
                      hintText: 'Body...',
                      labelText: 'Body*',
                    ),
                    onChanged: (value) {
                      //  description = value;
                    },
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
