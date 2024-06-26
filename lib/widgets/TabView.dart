import 'package:adblocker_webview/adblocker_webview.dart';
import 'package:flutter/material.dart';

class TabView extends StatefulWidget {
  final String url;
  final AdBlockerWebviewController controller;

  const TabView({super.key, required this.url, required this.controller});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  @override
  void initState() {
    super.initState();
    widget.controller.initialize();
    widget.controller.loadUrl(widget.url);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AdBlockerWebview(
            url: Uri.parse(widget.url),
            adBlockerWebviewController: widget.controller,
            onProgress: (progress) {
              setState(() {
                // Update the progress state if needed
              });
            },
            shouldBlockAds: true,
          ),
        ),
      ],
    );
  }
}
