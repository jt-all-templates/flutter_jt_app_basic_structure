part of '../app_persistent_layout.dart';

/// can provide a persistent bottom bar and global overlays
class _GlobalOverlayLayouter extends StatefulWidget {
  final Widget? content;
  final Widget? bottomBar;
  const _GlobalOverlayLayouter({
    super.key,
    this.content,
    this.bottomBar,
  });

  @override
  State<_GlobalOverlayLayouter> createState() => _GlobalOverlayLayouterState();
}

class _GlobalOverlayLayouterState extends State<_GlobalOverlayLayouter> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UiControlProvider>(
      builder: (context, uiControlProvider, child) {
        uiControlProvider.setRootContext(context);
        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (widget.content != null) widget.content!,
              if (widget.bottomBar != null &&
                  uiControlProvider.currentScreen.showBottomBar())
                Positioned(
                  bottom: 0,
                  child: widget.bottomBar!,
                ),
              // Using ValueListenableBuilder to listen to overlay changes
              ValueListenableBuilder<bool>(
                valueListenable: GlobalOverlayManager().overlayChangeNotifier,
                builder: (context, _, __) {
                  return Stack(
                    children: GlobalOverlayManager()
                        .overlays
                        .map((overlay) => overlay.overlay)
                        .toList(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
