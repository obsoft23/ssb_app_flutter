// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, unused_field, sized_box_for_whitespace, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
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
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ),
          ),
        ),
        title: Text(
          "Change  Password",
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
                : GestureDetector(
                    onTap: () {
                      updatePassword(newPasswordController.text,
                          confirmPasswordController.text);
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(right: 10, top: 5),
                        child: Text(
                          "Update",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              obscureText: true,
              controller: newPasswordController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter new password',
              ),
            ),
            TextFormField(
              obscureText: true,
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Confirm new password',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            /* Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                onPressed: () async {},
                child: const Text('Change Password'),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  updatePassword(newPassword, confirmPassword) async {
    if (newPassword == confirmPassword) {
      final prefs = await SharedPreferences.getInstance();

      var _data = {"newPassword": newPassword, "id": prefs.getInt("id")};
      final response = await http.put(
          Uri.parse(
              "http://localhost:8000/api/access/update/${prefs.getInt("id")}"),
          body: jsonEncode(_data),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${prefs.getString("token")}'
          });

      final update = jsonDecode(response.body);
      debugPrint("update data recived${update}");
      if (update["success"] == true) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("Password changed successfully..."),
            duration: const Duration(seconds: 6),
          ),
        );
        setState(() {});
      } else {
        final returnedError = jsonDecode(response.body);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            elevation: 30,
            behavior: SnackBarBehavior.floating,
            content: Text("${returnedError.values.first[0]}"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          elevation: 30,
          behavior: SnackBarBehavior.floating,
          content: Text("Sorry passwords dont match..."),
        ),
      );
    }
  }

  /**/
}
