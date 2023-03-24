import 'package:atc_international/data/viewmodel/message_vm.dart';
import 'package:atc_international/screens/messages/custom_chat.dart';
import 'package:flutter/material.dart';

import '../../local_components/custom_text_themes.dart';
import '../../local_components/profile_picture.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var pageTitle = 'MESAJLARIM';
    return Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
        ),
        body: FutureBuilder(
            future: MessageViewModel().getChats(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return chatCard(context,
                        chatName: snapshot.data![index].chatPair!,
                        chatID: snapshot.data![index].chatID!,
                        isOnline: true);
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }

  InkWell chatCard(
    BuildContext context, {
    required String chatName,
    required String chatID,
    required bool isOnline,
  }) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed("/customChat",
          arguments: ScreenArguments(chatPairName: chatName, chatID: chatID)),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProfilePicture(radius: 30),
              Column(
                children: [
                  Text(
                    chatName, //TODO take care of possible long names
                    style: ProjectTextStyle.redMediumStrong(context),
                  ),
                  Row(
                    children: [
                      Text(
                        isOnline ? "Çevrim içi" : "Çevrim Dışı",
                        style: ProjectTextStyle.lightBlueSmallStrong(context),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 80,
                      ),
                      CircleAvatar(
                        backgroundColor: isOnline ? Colors.green : Colors.red,
                        maxRadius: MediaQuery.of(context).size.width / 60,
                      ),
                    ],
                  )
                ],
              ),
              const Icon(Icons.arrow_right),
            ],
          ),
        ),
      ),
    );
  }
}
