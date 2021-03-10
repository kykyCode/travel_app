import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  Function(String) callback;
  Function(String) callback2;
  TextInputWidget(this.callback, this.callback2);
  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  String _input;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextFormField(
        onChanged: ((value) => {
              _input = value,
            }),
        decoration: InputDecoration(
          prefixIcon: IconButton(icon: Icon(Icons.message), onPressed: () {}),
          labelText: "Type a message",
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            splashColor: Colors.blueAccent,
            onPressed: () {
              this.widget.callback(_input);
              this.widget.callback2(_input);
            },
            tooltip: "Post Message",
          ),
        ),
      ),
    ]);
  }
}
