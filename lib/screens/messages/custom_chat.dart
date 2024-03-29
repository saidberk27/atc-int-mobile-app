import 'dart:io';

import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

import '../../data/viewmodel/message_vm.dart';

class CustomChatPage extends StatefulWidget {
  const CustomChatPage({super.key});

  @override
  State<CustomChatPage> createState() => _CustomChatPageState();
}

class _CustomChatPageState extends State<CustomChatPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ChatScreenArguments;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 1100) {
        return webScaffold(args, context);
      } else {
        return mobileScaffold(args, context);
      }
    });
  }

  Scaffold webScaffold(ChatScreenArguments args, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.chatPairName!),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth / 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 5, child: GetMessageStream(chatID: args.chatID!)),
              Expanded(
                flex: 2,
                child: messageInputArea(context, args),
              )
            ],
          ),
        ),
      ),
    );
  }

  Scaffold mobileScaffold(ChatScreenArguments args, BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.6,
                  child: TextFormField(
                    controller: _messageController,
                    onFieldSubmitted: (value) {
                      MessageViewModel()
                          .sendMessage(
                              content: _messageController.text,
                              chatID: args.chatID!)
                          .then((value) => print("Message Sent"));
                      _messageController.clear();
                    },
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
                        try {
                          print("files are being picking...");
                          File file;
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();

                          if (kIsWeb) {
                            file = File(
                                ""); // if platform is web, file should be empty. Because on web, we work with bytes. for more info: https://stackoverflow.com/questions/65420592/flutter-web-file-picker-throws-invalid-arguments-path-must-not-be-null-e
                          } else {
                            file = File(result!.files.single.path!);
                          }

                          if (result != null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(fileSending);
                            MessageViewModel().uploadAndSendMedia(
                                file: file,
                                result: result,
                                chatID: args
                                    .chatID!); //file is necessary for mobile, result is necessary for web.
                          } else {
                            print("files are null");
                            // User canceled the picker
                          }
                        } catch (e) {
                          print("Error $e");
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
  const RecieverChatBubble(
      {super.key, int? height, required String this.content});

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
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ImageDialog(
              imageUrl: mediaURL!,
            );
          },
        );
      },
      child: ChatBubble(
        clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
        alignment: Alignment.topRight,
        margin: const EdgeInsets.only(top: 20),
        backGroundColor: ProjectColor.darkBlue,
        child: Container(
          height: 300,
          width: 300,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Image.network(
            mediaURL!,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class MediaRecieverChatBubble extends StatelessWidget {
  final String? mediaURL;
  const MediaRecieverChatBubble({super.key, required String this.mediaURL});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ImageDialog(
              imageUrl: mediaURL!,
            );
          },
        );
      },
      child: ChatBubble(
        clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
        backGroundColor: ProjectColor.red,
        margin: const EdgeInsets.only(top: 20),
        child: Container(
          height: 300,
          width: 300,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Image.network(
            mediaURL!,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class ChatScreenArguments {
  String? chatPairName;
  String? chatID;

  ChatScreenArguments({required this.chatPairName, required this.chatID});
}

class ImageDialog extends StatelessWidget {
  final String imageUrl;

  const ImageDialog({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: InteractiveViewer(
        maxScale: 5.0,
        panEnabled: true,
        child: Hero(
          tag: imageUrl,
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}
