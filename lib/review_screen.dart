import 'package:flutter/cupertino.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Экран ревью",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    );
  }
}
