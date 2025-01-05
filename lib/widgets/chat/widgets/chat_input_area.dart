part of '../chat_ui.dart';

class _FancyChatInputArea extends StatefulWidget {
  final bool showOptions;
  final Function(types.PartialText) sendMessage;
  const _FancyChatInputArea({
    super.key,
    this.showOptions = false,
    required this.sendMessage,
  });

  @override
  State<_FancyChatInputArea> createState() => _FancyChatInputAreaState();
}

class _FancyChatInputAreaState extends State<_FancyChatInputArea> {
  final TextEditingController _controller = TextEditingController();
  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      widget.sendMessage(types.PartialText(text: _controller.text.trim()));
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: RoundishDivider(
            color: Colors.black12,
            height: 3,
          ),
        ),
        if (widget.showOptions)
          Consumer<ChatSessionProvider>(
            builder: (context, provider, child) {
              return _ReplySuggestionArea(
                  options: null, onSend: widget.sendMessage);
            },
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StandardTextField(
                hintText:
                    Provider.of<ChatSessionProvider>(context).inputFieldHints,
                controller: _controller,
                bottomSection: StandardTextFieldBottomSection(
                  rightChildren: [
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _sendMessage,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
