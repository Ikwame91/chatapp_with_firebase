import 'package:chat_app_firebase_tutorial/components/mydrawer.dart';
import 'package:chat_app_firebase_tutorial/components/user_tile.dart';
import 'package:chat_app_firebase_tutorial/pages/chat_page.dart';
import 'package:chat_app_firebase_tutorial/services/authentication/auth_servicee.dart';
import 'package:chat_app_firebase_tutorial/services/chat/chat_services.dart';
import 'package:chat_app_firebase_tutorial/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  void logout() async {
    final auth = Authservice();
    await auth.signOut();
  }

  final ChatService _chatService = ChatService();

  final Authservice _authservice = Authservice();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(_authservice.getCurentUser()?.email ?? 'Default Email',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            centerTitle: true,
            actions: [
            Consumer<ThemeProvider>(builder: ((context, value, child) {
              return IconButton(
                onPressed: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
                icon: Icon(
                  Provider.of<ThemeProvider>(context).isDarkMode
                      ? Icons.brightness_7
                      : Icons.brightness_2,
                ),
              );
            }))
          ],),
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
                receiverId: userData["uid"],
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
