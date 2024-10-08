import 'package:firebasechat/widgets/buttonwidget.dart';
import 'package:firebasechat/widgets/inputwidget.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            InputWidget(placeHolder: "Enter your email", onChange: (value) {}),
            SizedBox(
              height: 8.0,
            ),
            InputWidget(
                placeHolder: "Enter your password", onChange: (value) {}),
            SizedBox(
              height: 24.0,
            ),
            Buttonwidget(
                text: "Register",
                color: Colors.lightBlueAccent,
                onpress: () {
                  {
                    //Go to login screen.
                    Navigator.pushNamed(context, "/login");
                  }
                }),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text(
                "Welcome",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
