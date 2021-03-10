import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/components/MessagesList.dart';
import 'package:travel_app/components/TextInput.dart';
import 'package:travel_app/services/MessageModel.dart';
import 'package:travel_app/services/database.dart';
import 'package:travel_app/services/tripModel.dart';

class ChatPage extends StatefulWidget {
  TripModel trip;
  final User user;
  ChatPage(this.trip, this.user);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<MessageModel> messagesList = [];
  List<MessageModel> filteredList = [];
  String text;
  Timer timer;

  void newMessage(String text) {
    String date = (DateTime.now()).toString();
    var message = new MessageModel(text, cutApe(this.widget.user.email), date,
        this.widget.trip.date, this.widget.trip.mainLocation);
    message.setId(saveMessage(message));
  }

  DateTime stringToDateTime(String string) {
    DateTime date = DateTime.parse(string);
    return date;
  }

  List makeListSortedByDate(List list) {
    list.sort((a, b) => a.date.compareTo(b.date));
    return list;
  }

  List makeListFiltered(List list) {
    filteredList.clear();
    int length = list.length;
    for (int i = 0; i < length; i++) {
      if (list[i].tripDate == this.widget.trip.date &&
          list[i].tripLocation == this.widget.trip.mainLocation) {
        this.filteredList.add(list[i]);
      }
    }
    return filteredList;
  }

  void updateMessages() {
    getAllMessages().then((messages) => {
          this.setState(() {
            this.messagesList =
                makeListSortedByDate(makeListFiltered(messages));
          }),
        });
  }

  void updateString(String text) {
    setState(() {
      this.text = text;
    });
  }

  @override
  void initState() {
    updateMessages();
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => updateMessages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * .15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(9, 189, 189, 1),
                    Color.fromRGBO(74, 171, 180, 0.3)
                  ]),
              border: Border(
                  bottom: BorderSide(
                      width: 1.5, color: Color.fromRGBO(9, 189, 189, 1))),
              color: Colors.grey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        cutApe(this.widget.user.email),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Elecrtolize',
                            color: Colors.white),
                      ),
                      Divider(),
                      Text(
                          (this.widget.trip.mainLocation +
                                  ' ' +
                                  this.widget.trip.date)
                              .toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'Elecrtolize')),
                    ]),
                IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
          Expanded(
            child: PostList(this.messagesList, this.widget.user),
          ),
          TextInputWidget(this.updateString, this.newMessage),
        ],
      ),
    ));
  }

  String cutApe(String email) {
    String result = email.substring(0, email.indexOf('@'));
    return result;
  }
}
