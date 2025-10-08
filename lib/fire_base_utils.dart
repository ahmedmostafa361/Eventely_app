import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app_flutter/model/event.dart';

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
}
