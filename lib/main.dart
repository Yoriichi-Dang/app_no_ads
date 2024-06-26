import 'package:adblocker_webview/adblocker_webview.dart';
import 'package:app_no_ads/widgets/TabView.dart';
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
          seedColor: Colors.white,
          brightness: Brightness.dark,
        ),
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
  TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;
  final _adBlockerWebviewController = AdBlockerWebviewController.instance;
  late String url;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 2) {
      print("add");
    }
  }

  void _onSearchSubmitted(String value) {
    setState(() {
      final pattern = r'\.[a-z]{2,}$';
      final regExp = RegExp(pattern, caseSensitive: false);

      if (regExp.hasMatch(value)) {
        // Nếu có phần mở rộng, thêm https:// nếu chưa có
        url = value.startsWith('http://') || value.startsWith('https://')
            ? value
            : 'https://$value';
      } else {
        // Nếu không có phần mở rộng, thêm .com
        url = 'https://$value.com';
      }

      _adBlockerWebviewController.loadUrl(url);
    });
  }

  @override
  void initState() {
    super.initState();
    url = "https://www.google.com";
    _adBlockerWebviewController.initialize();
    _adBlockerWebviewController.loadUrl(url);

    /// ... Other code here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchBar(),
      ),
      body: Column(children: [
        Expanded(
          child: TabView(
            url: url,
            controller: _adBlockerWebviewController,
          ),
        ),
      ]),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  Widget _bottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.tab), label: "Tab"),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "New tab"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      backgroundColor: Colors.black,
      onTap: _onItemTapped,
    );
  }

  Widget _searchBar() {
    return TextField(
      onSubmitted: (value) {
        _onSearchSubmitted(value);
      },
      controller: _searchController,
      decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Search or enter URL",
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              FocusScope.of(context).unfocus();
            },
          )),
      style: TextStyle(color: Colors.white),
    );
  }
}
