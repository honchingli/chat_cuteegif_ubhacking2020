import 'package:flutter/material.dart';

enum Textfield_input_type { email, password, phone }

class Button_format1 extends StatelessWidget {
  Function onPressed_function;
  String title;
  Button_format1({this.onPressed_function, this.title});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.black26,
      onPressed: onPressed_function,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }
}

class CommonButton extends StatelessWidget {
  Function functionButton;
  String title;
  CommonButton({this.title, this.functionButton});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: RaisedButton(
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(15),
        color: Colors.lightBlueAccent[400],
        onPressed: functionButton,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
