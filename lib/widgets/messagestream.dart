import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasechat/screens/chatscren.dart';
import 'package:flutter/material.dart';

class Messagestream extends StatelessWidget {
  Messagestream({super.key});

  final auth = FirebaseAuth.instance;
  late final String? loggedInUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageWidgets = [];
        for (var message in messages) {
          var messageText = message['mesageText'];
          var messageSender = message['sender'];
          final currentUser = auth.currentUser!.email;
          var messageWidget = MessageBubble(
            messageText: messageText,
            messageSender: messageSender,
            isMe: currentUser == messageSender,
          );
          messageWidgets.add(messageWidget);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            children: messageWidgets,
          ),
        );
      },
    );
  }
}
