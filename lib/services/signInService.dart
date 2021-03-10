import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/pages/LoginPage.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
Future<User> signInWithCredentials(
    String my_email, String my_password, context) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: my_email, password: my_password);
    User user = _auth.currentUser;
    if (user != null) {
      return user;
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  } catch (e) {
    print(e.message);
  }
}
