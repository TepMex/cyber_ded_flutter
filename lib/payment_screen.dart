import 'package:flutter/cupertino.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("Экран платных функций",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
  }
}
