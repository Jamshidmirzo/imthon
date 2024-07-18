import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_firebase/views/screens/add_screen.dart';
import 'package:new_firebase/views/screens/notification_screen.dart';
import 'package:new_firebase/views/widgets/drawer_widget.dart';
import 'package:new_firebase/views/widgets/evets_item.dart';
import 'package:new_firebase/views/widgets/tadbir_item.dart';
import 'package:provider/provider.dart';
import 'package:new_firebase/controllers/event_controller.dart';
import 'package:new_firebase/models/event.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => EventController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final eventController = Provider.of<EventController>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          try {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AddScreen();
                },
              ),
            );
          } catch (e) {
            print('Error navigating to AddScreen: $e');
          }
        },
        child: Icon(Icons.add),
      ),
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.circle_notifications_rounded,
              size: 40,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Tadbirlarni izlash',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            final RenderBox button =
                                context.findRenderObject() as RenderBox;
                            final RenderBox overlay = Overlay.of(context)
                                .context
                                .findRenderObject() as RenderBox;
                            final RelativeRect position = RelativeRect.fromRect(
                              Rect.fromPoints(
                                button.localToGlobal(Offset.zero,
                                    ancestor: overlay),
                                button.localToGlobal(
                                    button.size.bottomRight(Offset.zero),
                                    ancestor: overlay),
                              ),
                              Offset.zero & overlay.size,
                            );
                            showMenu(
                              context: context,
                              position: position,
                              items: [
                                PopupMenuItem(
                                  child: Text("Option 1"),
                                  value: 1,
                                ),
                                PopupMenuItem(
                                  child: Text("Option 2"),
                                  value: 2,
                                ),
                              ],
                            ).then((value) {
                              // Handle the selected option here
                              if (value == 1) {
                                // Option 1 selected
                              } else if (value == 2) {
                                // Option 2 selected
                              }
                            });
                          },
                          child: Icon(CupertinoIcons.settings),
                        );
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text('Yaqin 7 kun ichida'),
                SizedBox(height: 20),
              ],
            ),
          ),
          SizedBox(
            height: 230,
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: PageView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  // Replace with your custom widget or remove if not needed
                  return TadbirItem();
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('Barcha tadbirlar'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: eventController.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: eventController.events.length,
                    itemBuilder: (context, index) {
                      final event = eventController.events[index];
                      return EvetsItem(event: event);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
