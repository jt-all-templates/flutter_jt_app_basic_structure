import 'package:flutter/material.dart';
import 'package:jt_app_basic_structure/widgets/chat/models/chat_processor.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

class ChatSessionProvider extends ChangeNotifier {
  ChatSessionProvider({
    ChatProcessor? chatProcessor,
    types.User user = const types.User(id: 'user'),
    types.User replier = const types.User(id: 'replier'),
    String Function(String)? processReply,
  })  : _user = user,
        _replier = replier,
        _chatProcessor = chatProcessor ?? ChatProcessor(),
        _processReply = processReply {
    startNewChat(chatProcessor: _chatProcessor);
  }
  ChatProcessor _chatProcessor;
  ChatProcessor get chatProcessor => _chatProcessor;

  List<types.User> _typingUsers = [];
  List<types.Message> get messages => _chatProcessor.messageHistory;
  List<types.User> get typingUsers => _typingUsers;

  types.User _user;
  types.User _replier;
  types.User get user => _user;
  types.User get replier => _replier;

  // after receiving a message from the other, how this message will be processed.
  // is good to be used for reading and processing commands or other non-human-read texts.
  String Function(String)? _processReply;
  String Function(String)? get processReply => _processReply;
  void setProcessReplyMethod(String Function(String) processReply) {
    _processReply = processReply;
  }

  Widget? _optionAreaWidget;
  Widget? get optionAreaWidget => _optionAreaWidget;
  void setOptionAreaWidget(Widget? widget) {
    _optionAreaWidget = widget;
    notifyListeners();
  }

  String? _inputFieldHints;
  String? get inputFieldHints => _inputFieldHints;
  void setInputFieldHints(String? hints) {
    _inputFieldHints = hints;
    notifyListeners();
  }

  bool get isOtherTyping => _chatProcessor.typingID.value == _replier.id;

  void startNewChat({
    required ChatProcessor chatProcessor,
    types.User? user,
    types.User? replier,
    String Function(String)? processReply,
  }) {
    // dispose of the old communicator
    if (_chatProcessor != chatProcessor) _chatProcessor.dispose();

    _chatProcessor = chatProcessor;
    _user = user ?? _user;
    _replier = replier ?? _replier;
    _processReply = processReply ?? _processReply;
    _chatProcessor.typingID.addListener(() {
      if (_chatProcessor.typingID.value == _replier.id) {
        _otherTypingStart(_replier);
      } else {
        _otherTypingStop(_replier);
      }
      notifyListeners();
    });
    _chatProcessor.latestReceivedMessage.addListener(() {
      onReceiveMessage();
    });
  }

  void setMessageHistory(List<types.Message> messages) {
    _chatProcessor.setMessageHistory(messages);
    notifyListeners();
  }

  void addAMessageToMessageHistory(types.Message message) {
    _chatProcessor.addAMessageToMessageHistory(message);
    notifyListeners();
  }

  void addMessageToMessageHistoryFromText(String text, types.User author) {
    var responseMessage = types.TextMessage(
      author: author,
      createdAt: DateTime.now()
          .subtract(const Duration(minutes: 10))
          .millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: text,
    );
    addAMessageToMessageHistory(responseMessage);
  }

  void loadMessages({
    bool clearMessages = false,
    List<types.Message>? initialMessages,
    Function()? afterLoaded,
  }) async {
    if (clearMessages) {
      _chatProcessor.messageHistory.clear();
      _chatProcessor.setMessageHistory(messages);
    } else {
      // push new messages to the back
      for (var message in initialMessages ?? []) {
        _chatProcessor.addAMessageToMessageHistory(message);
      }
    }
    afterLoaded?.call();
  }

  void sendTextMessage(types.TextMessage message) {
    _chatProcessor.sendString(text: message.text);
    notifyListeners();
  }

  void sendString(String text) {
    _chatProcessor.sendString(text: text);
    notifyListeners();
  }

  void onReceiveMessage() {
    types.Message? receivedMessage = _chatProcessor.latestReceivedMessage.value;
    if (receivedMessage != null &&
        receivedMessage.author.id == _replier.id &&
        receivedMessage is types.TextMessage) {
      types.TextMessage receivedTextMessage = receivedMessage;
      String? replyText = receivedTextMessage.text;
      String? processedText = _processReply?.call(replyText);
      if (processedText != null) {
        addMessageToMessageHistoryFromText(processedText, replier);
      }
      notifyListeners();
    }
  }

  void _otherTypingStart(types.User typer) {
    if (!_typingUsers.contains(typer)) _typingUsers.add(typer);
  }

  void _otherTypingStop(types.User typer) {
    _typingUsers.remove(typer);
  }

  @override
  void dispose() {
    _chatProcessor.dispose();
    super.dispose();
  }
}
