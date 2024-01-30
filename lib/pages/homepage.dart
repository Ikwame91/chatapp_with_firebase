import 'package:chat_app_firebase_tutorial/authentication/auth_servicee.dart';
import 'package:chat_app_firebase_tutorial/components/mydrawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

void logout() async {
  final auth = Authservice();
  await auth.signOut();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Chat App'),
          centerTitle: true,
          actions: const [IconButton(onPressed: logout, icon: Icon(Icons.logout))]),
      body: const Center(
        child: Text(
          'Home Page',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
