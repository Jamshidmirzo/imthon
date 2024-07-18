import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String creatorId;
  final String name;
  final Timestamp time;
  final GeoPoint geoPoint;
  final String description;
  final String imageUrl;

  Event({
    required this.id,
    required this.creatorId,
    required this.name,
    required this.time,
    required this.geoPoint,
    required this.description,
    required this.imageUrl,
  });

  factory Event.fromQuerySnapshot(QueryDocumentSnapshot<Object?> snapshot) {
    return Event(
      id: snapshot.id,
      creatorId: snapshot['creator-id'] as String,
      name: snapshot['name'] as String,
      time: snapshot['time'] as Timestamp,
      geoPoint: snapshot['geo-point'] as GeoPoint,
      description: snapshot['description'] as String,
      imageUrl: snapshot['image-url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'creator-id': creatorId,
      'name': name,
      'time': time,
      'geo-point': geoPoint,
      'description': description,
      'image-url': imageUrl,
    };
  }
}
