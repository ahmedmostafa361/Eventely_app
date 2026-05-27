import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:evently_app_flutter/model/event.dart';
import 'package:evently_app_flutter/fire_base_utils.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventsList = [];
  StreamSubscription? _subscription;

  /// Call this once you have the user id (e.g. after login)
  void listenToEvents(String userId) {
    _subscription?.cancel();
    _subscription = FireBaseUtils.getEventCollection(userId).snapshots().listen(
      (snapshot) {
        eventsList = snapshot.docs.map((doc) => doc.data()).toList();
        notifyListeners();
      },
    );
  }

  /// Filter events that have a valid location (needed for map)
  List<Event> get eventsWithLocation =>
      eventsList.where((e) => e.lat != null && e.long != null).toList();

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
