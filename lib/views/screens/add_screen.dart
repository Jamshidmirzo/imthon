import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_firebase/controllers/event_controller.dart';
import 'package:new_firebase/models/event.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  File? imageFile;
  LatLng? selectedLocation;
  GoogleMapController? mapController;

  void openGallery() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 800,
    );
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  void openCamera() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 800,
    );
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onMapTapped(LatLng location) {
    setState(() {
      selectedLocation = location;
    });
  }

  void save() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      final eventController =
          Provider.of<EventController>(context, listen: false);

      Event newEvent = Event(
        id: UniqueKey()
            .toString(), 
        creatorId: FirebaseAuth
            .instance.currentUser!.uid, 
        name: nameController.text,
        time: Timestamp.fromDate(DateTime.now()),
        geoPoint:
            GeoPoint(selectedLocation!.latitude, selectedLocation!.longitude),
        description: descController.text,
        imageUrl: '',
      );

      await eventController.addEvent(newEvent, imageFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: save,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Add Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name of Event',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: descController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.timelapse_sharp, size: 40),
                    labelText: 'Description of Event',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      elevation: 6,
                      child: Container(
                        width: 180,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton.icon(
                          onPressed: openCamera,
                          label: const Text("Camera"),
                          icon: const Icon(Icons.camera),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 6,
                      child: Container(
                        width: 180,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton.icon(
                          onPressed: openGallery,
                          label: const Text("Gallery"),
                          icon: const Icon(Icons.photo),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (imageFile != null)
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(imageFile!),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                const Text(
                  'Select Location',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber,
                  ),
                  child: GoogleMap(
                    onMapCreated: onMapCreated,
                    onTap: onMapTapped,
                    initialCameraPosition: CameraPosition(
                      target: selectedLocation ??
                          LatLng(41.3111, 69.2401), // Default to Tashkent
                      zoom: 10,
                    ),
                    markers: selectedLocation != null
                        ? {
                            Marker(
                              markerId: MarkerId('selected-location'),
                              position: selectedLocation!,
                            )
                          }
                        : {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
