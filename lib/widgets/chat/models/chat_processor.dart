import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

class ChatProcessor {
  types.User user;
  List<types.User> chatTargets;
  ValueNotifier<String?> typingID = ValueNotifier(null);
  ValueNotifier<types.Message?> latestSentMessage = ValueNotifier(null);
  ValueNotifier<types.Message?> latestReceivedMessage = ValueNotifier(null);

  List<types.Message> messageHistory = [];

  ChatProcessor({
    this.user = const types.User(id: 'user'),
    this.chatTargets = const [types.User(id: 'replier')],
  });

  Future<void> sendTextMessage({required types.TextMessage textMessage}) async {
    latestSentMessage.value = textMessage;
  }

  Future<void> sendString({required String text}) async {
    latestSentMessage.value = types.TextMessage(
      id: const Uuid().v4(),
      author: user,
      text: text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    addAMessageToMessageHistory(latestSentMessage.value!);
    // placeholder reply.
    receiveMessage(
      types.TextMessage(
        id: const Uuid().v4(),
        author: chatTargets.first,
        text:
            "This is just a auto-reply. You won't get anything other than this message.",
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  void addAMessageToMessageHistory(types.Message message) {
    messageHistory.insert(0, message);
  }

  void setMessageHistory(List<types.Message> messages) {
    messageHistory = messages;
  }

  void receiveMessage(types.Message message) {
    latestReceivedMessage.value = message;
    addAMessageToMessageHistory(message);
  }

  void dispose() {
    typingID.dispose();
    latestSentMessage.dispose();
    latestReceivedMessage.dispose();
  }
}

ChatProcessor chatProcessor = ChatProcessor();
