import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasechat/widgets/buttonwidget.dart';
import 'package:firebasechat/widgets/inputwidget.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              InputWidget(
                keyBoard: TextInputType.emailAddress,
                placeHolder: "Enter your email",
                onChange: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              InputWidget(
                obscurPassword: true,
                placeHolder: "Enter your password",
                onChange: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              Buttonwidget(
                  text: "Login",
                  color: Colors.lightBlueAccent,
                  onpress: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    {
                      try {
                        final user = await auth.signInWithEmailAndPassword(
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
      ),
    );
  }
}
