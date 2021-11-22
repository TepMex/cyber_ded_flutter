import 'package:flutter/cupertino.dart';

import 'models/user.dart';

class HomeScreen extends StatelessWidget {
  final User userModel;
  const HomeScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lessonLink = userModel.lessons.first.contentLink;
    return Text(lessonLink,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
  }
}
