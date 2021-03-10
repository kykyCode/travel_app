import 'package:firebase_database/firebase_database.dart';
import 'package:travel_app/services/MessageModel.dart';
import 'package:travel_app/services/tripModel.dart';

final dbRef = FirebaseDatabase.instance.reference();

DatabaseReference saveTrip(TripModel tripModel) {
  var id = dbRef.child('trips/').push();
  id.set(tripModel.toJson());
  return id;
}

DatabaseReference saveMessage(MessageModel messageModel) {
  var id = dbRef.child('messages/').push();
  id.set(messageModel.toJson());
  return id;
}

Future<List<TripModel>> getAllTrips() async {
  DataSnapshot dataSnapshot = await dbRef.child('trips/').once();
  List<TripModel> trips = [];

  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      TripModel trip = createTrip(value);
      trip.setId(dbRef.child('trips/' + key));
      trips.add(trip);
    });
  }
  return trips;
}

Future<List<MessageModel>> getAllMessages() async {
  DataSnapshot dataSnapshot = await dbRef.child('messages/').once();
  List<MessageModel> messages = [];

  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      MessageModel message = createMessage(value);
      message.setId(dbRef.child('messages/' + key));
      messages.add(message);
    });
  }
  return messages;
}
