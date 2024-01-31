import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  //get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  // get user stream

  //get message
}















  //send message
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







