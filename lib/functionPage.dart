import 'package:flutter/material.dart';
import 'defines.dart';
import 'chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cat.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class FunctionPage extends StatelessWidget {
  static final String route_name = 'FunctionPageRoute';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonButton(
              title: 'Chat!',
              functionButton: () {
                Navigator.pushNamed(context, ChatRoom.route_name);
              },
            ),
            CommonButton(
              title: 'CATS!!',
              functionButton: () {
                Navigator.pushNamed(context, CatPage.route_name);
              },
            ),
            CommonButton(
              title: 'Log out',
              functionButton: () async {
                await auth.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
