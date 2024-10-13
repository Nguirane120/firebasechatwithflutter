import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebasechat/widgets/buttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  bool isConnected = false;
  StreamSubscription? internetSuscription;

  @override
  void initState() {
    super.initState();
    internetSuscription = InternetConnection().onStatusChange.listen((event) {
      print(event);
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            isConnected = true;
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            isConnected = false;
          });
          break;
        default:
          setState(() {
            isConnected = false;
          });
      }
    });
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    animation = ColorTween(begin: Colors.blueAccent, end: Colors.white)
        .animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    internetSuscription?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isConnected ? Colors.lightBlueAccent : Colors.red,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                AnimatedTextKit(repeatForever: true, animatedTexts: [
                  TypewriterAnimatedText(
                    speed: Duration(seconds: 2),
                    'Flash Chat',
                    textStyle: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  )
                ]),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Buttonwidget(
                text: "Login",
                color: isConnected ? Colors.lightBlueAccent : Colors.red,
                onpress: () {
                  {
                    //Go to login screen.
                    Navigator.pushNamed(context, "/login");
                  }
                }),
            Buttonwidget(
                text: "Register",
                color: Colors.blueGrey,
                onpress: () {
                  Navigator.pushNamed(context, '/register');
                })
          ],
        ),
      ),
    );
  }
}
