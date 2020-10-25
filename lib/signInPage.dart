import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'functionPage.dart';
import 'defines.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

FirebaseAuth auth = FirebaseAuth.instance;

String input_email;
String input_password;

class SignIn extends StatefulWidget {
  static final String route_name = 'SignInRoute';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField_input(
            hint_text: 'Enter email',
            icon: Icons.email,
            type: Textfield_input_type.email,
            secureText: false,
          ),
          TextField_input(
            hint_text: 'Enter password',
            icon: Icons.double_arrow_rounded,
            type: Textfield_input_type.password,
            secureText: true,
          ),
          Button_format1(
            title: 'Sign in',
            onPressed_function: ()async{
              try {
                UserCredential user = await auth.signInWithEmailAndPassword(
                    email: input_email, password: input_password);
                if(user!=null){
                  Navigator.pushNamed(context, FunctionPage.route_name);
                }
              }
              catch(exception){
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
        onChanged: (value) {
          if (type == Textfield_input_type.email) {
            input_email = value;
          } else if (type == Textfield_input_type.password) {
            input_password = value;
          }
        },
      ),
    );
  }
}
