import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'defines.dart';
import 'chat.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

String register_email;
String register_password;
String register_phone;

FirebaseAuth auth = FirebaseAuth.instance;


class RegisterPage extends StatefulWidget {
  static final String route_name = 'registerRoute';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField_input(
            hint_text: 'Enter your email',
            icon: Icons.email,
            type: Textfield_input_type.email,
              secureText: false,
          ),
          TextField_input(
            hint_text: 'Enter your password',
            icon: Icons.double_arrow_rounded,
            type: Textfield_input_type.password,
            secureText: true,
          ),
          TextField_input(
            hint_text: 'Enter your phone (optional)',
            icon: Icons.phone,
            type: Textfield_input_type.phone,
            secureText: false,
          ),
          Button_format1(
            title: 'Sign Up!',
            onPressed_function: () async {
              print("Email: $register_email, Password: $register_password, Phone: $register_phone");
              try{
                UserCredential user = await auth.createUserWithEmailAndPassword(email: register_email, password: register_password);
                if(user!=null){
                  Navigator.pushNamed(context, ChatRoom.route_name);
                }
              }
              catch(exception){
                print('Register exception: $exception');
                Alert(context: context, title: "Please Retry", desc: 'Error: ${exception.toString()}').show();
              }
            },
          ),
        ],
      ),
    );
  }
}




class TextField_input extends StatelessWidget {
  String hint_text;
  IconData icon;
  Textfield_input_type type;
  bool secureText;
  TextField_input({this.hint_text, this.icon, this.type, this.secureText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: TextField(
        obscureText: secureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[300],
          icon: Icon(icon),
          hintText: hint_text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onChanged: (value){
          //print(value);
          if(type == Textfield_input_type.email){
            register_email = value;
          }
          else if(type == Textfield_input_type.password){
            register_password = value;
          }
          else if(type == Textfield_input_type.phone){
            register_phone = value;
          }
        },
      ),
    );
  }
}
