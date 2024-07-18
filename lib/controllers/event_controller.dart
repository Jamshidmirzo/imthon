import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_firebase/models/event.dart';
import 'package:new_firebase/services/event_http_service.dart';

class EventController extends ChangeNotifier {
  final EventHttpService eventService = EventHttpService();
  List<Event> _events = [];
  bool _isLoading = false;

  List<Event> get events => _events;
  bool get isLoading => _isLoading;

  EventController() {
    fetchEvents();
  }

  void fetchEvents() {
    _isLoading = true;
    notifyListeners();

    eventService.getEvents().listen((events) {
      _events = events;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addEvent(Event event, File photo) async {
    _isLoading = true;
    notifyListeners();

    try {
      String imageUrl = await eventService.uploadImage(photo);

      Event newEvent = Event(
        id: '', 
        creatorId: event.creatorId,
        name: event.name,
        time: event.time,
        geoPoint: event.geoPoint,
        description: event.description,
        imageUrl: imageUrl,
      );

      await eventService.addEvent(newEvent);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print("Error adding event: $e");
    }
  }
  
  Future<String> uploadImage(File imageFile) async {
    try {
      String imageUrl = await eventService.uploadImage(imageFile);
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }
}
