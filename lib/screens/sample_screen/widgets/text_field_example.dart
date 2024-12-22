part of '../sample_screen.dart';

class TextFieldExample extends StatefulWidget {
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  const TextFieldExample({
    super.key,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<TextFieldExample> createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State<TextFieldExample> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // Handle unfocus event
        print('TextField unfocused');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: RelativeSizing.fromCommonUnit(300),
      height: RelativeSizing.fromCommonUnit(90),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        maxLines: null,
        expands: true,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        textAlignVertical: TextAlignVertical.top,
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
        },
        onChanged: widget.onChanged,
        onSubmitted: (String value) {
          FocusScope.of(context).unfocus();
          widget.onSubmitted?.call(value);
        },
        style: const TextStyle(
          height: 1.25,
          color: Colors.black54,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(RelativeSizing.fromCommonUnit(5)),
          fillColor: Colors.grey[350],
          filled: true,
          hintMaxLines: 2,
          hintText: "some hints goes here.",
          hintStyle: const TextStyle(
            height: 1.25,
            fontStyle: FontStyle.italic,
            color: Colors.black38,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(RelativeSizing.fromCommonUnit(12)),
            ),
          ),
        ),
      ),
    );
  }
}
