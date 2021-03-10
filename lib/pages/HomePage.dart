import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/components/TripListView.dart';
import 'package:travel_app/pages/LoginPage.dart';
import 'package:travel_app/pages/SearchPage.dart';
import 'package:travel_app/services/ImageCapture.dart';
import 'package:travel_app/services/MessageModel.dart';
import 'package:travel_app/services/googleService.dart';
import 'package:travel_app/services/tripModel.dart';
import 'package:travel_app/services/database.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage(this.user);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String destination;
  String date;
  String budget;
  String transMethod;
  String duration;
  String creator;
  String imgPath;
  bool viewVisible = false;
  bool submitVal = true;

  double opacity = 0;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<TripModel> tripList = [];
  List<MessageModel> messageList = [];

  void getImgPath(String path) {
    setState(() {
      this.imgPath = path;
    });
  }

  void getChat(List chat) {
    setState(() {
      this.messageList = chat;
    });
  }

  void newTrip(String dest, String date, String budget, String trans,
      String duration, String creator, String imgPath) {
    var trip =
        new TripModel(dest, date, budget, trans, duration, creator, imgPath);

    trip.setId(saveTrip(trip));
    this.setState(() {
      tripList.add(trip);
    });
  }

  void updateTrips() {
    getAllTrips().then((trips) => {
          this.setState(() {
            this.tripList = trips;
          }),
        });
  }

  void visibleHandler() {
    setState(() {
      this.viewVisible = !viewVisible;
    });
  }

  void submitValidHandler() {
    setState(() {
      this.submitVal = false;
    });
  }

  void initState() {
    super.initState();
    getChat(messageList);
    updateTrips();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.grey[200],
            body: SingleChildScrollView(
                child: Container(
                    color: Color.fromRGBO(255, 255, 255, .5),
                    height: MediaQuery.of(context).size.height * 1,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Stack(children: <Widget>[
                      Column(children: [
                        Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.5,
                                  color: Color.fromRGBO(9, 189, 189, 1)),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color.fromRGBO(9, 189, 189, 1),
                                    Color.fromRGBO(74, 171, 180, 0.3)
                                  ]),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50)),
                            ),
                            child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.person,
                                                color: Colors.white,
                                              ),
                                              onPressed: null,
                                            )),
                                        Text(
                                          cutApe(widget.user.email),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              fontStyle: FontStyle.italic),
                                        )
                                      ],
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.logout,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          signOutGoogle();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()));
                                        })
                                  ],
                                ))),
                        Divider(
                          color: Colors.black38,
                        ),
                        Stack(children: <Widget>[
                          Visibility(
                            visible: !viewVisible,
                            child: Container(
                                width: MediaQuery.of(context).size.width * .96,
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: Container(
                                    child: TripListView(
                                        this.tripList, this.widget.user))),
                          ),
                          Visibility(
                              visible: viewVisible,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.5,
                                        color:
                                            Color.fromRGBO(74, 171, 180, 1))),
                                margin: const EdgeInsets.only(top: 30),
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    (MediaQuery.of(context).size.height * 0.7) -
                                        30,
                                child: Column(children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      child: Text(
                                    (submitVal
                                        ? "Let's fill trip data!"
                                        : "Data need to be fill complete!"),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Form(
                                      key: _formKey,
                                      child: Expanded(
                                          child: SingleChildScrollView(
                                              child: Container(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(children: <Widget>[
                                          TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                submitValidHandler();
                                              }
                                            },
                                            decoration: InputDecoration(
                                                labelText: 'Main destination'),
                                            onChanged: (value) =>
                                                destination = value,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                submitValidHandler();
                                              }
                                            },
                                            decoration: InputDecoration(
                                                labelText: 'Date (DD-MM-YYYY)'),
                                            onChanged: (value) => date = value,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                submitValidHandler();
                                              }
                                            },
                                            decoration: InputDecoration(
                                                labelText: 'Budget'),
                                            onChanged: (value) =>
                                                budget = value,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                submitValidHandler();
                                              }
                                            },
                                            decoration: InputDecoration(
                                                labelText:
                                                    'Mode of transportation'),
                                            onChanged: (value) =>
                                                transMethod = value,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                submitValidHandler();
                                              }
                                            },
                                            decoration: InputDecoration(
                                                labelText: 'Duration ( days )'),
                                            onChanged: (value) =>
                                                duration = value,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ImageCapture(this
                                                                .getImgPath)));
                                              },
                                              child: Text("Upload trip image")),
                                          ElevatedButton(
                                              onPressed: (submitVal
                                                  ? (() {
                                                      final formState =
                                                          _formKey.currentState;
                                                      if (formState
                                                          .validate()) {
                                                        String currUser = this
                                                            .widget
                                                            .user
                                                            .email;
                                                        newTrip(
                                                          this.destination,
                                                          this.date,
                                                          this.budget,
                                                          this.transMethod,
                                                          this.duration,
                                                          this.creator =
                                                              currUser,
                                                          this.imgPath,
                                                        );
                                                        visibleHandler();
                                                      }
                                                    })
                                                  : () {}),
                                              child: Text("Submit"))
                                        ]),
                                      ))))
                                ]),
                              ))
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(9, 189, 189, 1),
                            ),
                            onPressed: visibleHandler,
                            child: (viewVisible
                                ? Text("Back to trip list")
                                : Text("Add trip"))),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            primary: Color.fromRGBO(9, 189, 189, 1),
                          ),
                          icon: Icon(Icons.search),
                          label: Text("Search by parameters"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchByParamsPage(
                                          this.tripList,
                                          this.widget.user,
                                        )));
                          },
                        ),
                      ])
                    ])))));
  }

  String cutApe(String email) {
    String result = email.substring(0, email.indexOf('@'));
    return result;
  }
}
