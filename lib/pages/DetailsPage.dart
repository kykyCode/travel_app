import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/services/Downloader.dart';

class DetailsPage extends StatefulWidget {
  var tripa;
  final User user;
  DetailsPage(this.tripa, this.user);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String description =
      "On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.";

  @override
  void initState() {
    print("DetailsPageControl");
    print(this.widget.user.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 1,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.361,
                        child: Column(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  border: Border.all(
                                      width: 1.5, color: Colors.black),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                  iconSize: 40,
                                )),
                            Expanded(
                                child: Container(
                                    color: Colors.white,
                                    child: FutureBuilder(
                                      future: getImg(
                                          context, this.widget.tripa.imgPath),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            child: snapshot.data,
                                          );
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  1,
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text("Loading..."),
                                              ));
                                        }
                                      },
                                    ))),
                          ],
                        )),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(width: 1, color: Colors.black)),
                      height: MediaQuery.of(context).size.height * 0.13,
                      width: MediaQuery.of(context).size.width * 1,
                      child: Column(children: <Widget>[
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.all(12),
                                  child: Row(children: <Widget>[
                                    Icon(
                                      Icons.person_outline,
                                      color: Colors.black,
                                    ),
                                    Text(cutApe(this.widget.tripa.creator)),
                                  ])),
                              Container(
                                margin: const EdgeInsets.all(12),
                                child: Row(children: <Widget>[
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.black,
                                  ),
                                  Text(this.widget.tripa.date),
                                ]),
                              ),
                              Container(
                                margin: const EdgeInsets.all(12),
                                child: Row(children: <Widget>[
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.black,
                                  ),
                                  Text(this.widget.tripa.mainLocation)
                                ]),
                              )
                            ],
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.all(12),
                                child: Row(children: <Widget>[
                                  Icon(
                                    Icons.attach_money_outlined,
                                    color: Colors.black,
                                  ),
                                  Text(this.widget.tripa.budget + " zl"),
                                ]),
                              ),
                              Container(
                                margin: const EdgeInsets.all(12),
                                child: Row(children: <Widget>[
                                  Icon(
                                    Icons.timelapse,
                                    color: Colors.black,
                                  ),
                                  Text(this.widget.tripa.durationInDays +
                                      " days")
                                ]),
                              ),
                              Container(
                                margin: const EdgeInsets.all(12),
                                child: Row(children: <Widget>[
                                  Icon(
                                    Icons.time_to_leave_outlined,
                                    color: Colors.black,
                                  ),
                                  Text(this.widget.tripa.modeOfTransportation)
                                ]),
                              ),
                            ]),
                      ]),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: Container(
                                child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: Text(
                          description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              border: Border.all(
                                width: 1,
                              )),
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                  child: Text("DM",
                                      style: TextStyle(fontSize: 26))),
                              Container(
                                  child: Text("JOIN",
                                      style: TextStyle(fontSize: 26))),
                              Container(
                                  child: Text("LIKE",
                                      style: TextStyle(fontSize: 26))),
                            ],
                          ))
                    ])))),
                  ],
                ))));
  }

  String cutApe(String email) {
    String result = email.substring(0, email.indexOf('@'));
    return result;
  }
}
