import 'package:atc_international/data/local/user_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../screens/messages/custom_chat.dart';
import '../model/project_firestore.dart';

class MessageViewModel {
  List messagesList = [];
  List modelsList = [];
  ProjectFirestore db = ProjectFirestore();
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('/chats/JjAXFp65ZIlI30IpCMAY/messages')
      .orderBy("time")
      .snapshots();

  StreamBuilder getMessageStream() {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        String userId = "x3VWycAAT4dgNwqkL41NegZ60ip1";

        return FutureBuilder(
            future: UserName().getUserId(),
            builder: (context, userIdSnapshot) {
              if (userIdSnapshot.hasData) {
                return ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;

                        if (data["sender"] == userIdSnapshot.data) {
                          return SenderChatBubble(content: data['content']);
                        } else {
                          return RecieverChatBubble(content: data['content']);
                        }
                      })
                      .toList()
                      .cast(),
                );
              } else {
                return CircularProgressIndicator();
              }
            });
      },
    );
  }
}

class Message {
  String? content;
  Timestamp? datetime;
  String? reciever;
  String? sender;
  Message(
      {required String this.content,
      required Timestamp this.datetime,
      required String this.reciever,
      required String this.sender});
}
