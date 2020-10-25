import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'cat.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
var _controller = TextEditingController();
var user_message;

User current_user = auth.currentUser;

class ChatRoom extends StatefulWidget {
  static String route_name = 'ChatRoute';
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(current_user.email),
          Expanded(
            child: ReadMessages(),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    //contentPadding: EdgeInsets.all(2),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'enter message',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onChanged: (value) {
                    user_message = value;
                  },
                ),
              ),
              FlatButton(
                onPressed: () async {
                  _controller.clear();
                  if (user_message != null) {
                    await firestore.collection('chatroom').add(
                      {
                        'user': current_user.email,
                        'message': user_message,
                        'timestamp': FieldValue.serverTimestamp(),
                      },
                    );
                    //print('Current user: $current_user, Message: $user_message');
                  }
                },
                child: Icon(
                  Icons.send,
                  color: Colors.lightBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReadMessages extends StatelessWidget {
  List<Widget> list = [];
  CrossAxisAlignment start_end;
  Color color_message;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('chatroom')
          .orderBy('timestamp', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        list = [];
        if (snapshot.hasError) {
          return Text('Snapshot fail.');
        }
        for (var i in snapshot.data.docs) {
          //print('Stream check pulling ${i.data()['message']}');
          if (i.data()['user'] == current_user.email) {
            start_end = CrossAxisAlignment.end;
            color_message = Colors.lightBlue[300];
          } else {
            start_end = CrossAxisAlignment.start;
            color_message = Colors.grey[350];
          }
          if (i.data()['message'] is String) {
            list.add(
              Column(
                crossAxisAlignment: start_end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10, left: 10, top: 15),
                    child: Text(
                      i.data()['user'],
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20, left: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color_message,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      i.data()['message'],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            list.add(
              Column(
                crossAxisAlignment: start_end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10, left: 10, top: 15),
                    child: Text(
                      i.data()['user'],
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Image(
                    image: NetworkImage(i.data()['message'][0]['url']),
                    height: 300,
                    width: 300,
                  ),
                ],
              ),
            );
          }
        }
        //print(list);
        return ListView(
          children: list,
        );
      },
    );
  }
}
