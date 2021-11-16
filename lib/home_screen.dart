import 'package:flutter/cupertino.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("Главный экран",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
  }
}
