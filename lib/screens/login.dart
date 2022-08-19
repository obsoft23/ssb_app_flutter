// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/network/api.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/screens/signup.dart';
import 'package:flutter_application_1/screens/forgot_password.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future _loginAccount(email, password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email);

        final response = await Network().loginUser(email, password);
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          Network().setToken(data["token"]);
          Network().setUserId(data["user"]["id"]);
          Network().setEmail(data["user"]["email"]);
          Network().setProfessionalStatus(data["user"]["has_professional_acc"]);
          if (data["user"]["business_id"] != null) {
            Network().setBusinessId(data["user"]["business_id"]);
          }

          setState(() {});
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                userId: data["user"]["id"],
              ),
            ),
          );
          isLoading = false;
        } else {
          setState(() {});
          isLoading = false;
          var returnedError = json.decode(response.body);
          //debugPrint("returned : ${returnedError["message"]}");

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              elevation: 30,
              behavior: SnackBarBehavior.floating,
              content: Text("${returnedError.values.first}"),
            ),
          );
        }
      } else {
        setState(() {});
        isLoading = false;
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please fill provide email and passowrd"),
          ),
        );
      }
    } catch (error) {
      debugPrint("Exception loggin ${error}");
    }
  }

  Future saveDetails() async {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Image.asset('assets/images/logo.png'),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(emailController.text);

                      if (!emailValid) {
                        return 'Please provide valid email';
                      }
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      isLoading = false;
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage()),
                  );
                },
                child: const Text(
                  'Forgot Password',
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    if (_formKey.currentState!.validate()) {
                      _loginAccount(
                        emailController.text,
                        passwordController.text,
                      );
                    }
                  },
                  child: (isLoading)
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1.5,
                          ),
                        )
                      : const Text('Log In'),
                ),
              ),
              Row(
                children: <Widget>[
                  const Text('Do not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      //signup screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              /* Row(
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
                  Text('OR'),
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
                    onTap: () {
                      debugPrint('googleicon');
                    },
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
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
