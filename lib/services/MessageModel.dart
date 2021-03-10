import 'package:firebase_database/firebase_database.dart';

class MessageModel {
  DatabaseReference _id;
  String text;
  String author;
  String date;
  String tripDate;
  String tripLocation;
  MessageModel(
      this.text, this.author, this.date, this.tripDate, this.tripLocation);

  Map<String, dynamic> toJson() {
    return {
      'text': this.text,
      'author': this.author,
      'date': this.date,
      'tripDate': this.tripDate,
      'tripLocation': this.tripLocation,
    };
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }
}

MessageModel createMessage(record) {
  Map<String, dynamic> attributes = {
    'text': '',
    'author': '',
    'date': '',
    'tripDate': '',
    'tripLocation': ''
  };
  record.forEach((key, value) => {attributes[key] = value});

  MessageModel messageModel = new MessageModel(
    attributes['text'],
    attributes['author'],
    attributes['date'],
    attributes['tripDate'],
    attributes['tripLocation'],
  );

  return messageModel;
}
