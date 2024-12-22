part of '../sample_screen.dart';

class HorizontalScrollExample extends StatefulWidget {
  final List<String> items;
  const HorizontalScrollExample({super.key, this.items = const []});

  @override
  State<HorizontalScrollExample> createState() =>
      _HorizontalScrollExampleState();
}

class _HorizontalScrollExampleState extends State<HorizontalScrollExample> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: RelativeSizing.fromCommonUnit(300),
      height: RelativeSizing.fromCommonUnit(50),
      decoration: BoxDecoration(
        color: Colors.grey[350],
        borderRadius: BorderRadius.circular(RelativeSizing.fromCommonUnit(12)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxHeight * 0.15,
                vertical: constraints.maxHeight * 0.15,
              ),
              child: Row(
                children: [
                  for (var i = 0; i < widget.items.length; i++)
                    _HorizontalScrollItem(
                      content: widget.items[i],
                      paddingSize: constraints.maxHeight * 0.15,
                      isLast: i == widget.items.length - 1,
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HorizontalScrollItem extends StatelessWidget {
  final String content;
  final bool isLast;
  final double paddingSize;
  const _HorizontalScrollItem({
    super.key,
    this.content = '',
    this.isLast = false,
    this.paddingSize = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.only(right: isLast ? 0 : paddingSize),
          child: Container(
            padding: EdgeInsets.all(
              constraints.maxHeight * 0.12,
            ),
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius:
                  BorderRadius.circular(RelativeSizing.fromCommonUnit(7)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: RelativeSizing.fromCommonUnit(5),
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                content,
                style: const TextStyle(
                  height: 1.2,
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
