import 'dart:io';

import 'package:atc_international/data/local/current_user_data.dart';
import 'package:atc_international/data/model/project_firestorage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../local_components/get_today.dart';
import '../../screens/messages/custom_chat.dart';
import '../model/project_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MessageViewModel {
  List messagesList = [];
  List modelsList = [];
  ProjectFirestore db = ProjectFirestore();

  Future<void> sendMessage(
      {String type = "text",
      required String content,
      required String chatID}) async {
    DateTime messageSentTime = DateTime.parse(Time.getTimeStamp());
    Timestamp messageSentTimeStamp = Timestamp.fromDate(messageSentTime);
    String? senderID = await UserData.getUserId();
    Map<String, dynamic> messageJson = {
      "type": type,
      "content": content,
      "sender": senderID,
      "time": messageSentTimeStamp
    };
    db.addDocumentToCollection(
        json: messageJson, path: "/chats/$chatID/messages");
  }

  Future<void> uploadAndSendMedia(
      {required File file,
      required FilePickerResult result,
      required String chatID}) async {
    late String downloadURL;
    ProjectFireStorage projectFireStorage = ProjectFireStorage();
    if (kIsWeb) {
      // running on the web!
      print("web uploading...");
      downloadURL = await projectFireStorage.uploadFileWeb(result);
    } else {
      print("mobil uploading...");
      // NOT running on the web! You can check for additional platforms here.
      downloadURL = await projectFireStorage.uploadFile(file);
    }

    sendMessage(type: "media", content: downloadURL, chatID: chatID);
  }

  Future<List<Chat>> getChats() async {
    String? currentUserId = await UserData.getUserId();
    String? chatPairID;
    String? chatPairName;
    Map<dynamic, dynamic> user;
    List<Chat> chatList = [];
    String? chatID;
    List<dynamic> participantIDList;
    List<dynamic> chatsSnapshots =
        await db.readDocumentsFromDatabase(collectionPath: "/chats");
    for (var snapshot in chatsSnapshots) {
      participantIDList = snapshot["participants"];
      chatID = snapshot["id"];
      if (participantIDList.contains(currentUserId)) {
        participantIDList.forEach((element) {
          element != currentUserId
              ? chatPairID = element
              : element =
                  element; //picks the anoother participant ID in chat list (chat_participants)
        });

        user = await ProjectFirestore().getUser(
            userId:
                chatPairID!); //Converts another participant ID's to user name.
        chatPairName = user["user_name"];
        chatList.add(Chat.fromJson(
            chatID: chatID!, chatPair: chatPairName!, chatPairID: chatPairID!));
      }
    }

    return chatList;
  }

  Future<String?> getChatID({required String userID}) async {
    print(await getChat(chatPairID: userID));
    if (await getChat(chatPairID: userID) != null) {
      String? activeChatID = await getChat(chatPairID: userID);
      return activeChatID;
    } else {
      await _createChat(chatPairID: userID);
      String? activeChatID = await getChat(chatPairID: userID);
      return activeChatID;
    }
  }

  Future<void> _createChat({required String chatPairID}) async {
    String? currentUserId = await UserData.getUserId();
    final json = <String, dynamic>{
      "participants": [currentUserId, chatPairID]
    };
    ProjectFirestore().addDocumentToCollection(json: json, path: "chats/");
  }

  Future<String?> getChat({required String chatPairID}) async {
    List<Chat> chatList = await getChats();
    for (Chat chat in chatList) {
      if (chat.chatPairID == chatPairID) {
        return chat.chatID;
      }
    }
  }
}

class GetMessageStream extends StatelessWidget {
  GetMessageStream({
    super.key,
    required this.chatID,
  });

  ProjectFirestore db = ProjectFirestore();
  final String chatID;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.getChatStream(chatID: chatID),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("");
        }

        return FutureBuilder(
            //This future builder is necessary for getting user Id (Future, coming from hive)
            future: UserData.getUserId(),
            builder: (context, userIdSnapshot) {
              if (userIdSnapshot.hasData) {
                return ListView.separated(
                  reverse: true, //    .orderBy("time", descending: true)
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> data = snapshot.data!.docs[index]
                        .data()! as Map<String, dynamic>;
                    if (data["sender"] == userIdSnapshot.data &&
                        data['type'] == "text") {
                      return SenderChatBubble(content: data['content']);
                    } else if (data["sender"] == userIdSnapshot.data &&
                        data['type'] == "media") {
                      return MediaSenderChatBubble(mediaURL: data['content']);
                    }
                    //--------------------------------------------------------SENDER -> RECIEVER
                    else if (data["sender"] != userIdSnapshot.data &&
                        data['type'] == "text") {
                      return RecieverChatBubble(content: data['content']);
                    } else if (data["sender"] != userIdSnapshot.data &&
                        data['type'] == "media") {
                      return MediaRecieverChatBubble(mediaURL: data['content']);
                    }
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            });
      },
    );
  }
}

class Chat {
  String? chatID;
  String? chatPair;
  String? chatPairID;

  Chat.fromJson(
      {required String this.chatID,
      required String this.chatPair,
      required String this.chatPairID});
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
