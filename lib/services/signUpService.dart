import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

Future<User> signUpWithCredentials(String my_email, String my_password) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: my_email, password: my_password);
  } catch (e) {
    print(e.message);
  }
  final User user = _auth.currentUser;
  if (user != null) {
    user.sendEmailVerification();
    return user;
  } else {
    print("ther's no user");
  }
}

Future<void> signOutUser() async {
  await _auth.signOut();
}
