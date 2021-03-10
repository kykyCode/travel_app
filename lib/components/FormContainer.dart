import 'package:flutter/material.dart';

class FormTripData extends StatefulWidget {
  @override
  _FormTripDataState createState() => _FormTripDataState();
}

class _FormTripDataState extends State<FormTripData> {
  @override
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String mainLocation;
  int year;
  int month;
  int day;
  int durationInDays;
  double budget;
  String modeOfTransportation;
  List placesToSee = [];

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(
                child: Column(children: <Widget>[
              AlertDialog(
                content: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      right: -40.0,
                      top: -40.0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              child: Text("Submitß"),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]))));
  }
}
