
import 'package:flutter/material.dart';
import 'package:new_firebase/services/auth_firebase_service.dart';
import 'package:new_firebase/views/screens/home_screen.dart';



class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final emailcontorller = TextEditingController();
  final passcontorller = TextEditingController();
  final passerecontorller = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final firebaseservice = AuthFirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'ma`lumot kirg1izing';
                    }
                    return null;
                  },
                  controller: emailcontorller,
                  decoration: InputDecoration(
                    labelText: 'Emailingizni kirg`izing',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'ma`lumot kirg`izing';
                    }
                    return null;
                  },
                  controller: passcontorller,
                  decoration: InputDecoration(
                    labelText: 'Pasworridngizni kirg`izing',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (passcontorller.text != passerecontorller.text) {
                      return 'kodlar notog`ri';
                    }
                    return null;
                  },
                  controller: passerecontorller,
                  decoration: InputDecoration(
                    labelText: 'Pasworridngizni kirg`izing',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      firebaseservice.register(
                          emailcontorller.text, passcontorller.text);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ),
                      );
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Register"),
                    ],
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
