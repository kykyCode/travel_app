import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/services/MessageModel.dart';

class PostList extends StatefulWidget {
  List<MessageModel> messagesList;
  final User user;
  PostList(this.messagesList, this.user);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.widget.messagesList.length,
        itemBuilder: (context, index) {
          var message = this.widget.messagesList[index];
          return Card(
              color: (message.author == cutApe(this.widget.user.email)
                  ? Color.fromRGBO(8, 189, 189, .7)
                  : Color.fromRGBO(80, 80, 80, .3)),
              child: Row(children: <Widget>[
                Expanded(
                    child: ListTile(
                  title: Text(message.text,
                      textAlign:
                          (message.author == cutApe(this.widget.user.email)
                              ? TextAlign.right
                              : TextAlign.left),
                      style: TextStyle(
                          letterSpacing: 2,
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Elecrtolize')),
                  subtitle: Text(
                    message.author,
                    textAlign: (message.author == cutApe(this.widget.user.email)
                        ? TextAlign.right
                        : TextAlign.left),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                )),
              ]));
        });
  }

  String cutApe(String email) {
    String result = email.substring(0, email.indexOf('@'));
    return result;
  }
}
