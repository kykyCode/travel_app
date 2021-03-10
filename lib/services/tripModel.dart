import 'package:firebase_database/firebase_database.dart';

class TripModel {
  DatabaseReference _id;
  String mainLocation;
  String date;
  String budget;
  String modeOfTransportation;
  String durationInDays;
  String creator;
  String imgPath;

  TripModel(
    this.mainLocation,
    this.date,
    this.budget,
    this.modeOfTransportation,
    this.durationInDays,
    this.creator,
    this.imgPath,
  );

  Map<String, dynamic> toJson() {
    return {
      'mainLocation': this.mainLocation,
      'date': this.date,
      'durationInDays': this.durationInDays,
      'budget': this.budget,
      'modeOfTransportation': this.modeOfTransportation,
      'creator': this.creator,
      'imgPath': this.imgPath,
    };
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }
}

TripModel createTrip(record) {
  Map<String, dynamic> attributes = {
    'mainLocation': '',
    'date': '',
    'budget': '',
    'modeOfTransportation': '',
    'durationInDays': '',
    'creator': '',
    'imgPath': '',
    'messages': [],
  };
  record.forEach((key, value) => {attributes[key] = value});

  TripModel tripModel = new TripModel(
    attributes['mainLocation'],
    attributes['date'],
    attributes['budget'],
    attributes['modeOfTransportation'],
    attributes['durationInDays'],
    attributes['creator'],
    attributes['imgPath'],
  );

  return tripModel;
}
