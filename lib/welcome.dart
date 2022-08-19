// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_intro.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/screens/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<Widget> indicator() {
    return List<Widget>.generate(
      slides.length,
      (index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 3.0),
        height: 10.0,
        width: 10.0,
        decoration: BoxDecoration(
            color: currentPage.round() == index
                ? Colors.blue
                : Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

  double currentPage = 0.0;
  final _pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    _pageViewController.addListener(() {
      setState(() {
        currentPage = _pageViewController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageViewController,
              itemCount: slides.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Image.asset(
                          items[index]['image'],
                          fit: BoxFit.fitWidth,
                          width: 200.0,
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                items[index]['header'],
                                style: GoogleFonts.aclonica(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0XFF3F3D56),
                                  height: 2.0,
                                ),
                              ),
                              //montaga
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  items[index]['description'],
                                  style: GoogleFonts.monteCarlo(
                                    color: Colors.black,
                                    letterSpacing: 1.2,
                                    fontSize: 20.0,
                                    // height: 1.3,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 90.0),
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: indicator(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Container(
                  margin: EdgeInsets.only(top: 0),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }),
                      );
                    },
                    child: Text(
                      'Welcome',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
            ),
            // )
          ],
        ),
      ),
    );
  }

  List<Widget> slides = items
      .map(
        (item) => Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Image.asset(
                  item['image'],
                  fit: BoxFit.fitWidth,
                  width: 220.0,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        item['header'],
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w300,
                          //    color: Color.fromARGB(255, 60, 43, 243),
                          color: Colors.blue,
                          height: 2.0,
                        ),
                      ),
                      Text(
                        item['description'],
                        style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 1.2,
                            fontSize: 16.0,
                            height: 1.3),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Create account',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
      .toList();
}
