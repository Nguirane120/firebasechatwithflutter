import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasechat/widgets/buttonwidget.dart';
import 'package:firebasechat/widgets/inputwidget.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  String email = '';
  String password = '';
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
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
                onChange: (value) {
                  email = value;
                },
                keyBoard: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 8.0,
              ),
              InputWidget(
                  obscurPassword: true,
                  placeHolder: "Enter your password",
                  onChange: (value) {
                    password = value;
                  }),
              SizedBox(
                height: 24.0,
              ),
              Buttonwidget(
                  text: "Register",
                  color: Colors.lightBlueAccent,
                  onpress: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.pushNamed(context, '/chat');
                      }

                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      throw e.toString();
                    }
                  }),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Welcome",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
