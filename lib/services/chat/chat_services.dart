import 'package:chat_app_firebase_tutorial/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ChatService {
  //get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  /*
   <List<Map<String, dynamic>>=
   [
    {
      'email': 'test@gmail.com',
      'id': '..',
      'time': '12:00'
    },
    {
      'message': 'kwame@gmail.com',
      'id': '...',
      'time': '12:00'
    }
   ]
  */

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //go through each document and get data
        final user = doc.data();

        //return user
        return user;
      }).toList();
    });
  }

  //send message
  Future<void> sendMessage(String receiverID, message) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newmessage = Message(
      senderId: currentUserId,
      senderEmail: currentEmail,
      receiverId: receiverID,
      message: message,
      timestamp: timestamp,
    );

    //construct chat rooms Id for the two users ({sorted to ensure uniqueness})
    List<String> ids = [currentUserId, receiverID];
    //sorting the ids ({ensures the chatroom id is the same for any 2 people})
    ids.sort();
    String chatRoomId = ids.join('_');

    //add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newmessage.toMap());
  }

  //get message
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    //construct a chatroom ID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Future<void> deleteMessage(String messageId, String receiverID) async {
    final String currentUserId = _auth.currentUser!.uid;
    // Get the current chat room ID
    List<String> ids = [currentUserId, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    try {
      await _firestore
          .collection("chat_rooms")
          .doc(chatRoomID)
          .collection("messages")
          .doc(messageId)
          .delete();
    } catch (e) {
      if (kDebugMode) {
        print("Error deleting message: $e");
      }
      // Handle the error (show a message, log, etc.)
    }
  }
}















  
  // Stream<List<Map<String, dynamic>>> sendMessage(
  //     String message, String email) {
  //   //get current time
  //   final time = DateTime.now().toIso8601String();

  //   //send message
  //   _firestore.collection("Messages").add({
  //     "message": message,
  //     "email": email,
  //     "time": time,
  //   });

  //   //return stream
  //   return _firestore.collection("Messages").snapshots().map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       //go through each document and get data
  //       final message = doc.data();

  //       //return message
  //       return message;
  //     }).toList();
  //   });
  // }







