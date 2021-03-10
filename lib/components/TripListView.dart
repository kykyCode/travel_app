import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:travel_app/pages/ChatPage.dart';
import 'package:travel_app/pages/DetailsPage.dart';

import 'package:travel_app/services/tripModel.dart';

class TripListView extends StatefulWidget {
  List<TripModel> list;
  final User user;

  TripListView(this.list, this.user);

  @override
  _TripListViewState createState() => _TripListViewState();
}

class _TripListViewState extends State<TripListView> {
  var tripa;
  @override
  void initState() {
    print("TripListViewKontrol");
    print(this.widget.list.length);
    print(this.widget.user.email);
  }

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.list.length,
      itemBuilder: (context, index) {
        var trip = this.widget.list[index];
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                ),
              ],
              border: Border.all(
                width: 1.5,
                color: Color.fromRGBO(9, 189, 189, 1),
              ),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(9, 189, 189, 1),
                    Color.fromRGBO(74, 171, 180, 0.3)
                  ]),
            ),
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.35,
            child: Container(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.33,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.location_on_outlined,
                                size: 30,
                              ),
                              onPressed: null),
                          Text(
                            trip.mainLocation.toUpperCase(),
                            style: TextStyle(
                                color: Color.fromRGBO(80, 80, 80, .8),
                                fontSize: 18,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Electrolize'),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.calendar_today,
                                size: 30,
                              ),
                              onPressed: null),
                          Text(
                            trip.date.toUpperCase(),
                            style: TextStyle(
                                color: Color.fromRGBO(80, 80, 80, .8),
                                fontSize: 18,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Electrolize'),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.attach_money_outlined,
                                size: 30,
                              ),
                              onPressed: null),
                          Text(
                            trip.budget.toUpperCase() + '\$',
                            style: TextStyle(
                                color: Color.fromRGBO(80, 80, 80, .8),
                                fontSize: 18,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Electrolize'),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.person,
                                size: 30,
                              ),
                              onPressed: null),
                          Text(
                            cutApe(trip.creator.toUpperCase()),
                            style: TextStyle(
                                color: Color.fromRGBO(80, 80, 80, .8),
                                fontSize: 18,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Electrolize'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              elevation: 2,
                              primary: Color.fromRGBO(9, 189, 189, .8),
                            ),
                            icon: Icon(Icons.group_add_outlined,
                                color: Color.fromRGBO(80, 80, 80, .8)),
                            label: Text(
                              "Join",
                              style: TextStyle(
                                  color: Color.fromRGBO(80, 80, 80, .8)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatPage(
                                            trip,
                                            this.widget.user,
                                          )));
                            },
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              elevation: 2,
                              primary: Color.fromRGBO(9, 189, 189, .8),
                            ),
                            icon: Icon(
                              Icons.info,
                              color: Color.fromRGBO(80, 80, 80, .8),
                            ),
                            label: Text(
                              "Check Info",
                              style: TextStyle(
                                  color: Color.fromRGBO(80, 80, 80, .8)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsPage(trip, this.widget.user)));
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                )));
      },
    );
  }

  String cutApe(String email) {
    String result = email.substring(0, email.indexOf('@'));
    return result;
  }
}
