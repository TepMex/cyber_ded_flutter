import 'dart:html';

import 'package:cyber_ded_flutter/home_screen.dart';
import 'package:cyber_ded_flutter/lessons_screen.dart';
import 'package:cyber_ded_flutter/payment_screen.dart';
import 'package:cyber_ded_flutter/review_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/user.dart';

void main() {
  runApp(const CyberDedApp());
}

class CyberDedApp extends StatelessWidget {
  const CyberDedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'КиберДед',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CyberDedHomePage(title: 'КиберДед'),
    );
  }
}

class CyberDedHomePage extends StatefulWidget {
  const CyberDedHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CyberDedHomePage> createState() => _CyberDedHomePageState();
}

class _CyberDedHomePageState extends State<CyberDedHomePage> {
  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    LessonsScreen(),
    ReviewScreen(),
    PaymentScreen(),
  ];
  int _selectedIndex = 0;
  User? _userModel;

  User? getUserModel() {
    return _userModel;
  }

  @override
  void initState() {
    super.initState();
    _initUserModel();
  }

  void _initUserModel() async {
    var user = await User.loadFromPersistent();
    setState(() {
      _userModel = user;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void yobaInit() async {
    var a = await loadAsset();
    print(a);
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('content/lessons/001.md');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: _screens.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Уроки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.refresh),
            label: 'Ревью',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Премиум',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.blueGrey,
        selectedLabelStyle: const TextStyle(
          color: Colors.blueGrey,
        ),
        onTap: _onItemTapped,
      ),
    );
  }
}
