import 'package:chat_cuteegif/registerPage.dart';
import 'package:flutter/material.dart';
import 'welcomePage.dart';
import 'package:chat_cuteegif/signInPage.dart';
import 'registerPage.dart';
import 'functionPage.dart';
import 'chat.dart';
import 'cat.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async{
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  catch(e){
    print('ECEPTIONS: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: WelcomePage.route_name,
      routes: {
        WelcomePage.route_name : (context){return WelcomePage();},
        SignIn.route_name: (context){return SignIn();},
        RegisterPage.route_name : (context) => RegisterPage(),
        FunctionPage.route_name : (context) => FunctionPage(),
        ChatRoom.route_name:(context) => ChatRoom(),
        CatPage.route_name: (context) => CatPage(),
      },
    );
  }
}

