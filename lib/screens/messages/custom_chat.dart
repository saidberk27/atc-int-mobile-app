import 'package:atc_international/local_components/colors.dart';
import 'package:atc_international/local_components/custom_text_themes.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class CustomChatPage extends StatelessWidget {
  const CustomChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Said Berk'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: ListView(
              children: [
                BubbleSpecialThree(
                  text: 'Kasa seri numarası var mı ?',
                  color: ProjectColor.lightBlue,
                  tail: false,
                  isSender: true,
                  textStyle: TextStyle(color: ProjectColor.white, fontSize: 16),
                ),
                BubbleSpecialThree(
                  text: 'Hayır',
                  color: ProjectColor.red,
                  tail: false,
                  isSender: false,
                  textStyle: TextStyle(color: ProjectColor.white, fontSize: 16),
                ),
                BubbleSpecialThree(
                  text: 'Biz verelim',
                  color: ProjectColor.lightBlue,
                  tail: false,
                  isSender: true,
                  textStyle: TextStyle(color: ProjectColor.white, fontSize: 16),
                ),
                BubbleSpecialThree(
                  text: 'Hazırlayıp Atacağım Size',
                  color: ProjectColor.lightBlue,
                  tail: false,
                  isSender: true,
                  textStyle: TextStyle(color: ProjectColor.white, fontSize: 16),
                ),
                BubbleSpecialThree(
                  text: 'Tamamdır',
                  color: ProjectColor.red,
                  tail: false,
                  isSender: false,
                  textStyle: TextStyle(color: ProjectColor.white, fontSize: 16),
                ),
              ],
            ),
          ),
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
              borderRadius: BorderRadius.all(Radius.circular(24))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.6,
                  child: TextFormField(
                    decoration: InputDecoration(
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
