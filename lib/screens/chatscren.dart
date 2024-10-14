import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasechat/constant.dart';
import 'package:firebasechat/widgets/messagestream.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final auth = FirebaseAuth.instance;
  late String? loggedInUser;
  final db = FirebaseFirestore.instance;
  String text = '';
  TextEditingController textcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void logout() async {
    try {
      await auth.signOut();
      print('Utilisateur déconnecté');
      Navigator.pop(context);
    } catch (e) {
      print('Erreur lors de la déconnexion: $e');
    }
  }

  void getCurrentUser() async {
    try {
      final User? user = auth.currentUser;

      if (user != null) {
        loggedInUser = user.email;
        print(loggedInUser);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // void getMessages() async {
  //   await db.collection("messages").get().then((event) {
  //     for (var doc in event.docs) {
  //       print("${doc.id} => ${doc.data()}");
  //     }
  //   });
  // }

  void messageStream() async {
    await for (var snapshot in db.collection('messages').snapshots()) {
      for (var change in snapshot.docChanges) {
        var doc = change.doc; // Accès au document
        print("Message: ${doc.data()}"); // Imprime les données du document
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.close), onPressed: logout),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Messagestream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textcontroller,
                      onChanged: (value) {
                        text = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      try {
                        db
                            .collection('messages')
                            .add({'mesageText': text, 'sender': loggedInUser});
                        textcontroller.clear();
                      } catch (e) {
                        throw e.toString();
                      }
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      required this.messageText,
      required this.messageSender,
      this.isMe = false});

  final String messageText;
  final String messageSender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            messageSender,
            style: TextStyle(fontSize: 12),
          ),
          Material(
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.greenAccent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('$messageText'),
            ),
          ),
        ],
      ),
    );
  }
}
