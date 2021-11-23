import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(flex: 1),
          FloatingActionButton.extended(
            label: const Text('Начать повторения'),
            onPressed: () {},
          ),
          const Text('Доступно 14'),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
