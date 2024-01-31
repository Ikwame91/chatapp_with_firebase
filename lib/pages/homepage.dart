import 'package:chat_app_firebase_tutorial/components/mydrawer.dart';
import 'package:chat_app_firebase_tutorial/components/user_tile.dart';
import 'package:chat_app_firebase_tutorial/pages/chat_page.dart';
import 'package:chat_app_firebase_tutorial/services/authentication/auth_servicee.dart';
import 'package:chat_app_firebase_tutorial/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();

  final Authservice _authservice = Authservice();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Chat App',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            centerTitle: true,
            actions: const [
              IconButton(onPressed: logout, icon: Icon(Icons.logout))
            ]),
        drawer: const MyDrawer(),
        body: _buildUserList(),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text('Error.');
          }

          //if loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.blue,
            );
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _buildUserItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserItem(Map<String, dynamic> userData, BuildContext context) {
    //display all users except cureent user
    if (userData["email"] != _authservice.getCurentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}

void logout() async {
  final auth = Authservice();
  await auth.signOut();
}
