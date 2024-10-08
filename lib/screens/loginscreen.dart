import 'package:firebasechat/widgets/buttonwidget.dart';
import 'package:firebasechat/widgets/inputwidget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            InputWidget(
              placeHolder: "Enter your email",
              onChange: (value) {},
            ),
            SizedBox(
              height: 8.0,
            ),
            InputWidget(
              placeHolder: "Enter your password",
              onChange: (value) {},
            ),
            SizedBox(
              height: 24.0,
            ),
            Buttonwidget(
                text: "Login",
                color: Colors.lightBlueAccent,
                onpress: () {
                  {
                    //Go to login screen.
                  }
                }),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text(
                "Go to welcome",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
