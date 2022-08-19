// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, unused_field, unnecessary_this

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/network/api.dart';
import 'package:flutter_application_1/screens/components/old/business_profilepage.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:flutter_application_1/screens/components/create_professional_account.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: "Create Professional Account",
        styleTitle: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold, /*fontFamily: 'RobotoMono'*/
        ),
        description:
            "With a professional account, our users access to your business or vocation ",
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 13.0,
          //fontStyle: FontStyle.italic,
        ),
        pathImage: "assets/images/pro.png",
        backgroundColor: Color(0xff203152),
      ),
    );

    slides.add(
      Slide(
        title: "Earn More with your skill labour",
        styleTitle: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold, /*fontFamily: 'RobotoMono'*/
        ),
        description:
            "Another writing challenge can be to take the individual sentences in the random paragraph and incorporate a single sentence from that into a new paragraph to create a short story.",
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 13.0,
        ),
        pathImage: "assets/images/vocations.png",
        backgroundColor: Color(0xff203152),
      ),
    );

    slides.add(
      Slide(
        title: "Enjoy Increase in skill Demand",
        styleTitle: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold, /*fontFamily: 'RobotoMono'*/
        ),
        description:
            "While it may not be obvious to everyone, there are a number of reasons creating random paragraphs can be useful. A few examples of how some people use this generator are listed in the following paragraphs.",
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 13.0,
        ),
        pathImage: "assets/images/teams.png",
        backgroundColor: Color(0xff203152),
      ),
    );
  }

  void onDonePress() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Professional(),
      ),
    );
  }

  Widget renderNextBtn() {
    return const Icon(
      Icons.navigate_next,
      color: Color(0xffF3B4BA),
      size: 35.0,
    );
  }

  Widget renderSkipBtn() {
    return const Icon(
      Icons.skip_next,
      color: Color(0xffF3B4BA),
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0x33F3B4BA)),
      overlayColor: MaterialStateProperty.all<Color>(const Color(0x33FFA8B0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      renderDoneBtn: renderDoneBtn(),
      renderNextBtn: renderNextBtn(),
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(0xffF3B4BA),
    );
  }
}
