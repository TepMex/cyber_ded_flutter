import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

import 'package:cyber_ded_flutter/home_screen.dart';
import 'package:cyber_ded_flutter/lessons_screen.dart';
import 'package:cyber_ded_flutter/payment_screen.dart';
import 'package:cyber_ded_flutter/review_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var userModel = await User.loadFromPersistent();
  runApp(ChangeNotifierProvider(
    create: (context) => userModel,
    child: const CyberDedApp(),
  ));
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

enum CyberDedScreen { lesson, review, statistics, payment }

class _CyberDedHomePageState extends State<CyberDedHomePage>
    with WidgetsBindingObserver {
  CyberDedScreen _selectedIndex = CyberDedScreen.lesson;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = CyberDedScreen.values[index];
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    if (kIsWeb) {
      html.window.onUnload.listen((event) async {
        await Provider.of<User>(context, listen: false).savePersistent();
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    Provider.of<User>(context, listen: false).savePersistent();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: getCurrentScreen()),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Уроки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.refresh),
            label: 'Повторения',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Статистика',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Премиум',
          ),
        ],
        currentIndex: _selectedIndex.index,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.blueGrey,
        selectedLabelStyle: const TextStyle(
          color: Colors.blueGrey,
        ),
        onTap: _onItemTapped,
      ),
    );
  }

  getCurrentScreen() {
    switch (_selectedIndex) {
      case CyberDedScreen.statistics:
        return const HomeScreen();
      case CyberDedScreen.lesson:
        // TODO: Переписать всё на чистую архитектуру с BLoC
        return LessonsScreen(
          payLockedContentPressed: () {
            setState(() {
              _selectedIndex = CyberDedScreen.payment;
            });
          },
        );
      case CyberDedScreen.review:
        return const ReviewScreen();
      case CyberDedScreen.payment:
        return const PaymentScreen();
    }
  }
}
