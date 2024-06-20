import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/chat_message.dart';
import 'package:flutter_clean_architecture_template/app/domain/enum/message_type_enum.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ConversationList();
  }
}

class ChatInput extends StatelessWidget {
  const ChatInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 8),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Digite sua mensagem...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

class ConversationList extends StatefulWidget {
  const ConversationList({
    super.key,
  });

  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  List<ChatMessage> messages = [
    ChatMessage(
      messageContent: "Houve um conflito na Av. Berrini",
      messageType: MessageTypeEnum.RECEIVER,
      name: 'Vigilante',
      time: '12:00',
    ),
    ChatMessage(
      messageContent: "Como esta a situação?",
      messageType: MessageTypeEnum.RECEIVER,
      name: 'Vigilante',
      time: '12:02',
    ),
    ChatMessage(
      messageContent: "Conflito resolvido.",
      messageType: MessageTypeEnum.RECEIVER,
      name: 'PoliciaL Militar',
      time: '12:04',
    ),
    ChatMessage(
      messageContent: "Ok!",
      messageType: MessageTypeEnum.RECEIVER,
      name: 'Vigilante',
      time: '12:05',
    ),
    ChatMessage(
      messageContent: "Obrigado!",
      messageType: MessageTypeEnum.SENDER,
      name: 'Morador',
      time: '12:06',
    ),
  ];

  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Align(
                  alignment:
                      (messages[index].messageType == MessageTypeEnum.RECEIVER
                          ? Alignment.topLeft
                          : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          (messages[index].messageType == MessageTypeEnum.SENDER
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          messages[index].name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          messages[index].messageContent,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 16, left: 16, top: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Digite sua mensagem...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () {
                  setState(() {
                    messages.add(ChatMessage(
                      messageContent: controller.text,
                      messageType: MessageTypeEnum.SENDER,
                      name: 'Morador',
                      time: '12:06',
                    ));
                    controller.clear();
                  });
                  Future.delayed(const Duration(milliseconds: 200), () {
                    scrollController.animateTo(
                      scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    );
                  });
                },
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        )
      ],
    );
  }
}
