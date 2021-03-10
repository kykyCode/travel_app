import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/pages/SignUpPage.dart';

import 'package:travel_app/services/googleService.dart';
import 'package:travel_app/services/signInService.dart';
import 'package:travel_app/services/signUpService.dart';
import 'package:travel_app/services/userModel.dart';

import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  User user;
  String _email;
  String _password;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    signOutGoogle();
    signOutUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1,
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.jpg'),
                    fit: BoxFit.fill)),
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
                      key: _formkey,
                      child: Container(
                          padding:
                              EdgeInsets.only(top: 5.0, left: 20, right: 20),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter your email";
                                  } else if (value.contains('@') &&
                                      value.contains('.')) {
                                    return null;
                                  } else {
                                    return "It's not an email";
                                  }
                                },
                                onChanged: (value) => _email = value,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                ),
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black54)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black54)),
                                    labelText: "ENTER YOUR LOGIN",
                                    labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    )),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter your password";
                                  } else if (value.length < 6) {
                                    return "Incorrect password";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) => _password = value,
                                obscureText: true,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                ),
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black54)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black54)),
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                    labelText: "ENTER YOUR PASSWORD",
                                    labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    )),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              InkWell(
                                  onTap: () {
                                    final formState = _formkey.currentState;
                                    if (formState.validate()) {
                                      formState.save();

                                      signInWithCredentials(
                                              _email, _password, context)
                                          .then((user) => {
                                                this.user = user,
                                                if (user.emailVerified)
                                                  {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomePage(
                                                                    this.user)))
                                                  }
                                                else
                                                  {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                              title: Text(
                                                                  "Email verification required!"),
                                                              content: Text(
                                                                  "To verify user please, check your email."),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      "Okeej!"),
                                                                ),
                                                              ],
                                                            ))
                                                  }
                                              });
                                    }
                                  },
                                  child: Container(
                                    width: 400,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(255, 255, 255, .2),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.black38,
                                          width: 1,
                                        )),
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 30),
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 15),
                                    child: Text("LOGIN",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18)),
                                  )),
                              InkWell(
                                  onTap: () {
                                    signInWithGoogle().then((user) => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage(user)))
                                        });
                                  },
                                  child: Container(
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                76, 139, 245, .8),
                                          )),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Color.fromRGBO(
                                                      76, 139, 245, .8),
                                                  width: 0,
                                                )),
                                            child: Image.asset(
                                              'assets/images/button(2).png',
                                            ),
                                          ),
                                          Container(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          76, 139, 245, 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
                                                      border: Border.all(
                                                          color: Color.fromRGBO(
                                                              76, 139, 245, 1),
                                                          width: 4)),
                                                  alignment: Alignment.center,
                                                  height: 60,
                                                  width: 150,
                                                  child: Text(
                                                      "Sign in with Google",
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.white))))
                                        ],
                                      ))),
                            ],
                          )))),
              Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                          child: Text("Sign up with Travel App HERE!",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blueAccent))))),
            ]))));
  }
}
