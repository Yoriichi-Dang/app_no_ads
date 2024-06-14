import 'package:adblocker_webview/adblocker_webview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _adBlockerWebviewController = AdBlockerWebviewController.instance;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _adBlockerWebviewController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdBlocker Webview Example'),
      ),
      body: Stack(
        children: [
          AdBlockerWebview(
            url: Uri.parse("https://www.google.com/"), // Convert String to Uri
            adBlockerWebviewController: _adBlockerWebviewController,
            onProgress: (progress) {
              setState(() {
                _progress = progress.toDouble();
              });
            },
            shouldBlockAds: true,
          ),
          if (_progress < 1.0) LinearProgressIndicator(value: _progress),
        ],
      ),
    );
  }
}
