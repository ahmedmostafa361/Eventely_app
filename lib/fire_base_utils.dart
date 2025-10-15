import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app_flutter/model/event.dart';
import 'package:evently_app_flutter/model/my_users.dart';

class FireBaseUtils {
  static CollectionReference<Event> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromFireStore(snapshot.data()!),
          toFirestore: (event, options) => event.toFireStore(),
        );
  }

  static Future<void> addEventToFireStore(Event event) {
    var collectionReference = getEventCollection();
    var documentReference = collectionReference.doc();
    event.id = documentReference.id;
    return documentReference.set(event);
  }

  static CollectionReference<MyUsers> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUsers.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              MyUsers.fromFireStore(snapshot.data()!),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUserToFireStore(MyUsers myUser) {
    /// we will add user to fire store
    return FireBaseUtils.getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUsers?> readUserFromFireStore(String id) async {
    var user = await getUserCollection().doc(id).get();
    return user.data();
  }

  static Future<void> updateEvent(Event event, String id) {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .doc(id)
        .update({
          'title': event.title,
          'description': event.description,
          'eventImage': event.eventImage,
          'eventName': event.eventName,
          'eventTime': event.eventTime,
          'eventDataTime': event.eventDataTime.millisecondsSinceEpoch,
        });
  }
}
