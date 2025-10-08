class Event {
  static const String collectionName = 'events';
  String id;
  String title;
  String description;
  String eventImage;
  String eventName;
  String eventTime;
  DateTime eventDataTime;
  bool isFavorite;

  Event({
    this.id = '',
    required this.title,
    required this.description,
    required this.eventImage,
    required this.eventName,
    required this.eventTime,
    required this.eventDataTime,
    this.isFavorite = false,
  });

  Event.fromFireStore(Map<String, dynamic> data)
    : this(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        eventDataTime: DateTime.fromMillisecondsSinceEpoch(
          data['eventDataTime'],
        ),
        eventImage: data['eventImage'],
        eventName: data['eventName'],
        eventTime: data['eventTime'],
        isFavorite: data['isFavorite'],
      );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'eventImage': eventImage,
      'eventName': eventName,
      'eventTime': eventTime,
      'eventDataTime': eventDataTime.millisecondsSinceEpoch,
      'isFavorite': isFavorite,
    };
  }
}
