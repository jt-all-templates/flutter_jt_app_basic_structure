part of '../chat_ui.dart';

class _ReplySuggestionArea extends StatefulWidget {
  final List<String>? options;
  final Function()? clearOptions;
  final Function(types.PartialText) onSend;
  const _ReplySuggestionArea({
    super.key,
    required this.options,
    this.clearOptions,
    required this.onSend,
  });

  @override
  State<_ReplySuggestionArea> createState() => _ReplySuggestionAreaState();
}

class _ReplySuggestionAreaState extends State<_ReplySuggestionArea> {
  void _sendOption(String option) {
    widget.onSend(types.PartialText(text: option));
    widget.clearOptions?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      height: 60,
      child: Consumer<ChatSessionProvider>(
        builder: (context, provider, child) {
          if (provider.optionAreaWidget == null) {
            return _buildOptions();
          } else {
            // not null...
            return provider.optionAreaWidget!;
          }
        },
      ),
    );
  }

  Widget _buildOptions() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var option in widget.options ?? [])
            _PromptShortcutButton(
              title: option,
              color: Colors.black12,
              onTap: () => _sendOption(option),
            ),
        ],
      ),
    );
  }
}

class _PromptShortcutButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function() onTap;
  const _PromptShortcutButton({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 6, 10, 6),
      child: ButtonPreset(
        onTap: onTap,
        padding: 5,
        height: double.infinity,
        normalColor: color,
        borderRadius: BorderRadius.circular(10),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black12,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
