// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app_firebase_tutorial/components/textfield.dart';
import 'package:chat_app_firebase_tutorial/services/authentication/auth_servicee.dart';
import 'package:chat_app_firebase_tutorial/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    required this.receiverEmail,
    required this.receiverId,
  }) : super(key: key);
  final String receiverEmail;
  final String receiverId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();

  final Authservice _authservice = Authservice();

  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

//send message
  void sendMessage() async {
    //if there is something inside the text field
    if (_messageController.text.isNotEmpty) {
      //send message
      await _chatService.sendMessage(
        widget.receiverId,
        _messageController.text,
      );

      //clear text field
      _messageController.clear();

      Future.delayed(const Duration(milliseconds: 1000), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.receiverEmail),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          // FocusScope.of(context).requestFocus(FocusNode());
          FocusScope.of(context).unfocus();
        },
        child: Column(
          //display all messages
          children: [
            Expanded(
              child: _buildMesssageList(),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMesssageList() {
    String senderId = _authservice.getCurentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverId, senderId),
        builder: (context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Text('Error.');
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Nothing here");
          }

          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data["senderId"] == _authservice.getCurentUser()!.uid;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Wrap(
        alignment: isCurrentUser ? WrapAlignment.end : WrapAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 280),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isCurrentUser ? Colors.green : Colors.grey,
            ),
            child: Text(
              data["message"],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              text: 'type here',
              obscureText: false,
              controller: _messageController,
              focusNode: _focusNode,
            ),
          ),
          IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                sendMessage();
              }),
        ],
      ),
    );
  }
}
