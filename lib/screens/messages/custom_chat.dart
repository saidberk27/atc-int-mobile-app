import 'package:atc_international/data/local/user_name.dart';
import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

import '../../data/viewmodel/message_vm.dart';

class CustomChatPage extends StatelessWidget {
  CustomChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Said Berk'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 5, child: MessageViewModel().getMessageStream()),
          Expanded(
            flex: 2,
            child: messageInputArea(context),
          )
        ],
      ),
    );
  }

  Padding messageInputArea(BuildContext context) {
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
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        color: ProjectColor.darkBlue,
                      ),
                      splashRadius: 26,
                    ),
                    IconButton(
                      onPressed: () {},
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
  String? content;
  RecieverChatBubble({super.key, required String this.content});

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
      backGroundColor: ProjectColor.red,
      margin: EdgeInsets.only(top: 20),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Text(
          content!,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class SenderChatBubble extends StatelessWidget {
  String? content;
  SenderChatBubble({super.key, required String this.content});

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(top: 20),
      backGroundColor: ProjectColor.darkBlue,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Text(
          content!,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
