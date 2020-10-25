import 'package:chat_cuteegif/registerPage.dart';
import 'package:flutter/material.dart';
import 'defines.dart';
import 'signInPage.dart';
import 'registerPage.dart';

class WelcomePage extends StatelessWidget {
  static String route_name = 'welcomePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('logo/logo.png'),
              height: 300,
              width: 300,
            ),
            SizedBox(height: 20,),
            CommonButton(
              functionButton: () {
                Navigator.pushNamed(context, SignIn.route_name);
              },
              title: 'Sign in',
            ),
            SizedBox(
              height: 10,
            ),
            CommonButton(
              functionButton: () {
                Navigator.pushNamed(context, RegisterPage.route_name);
              },
              title: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
