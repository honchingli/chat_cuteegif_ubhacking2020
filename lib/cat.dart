import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'chat.dart';
import 'defines.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//CATS!!!!!!!!
//https://api.thecatapi.com/v1/images/search?api_key=294cc84a-c8ed-435e-b124-6a0a415f043c
//https://cdn2.thecatapi.com/images/qnu1lGTyh.jpg
//https://cdn2.thecatapi.com/images/e9c.jpg
// "https://cdn2.thecatapi.com/images/4h1.gif"
//https://cdn2.thecatapi.com/images/6mt.jpg
class CatPage extends StatefulWidget {
  static String route_name = 'catRoute';
  @override
  _CatPageState createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> {
  String url = 'https://cdn2.thecatapi.com/images/e9c.jpg';
  var decode_json;

  void getURL() async {
    http.Response response = await http.get(
        'https://api.thecatapi.com/v1/images/search?api_key=294cc84a-c8ed-435e-b124-6a0a415f043c');
    decode_json = jsonDecode(response.body);
    url = decode_json[0]['url'];
    print(url);
  }

  @override
  void initState() {
    super.initState();
    getURL();
  }

  @override
  Widget build(BuildContext context) {
    String press = 'Press to get adorables!';
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: NetworkImage(url), height: 500, width:400),
              RaisedButton(
                elevation: 15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.all(15),
                color: Colors.lightBlueAccent[400],
                onPressed: () async {
                  await getURL();
                  setState(() {
                    press = 'Press again to get more!!';
                    url;
                  });
                },
                child: Text(
                  press,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              CommonButton(
                title: 'Send to CHAT!!',
                functionButton: () async {
                      await firestore.collection('chatroom').add(
                        {
                          'user': current_user.email,
                          'message': decode_json,
                          'timestamp': FieldValue.serverTimestamp(),
                        },
                      );
                      //print('Current user: $current_user, Message: $user_message');
                  Navigator.pushNamed(context, ChatRoom.route_name);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
