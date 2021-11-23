import 'package:universal_html/html.dart' as html;

import 'package:cyber_ded_flutter/home_screen.dart';
import 'package:cyber_ded_flutter/lessons_screen.dart';
import 'package:cyber_ded_flutter/payment_screen.dart';
import 'package:cyber_ded_flutter/review_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

enum CyberDedScreen { home, lesson, review, payment }

class _CyberDedHomePageState extends State<CyberDedHomePage>
    with WidgetsBindingObserver {
  User? userModel;
  CyberDedScreen _selectedIndex = CyberDedScreen.home;
  PaymentScreen? paymentScreen;
  String lessonMd = '';

  Future<User> getUserModel() async {
    userModel ??= await User.loadFromPersistent();

    return userModel!;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = CyberDedScreen.values[index];
    });
  }

  void loadAsset() async {
    var md = await rootBundle.loadString('content/lessons/001.md');
    setState(() {
      lessonMd = md;
    });
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      html.window.onUnload.listen((event) {
        getUserModel().then((value) => value.savePersistent());
      });
    }
    WidgetsBinding.instance!.addObserver(this);
    loadAsset();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    getUserModel().then((value) => value.savePersistent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<User>(
          future: getUserModel(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == null) {
              return ErrorWidget(
                  snapshot.error.toString() + snapshot.stackTrace.toString());
            }
            userModel = snapshot.data!;
            initScreens(userModel!);
            return Center(child: getCurrentScreen(userModel!));
          }),
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

  getCurrentScreen(User userModel) {
    switch (_selectedIndex) {
      case CyberDedScreen.home:
        return HomeScreen(userModel: userModel);
      case CyberDedScreen.lesson:
        return LessonsScreen(mdContent: lessonMd);
      case CyberDedScreen.review:
        return const ReviewScreen();
      case CyberDedScreen.payment:
        return paymentScreen;
    }
  }

  void onUserModelUpdate(User value) {
    setState(() {
      userModel = value;
    });
    userModel!.savePersistent();
  }

  void initScreens(User userModel) {
    paymentScreen = PaymentScreen(
      userModel: userModel,
      userModelUpdate: onUserModelUpdate,
    );
  }
}
