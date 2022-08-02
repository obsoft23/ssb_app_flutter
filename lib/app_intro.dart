// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intro_slider/intro_slider.dart';

class AppIntroPage extends StatefulWidget {
  const AppIntroPage({Key? key}) : super(key: key);

  @override
  State<AppIntroPage> createState() => _AppIntroPageState();
}

class _AppIntroPageState extends State<AppIntroPage> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: "Welcome to SSB",
        styleTitle: TextStyle(
          color: Colors.white,
          fontSize: 22.0,
          fontWeight: FontWeight.bold, /*fontFamily: 'RobotoMono'*/
        ),
        description:
            "With a professional account, our users access to your business or vocation ",
        styleDescription: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/images/pro.png",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      Slide(
        title: "Welcome to SSB",
        styleTitle: TextStyle(
          color: Colors.white,
          fontSize: 22.0,
          fontWeight: FontWeight.bold, /*fontFamily: 'RobotoMono'*/
        ),
        description:
            "With a professional account, our users access to your business or vocation ",
        styleDescription: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/images/projections.png",
        backgroundColor: Color.fromARGB(255, 242, 245, 249),
      ),
    );
  }

  void onDonePress() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
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

/*  Widget renderSkipBtn() {
    return const Icon(
      Icons.skip_next,
      color: Color(0xffF3B4BA),
    );
  }*/

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
      slides: slides,
      onDonePress: onDonePress,
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
