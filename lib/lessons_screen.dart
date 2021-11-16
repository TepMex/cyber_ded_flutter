import 'package:flutter/cupertino.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("Экран уроков",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
  }
}
