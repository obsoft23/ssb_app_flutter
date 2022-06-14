// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, unnecessary_brace_in_string_interps, unnecessary_import, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constructors/signup_error.dart';
import 'package:flutter_application_1/screens/home.dart';

import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/network/api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  bool isLoading = false;
  int buttonColor = 0xff26A9FF;
  bool inputTextNotNull = false;
  String? platformType;
  _createAccount(username, email, password, confirmPassword) async {
    final List<User> user;

    if (password == confirmPassword) {
      final response =
          await Network().registerUser(username, email, password, platformType);
      if (response.statusCode == 200) {
        print(response);
        var data = jsonDecode(response.body);
        Network().setToken(data["token"]);
        Network().setUserId(data["user"]["id"]);
        Network().setEmail(data["user"]["email"]);
        if (data["user"]["business_id"] != null) {
          Network().setBusinessId(data["user"]["business_id"]);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("loggin in..."),
            duration: const Duration(seconds: 6),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(userId: data["user"]["id"])),
        );
      } else {
        try {
          final returnedError = jsonDecode(response.body);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.blue,
              elevation: 30,
              behavior: SnackBarBehavior.floating,
              content: Text("${returnedError.values.first[0]}"),
            ),
          );
        } catch (error) {
          print(error);
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Sorry Passwords Does not match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Image.asset('assets/images/instargram.png'),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  _createAccount(usernameController.text, emailController.text,
                      passwordController.text, confirmPasswordController.text);
                  setState(() {
                    isLoading = false;
                  });
                },
                child: (isLoading)
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1.5,
                        ))
                    : const Text('Create Account'),
              ),
            ),
            Row(
              children: <Widget>[
                const Text('Already have an account?'),
                TextButton(
                  child: const Text(
                    'log in',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    //signup screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 1,
                  width: deviceWidth * .35,
                  color: Color(0xffA2A2A2),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('OR '),
                Container(
                  height: 1,
                  width: deviceWidth * .35,
                  color: Color(0xffA2A2A2),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(FontAwesomeIcons.facebook, color: Colors.blue, size: 40),
                IconButton(
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.facebook),
                  iconSize: 40,
                  color: Colors.blue,
                ),
                IconButton(
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.twitter),
                  iconSize: 35,
                  color: Colors.blue[300],
                ),
                GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    width: 35,
                    height: 35,
                    child: Image.asset("assets/images/google2.png"),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.linkedinIn),
                  iconSize: 35,
                  color: Colors.blue,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
