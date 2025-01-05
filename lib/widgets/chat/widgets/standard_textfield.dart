import 'package:flutter/material.dart';
import 'package:util_and_style_cores/style/premade_widgets/roundish_divider.dart';

class StandardTextField extends StatelessWidget {
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  final String? hintText;
  final Color color;
  final Widget? bottomSection;
  const StandardTextField({
    super.key,
    this.onSubmitted,
    this.controller,
    this.hintText,
    this.color = Colors.white54,
    this.bottomSection,
  });

  @override
  Widget build(BuildContext context) {
    double borderRadius = 15;
    double standardPadding = 3;
    double textInputHeight = 65;
    double bottomSectionHeight = 38;

    return Container(
      padding: EdgeInsets.all(standardPadding),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color, // theme.getLightPrimaryColor(),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        children: [
          SizedBox(
            height: textInputHeight,
            width: double.infinity,
            child: TextField(
              controller: controller,
              maxLines: null,
              expands: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              textAlignVertical: TextAlignVertical.top,
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
              },
              style: const TextStyle(
                height: 1.25,
                color: Colors.black45,
              ),
              decoration: InputDecoration(
                hintMaxLines: 3,
                hintText: hintText,
                hintStyle: const TextStyle(
                  height: 1.25,
                  fontStyle: FontStyle.italic,
                  color: Colors.black26,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: EdgeInsets.all(textInputHeight * 0.1),
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: standardPadding, horizontal: 5),
            child: const RoundishDivider(
              height: 2,
              color: Colors.black26,
            ),
          ),
          SizedBox(
            height: bottomSectionHeight,
            child: bottomSection,
          ),
        ],
      ),
    );
  }
}

class StandardTextFieldBottomSection extends StatefulWidget {
  final List<Widget>? leftChildern;
  final List<Widget>? rightChildren;
  const StandardTextFieldBottomSection({
    super.key,
    this.leftChildern,
    this.rightChildren,
  });

  @override
  State<StandardTextFieldBottomSection> createState() =>
      _StandardTextFieldBottomSectionState();
}

class _StandardTextFieldBottomSectionState
    extends State<StandardTextFieldBottomSection> {
  @override
  Widget build(BuildContext context) {
    double standardPadding = 3;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          children: [
            if (widget.leftChildern != null)
              ...(widget.leftChildern ?? []).map(
                (child) => Padding(
                  padding: EdgeInsets.only(right: standardPadding),
                  child: SizedBox(
                    height: constraints.maxHeight,
                    child: child,
                  ),
                ),
              ),
            const Expanded(child: SizedBox()),
            if (widget.rightChildren != null)
              ...(widget.rightChildren ?? []).map(
                (child) => Padding(
                  padding: EdgeInsets.only(left: standardPadding),
                  child: SizedBox(
                    height: constraints.maxHeight,
                    child: child,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
