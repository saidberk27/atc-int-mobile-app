import 'dart:io';

import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

import '../../data/viewmodel/message_vm.dart';

class CustomChatPage extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();
  CustomChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ChatScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.chatPairName!),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 5, child: GetMessageStream(chatID: args.chatID!)),
          Expanded(
            flex: 2,
            child: messageInputArea(context, args),
          )
        ],
      ),
    );
  }

  Padding messageInputArea(BuildContext context, ChatScreenArguments args) {
    SnackBar fileSending =
        const SnackBar(content: Text("Dosya Gönderiliyor..."));
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: ProjectColor.darkBlue),
              borderRadius: const BorderRadius.all(Radius.circular(24))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.6,
                  child: TextFormField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: "Mesajınızı Giriniz...",
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    style: ProjectTextStyle.darkSmallStrong(context),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        print("Butona basıldı");
                        MessageViewModel()
                            .sendMessage(
                                content: _messageController.text,
                                chatID: args.chatID!)
                            .then((value) => print("Message Sent"));
                        _messageController.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: ProjectColor.darkBlue,
                      ),
                      splashRadius: 26,
                    ),
                    IconButton(
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          File file = File(result.files.single.path!);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(fileSending);
                          MessageViewModel()
                              .sendMedia(file: file, chatID: args.chatID!);
                        } else {
                          // User canceled the picker
                        }
                      },
                      icon: const Icon(
                        Icons.attach_file_outlined,
                        color: ProjectColor.darkBlue,
                      ),
                      splashRadius: 26,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecieverChatBubble extends StatelessWidget {
  final String? content;
  const RecieverChatBubble({super.key, required String this.content});

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
      backGroundColor: ProjectColor.red,
      margin: const EdgeInsets.only(top: 20),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Text(
          content!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class SenderChatBubble extends StatelessWidget {
  final String? content;
  const SenderChatBubble({super.key, required String this.content});

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: 20),
      backGroundColor: ProjectColor.darkBlue,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Text(
          content!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class MediaSenderChatBubble extends StatelessWidget {
  final String? mediaURL;
  const MediaSenderChatBubble({super.key, required String this.mediaURL});

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: 20),
      backGroundColor: ProjectColor.darkBlue,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Image.network(mediaURL!),
      ),
    );
  }
}

class MediaRecieverChatBubble extends StatelessWidget {
  final String? mediaURL;
  const MediaRecieverChatBubble({super.key, required String this.mediaURL});

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
      backGroundColor: ProjectColor.red,
      margin: const EdgeInsets.only(top: 20),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Image.network(mediaURL!),
      ),
    );
  }
}

class ChatScreenArguments {
  String? chatPairName;
  String? chatID;

  ChatScreenArguments({required this.chatPairName, required this.chatID});
}
