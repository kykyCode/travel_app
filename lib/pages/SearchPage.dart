import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/components/TripListView.dart';
import 'package:travel_app/services/tripModel.dart';

class SearchByParamsPage extends StatefulWidget {
  List<TripModel> tripList;
  final User user;

  SearchByParamsPage(this.tripList, this.user);
  @override
  _SearchByParamsPageState createState() => _SearchByParamsPageState();
}

class _SearchByParamsPageState extends State<SearchByParamsPage> {
  GlobalKey<FormState> _formKeySearch = GlobalKey<FormState>();
  RangeValues selectedRange = const RangeValues(0.2, 0.8);
  String dropdownValue1 = "01-01-2021";
  String dropdownValue2 = "01-01-2021";
  String searchBar = '';
  List<TripModel> tripsByParams = [];

  void filteredList(List<TripModel> list) {
    for (int i = 0; i < list.length; i++) {
      double bud = double.parse(list[i].budget);
      if (list[i]
              .mainLocation
              .toLowerCase()
              .contains(searchBar.toLowerCase(), 0) &&
          bud < selectedRange.end.round() &&
          bud > selectedRange.start.round()) {
        tripsByParams.add(list[i]);
      }
    }
  }

  void updateList() {
    setState(() {
      filteredList(this.widget.tripList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Expanded(
                child: Container(
                    color: Color.fromRGBO(224, 224, 224, 0.5),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color.fromRGBO(9, 189, 189, 1),
                                  Color.fromRGBO(74, 171, 180, 0.3)
                                ]),
                            border: Border.all(
                                color: Color.fromRGBO(74, 171, 180, 0.7),
                                width: 1.5),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.green[300],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 7,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          height: MediaQuery.of(context).size.height * 0.31,
                          width: MediaQuery.of(context).size.width * 1,
                          child: Column(children: <Widget>[
                            Container(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 15, right: 15),
                                child: Form(
                                  key: _formKeySearch,
                                  child: TextField(
                                    onChanged: (value) => {
                                      setState(() => {searchBar = value}),
                                      this.tripsByParams.clear(),
                                      updateList(),
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: IconButton(
                                          icon:
                                              Icon(Icons.location_on_outlined),
                                          onPressed: () {}),
                                      labelText: "Search by location",
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.search),
                                        splashColor: Colors.blueAccent,
                                        onPressed: () {},
                                        tooltip: "Post Message",
                                      ),
                                    ),
                                  ),
                                )),
                            Container(
                              padding: const EdgeInsets.only(left: 15, top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.attach_money_outlined,
                                      size: 26,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: RangeSlider(
                                        activeColor:
                                            Color.fromRGBO(80, 80, 80, 0.9),
                                        inactiveColor:
                                            Color.fromRGBO(80, 80, 80, 0.2),
                                        values: selectedRange,
                                        min: 0.0,
                                        max: 50000.0,
                                        onChanged: (RangeValues values) {
                                          setState(() {
                                            selectedRange = values;
                                          });
                                          this.tripsByParams.clear();
                                          updateList();
                                        },
                                      )),
                                  Container(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "min: " +
                                            selectedRange.start
                                                .round()
                                                .toString() +
                                            " \$",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(80, 80, 80, .9)),
                                      ),
                                      Text(
                                          "max: " +
                                              selectedRange.end
                                                  .round()
                                                  .toString() +
                                              " \$",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  80, 80, 80, .9))),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 17, right: 17),
                              child:
                                  Divider(color: Colors.black.withOpacity(0.8)),
                            ),
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 10),
                                child: Row(
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.airplanemode_active,
                                        size: 26,
                                        color: Colors.black38,
                                      ),
                                    ),
                                    DropdownButton<String>(
                                      value: dropdownValue1,
                                      icon: Icon(Icons.arrow_downward),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(80, 80, 80, .9)),
                                      underline: Container(
                                        height: 2,
                                        color: Color.fromRGBO(80, 80, 80, .4),
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          dropdownValue1 = newValue;
                                        });
                                      },
                                      items: <String>[
                                        '01-01-2021',
                                        '01-01-2022',
                                        '01-01-2023',
                                        '01-01-2024',
                                        '01-01-2025',
                                        '01-01-2026',
                                        '01-01-2027',
                                        '01-01-2028',
                                        '01-01-2029'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .1,
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          alignment: Alignment.center,
                                          child: Text(":",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      80, 80, 80, .9))),
                                        )),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.home,
                                        size: 26,
                                        color: Colors.black38,
                                      ),
                                    ),
                                    DropdownButton<String>(
                                      value: dropdownValue2,
                                      icon: Icon(Icons.arrow_downward),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(80, 80, 80, .9)),
                                      underline: Container(
                                        height: 2,
                                        color: Color.fromRGBO(80, 80, 80, .4),
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          dropdownValue2 = newValue;
                                        });
                                      },
                                      items: <String>[
                                        '01-01-2021',
                                        '01-01-2022',
                                        '01-01-2023',
                                        '01-01-2024',
                                        '01-01-2025',
                                        '01-01-2026',
                                        '01-01-2027',
                                        '01-01-2028',
                                        '01-01-2029'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        );
                                      }).toList(),
                                    )
                                  ],
                                )),
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * .6,
                          child: TripListView(
                              this.tripsByParams, this.widget.user),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color.fromRGBO(9, 189, 189, 1),
                                      Color.fromRGBO(74, 171, 180, 0.3)
                                    ]),
                                border: Border(
                                    top: BorderSide(
                                        color: Color.fromRGBO(80, 80, 80, .8),
                                        width: 2))),
                            height: MediaQuery.of(context).size.height * .09,
                            width: MediaQuery.of(context).size.width * 1,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Color.fromRGBO(80, 80, 80, .8),
                                )))
                      ],
                    )))));
  }
}
