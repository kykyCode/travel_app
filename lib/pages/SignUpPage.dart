import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/services/signUpService.dart';

import 'LoginPage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String _password;
  String _email;
  User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.fill)),
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Center(
              child: Container(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Container(
                    child: Image.asset('assets/images/bus.png'),
                  ))),
          Center(
            child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                    validator: (value) {
                      if (value.contains(".") && value.contains("@")) {
                        return null;
                      } else if (value.isEmpty) {
                        return "Please, enter your email!";
                      } else {
                        return "It is not an email!";
                      }
                    },
                    onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      labelText: "ENTER YOUR EMAIL",
                      labelStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54)),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please, enter your password!";
                      } else if (value.length <= 8) {
                        return "Password must be longer than 8 characters!";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => _password = value,
                    onSaved: (value) => _password = value,
                    decoration: InputDecoration(
                      labelText: "ENTER YOUR PASSWORD",
                      labelStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54)),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value == _password) {
                        return null;
                      } else {
                        return "Repeat the password correctly!";
                      }
                    },
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                    decoration: InputDecoration(
                      labelText: "REPEAT PASSWORD",
                      labelStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54)),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  InkWell(
                      onTap: () {
                        final formState = formkey.currentState;
                        if (formState.validate()) {
                          formState.save();
                          signUpWithCredentials(_email, _password);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }
                      },
                      child: Container(
                        width: 400,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, .2),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.black38,
                              width: 1,
                            )),
                        margin: EdgeInsets.only(top: 30, bottom: 5),
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Text("SIGN UP",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 18)),
                      )),
                ],
              ),
            ),
          )
        ])),
      ),
    );
  }
}
