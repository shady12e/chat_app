import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/constans.dart';
import 'package:myapp/model/massage_model.dart';
import 'package:myapp/widget/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  ChatPage({
    super.key,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference massages =
      FirebaseFirestore.instance.collection('messages');

  TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: massages.orderBy('date', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Massage> massagelist = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            massagelist.add(
              Massage.fromjson(
                snapshot.data!.docs[i],
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: KPrimaryAppColor,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    child: Image.asset(kLogo),
                  ),
                  const Text(
                    ' Chat By Shady',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: Kfont,
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return massagelist[index].id == email
                          ? ChatBubble(massage: massagelist[index])
                          : ChatBubbleForFrind(massage: massagelist[index]);
                    },
                    itemCount: massagelist.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      scrollDown();
                      sendMessage(data);
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'massage..',
                      suffixIcon: IconButton(
                        onPressed: () {
                          // send the message renamber it .
                          sendMessage(controller.text);
                          scrollDown();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: KPrimaryAppColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 3,
                          color: KPrimaryAppColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 3,
                          color: KPrimaryAppColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('Louding');
        }
      },
    );
  }

  void sendMessage(String message) {
    var email = ModalRoute.of(context)!.settings.arguments;
    if (message.isNotEmpty) {
      setState(() {
        massages.add({
          'message': message,
          'date': DateTime.now(),
          'id': email,
        });
      });
      controller.clear();
    }
  }

  void scrollDown() {
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }
}
