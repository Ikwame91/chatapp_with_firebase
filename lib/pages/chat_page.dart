import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.receiverEmail});
  final String receiverEmail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('C H A T P A G E'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('C H A T P A G E'),
      ),
    );
  }
}
