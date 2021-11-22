import 'package:flutter/material.dart';

import 'models/user.dart';

class PaymentScreen extends StatelessWidget {
  final User userModel;
  final ValueChanged<User> userModelUpdate;
  const PaymentScreen(
      {Key? key, required this.userModel, required this.userModelUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(userModel.premiumKey.key == null ? 'Премиума нет' : 'Премиум есть',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        FloatingActionButton(onPressed: () {
          userModel.premiumKey.key =
              userModel.premiumKey.key == null ? 'TESTPREMIUMKEY123456' : null;
          userModelUpdate(userModel);
        })
      ],
    );
  }
}
