import 'package:flutter_clean_architecture_template/app/domain/enum/message_type_enum.dart';

class ChatMessage {
  final String messageContent;
  final MessageTypeEnum messageType;
  final String name;
  final String time;
  ChatMessage({
    required this.messageContent,
    required this.messageType,
    required this.name,
    required this.time,
  });
}
