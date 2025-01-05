import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:jt_app_basic_structure/widgets/chat/provider/chat_session_provider.dart';
import 'package:jt_app_basic_structure/widgets/chat/widgets/standard_textfield.dart';
import 'package:util_and_style_cores/style/buttons/presets/button_preset.dart';
import 'package:util_and_style_cores/style/premade_widgets/roundish_divider.dart';

part 'widgets/chat_input_area.dart';
part 'widgets/reply_suggestion_area.dart';

/// needs to be wrapped in a [ChatSessionProvider] to work.
class ChatUI extends StatefulWidget {
  final List<types.Message>? messageHistoryStartPoint;
  final Color backgroundColor;
  final Color primaryColor;
  final Color secondaryColor;
  const ChatUI({
    super.key,
    this.messageHistoryStartPoint,
    this.backgroundColor = const Color.fromARGB(200, 255, 255, 255),
    this.primaryColor = const Color.fromARGB(255, 208, 234, 255),
    this.secondaryColor = const Color.fromARGB(255, 255, 235, 208),
  });

  @override
  State<ChatUI> createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  late ChatSessionProvider chatSessionProvider;

  @override
  void initState() {
    super.initState();
    chatSessionProvider =
        Provider.of<ChatSessionProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        chatSessionProvider.loadMessages(
          initialMessages: widget.messageHistoryStartPoint,
          clearMessages: true,
        );
      },
    );
  }

  void _handleSendPressed(types.PartialText message) {
    print("The sending message is: ${message.text}");
    chatSessionProvider.sendString(message.text);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatSessionProvider>(
      builder: (context, chatSessionProvider, child) {
        print("The message history is: ${chatSessionProvider.messages}");
        return Scaffold(
          // scaffold will make sure the textfield is always visible.
          body: Column(
            children: [
              Expanded(
                child: Chat(
                  typingIndicatorOptions: TypingIndicatorOptions(
                    typingUsers: chatSessionProvider.typingUsers,
                  ),
                  theme: DefaultChatTheme(
                    inputPadding: EdgeInsets.zero,
                    messageInsetsHorizontal: 12,
                    messageInsetsVertical: 10,
                    dateDividerMargin:
                        const EdgeInsets.only(bottom: 24, top: 12),
                    backgroundColor: widget.backgroundColor,
                    primaryColor: widget.primaryColor,
                    secondaryColor: widget.secondaryColor,
                    sentMessageBodyTextStyle: const TextStyle(
                      height: 1.25,
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    receivedMessageBodyTextStyle: const TextStyle(
                      height: 1.25,
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  messageWidthRatio: 0.78,
                  customBottomWidget: ChatInputArea(
                    onSendPressed: _handleSendPressed,
                  ),
                  onSendPressed: _handleSendPressed,
                  messages: chatSessionProvider.messages,
                  // onMessageTap: _handleMessageTap,
                  showUserAvatars: false,
                  showUserNames: false,
                  user: chatSessionProvider.user,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChatInputArea extends StatefulWidget {
  final Function(types.PartialText) onSendPressed;
  const ChatInputArea({super.key, required this.onSendPressed});

  @override
  State<ChatInputArea> createState() => _ChatInputAreaState();
}

class _ChatInputAreaState extends State<ChatInputArea> {
  final TextEditingController _controller = TextEditingController();
  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSendPressed(types.PartialText(text: _controller.text.trim()));
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 100,
                ),
                child: TextField(
                  controller: _controller,
                  maxLines: 5,
                  minLines: 1,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () => FocusScope.of(context)
                      .unfocus(), // Hide keyboard on Enter
                  decoration: InputDecoration(
                    hintText: "Type a message...",
                    filled: true,
                    fillColor: const Color.fromARGB(255, 206, 206, 206),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: _sendMessage,
              color: Colors.lightGreen,
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
