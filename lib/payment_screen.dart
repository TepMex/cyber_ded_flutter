import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'models/user.dart';

class PaymentScreen extends StatefulWidget {
  final User userModel;
  final ValueChanged<User> userModelUpdate;

  const PaymentScreen(
      {Key? key, required this.userModel, required this.userModelUpdate})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool alreadyChecked = false;
  var keyEditingController = TextEditingController();
  late User userModel;

  @override
  void initState() {
    userModel = widget.userModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: getKeyValidationStatus(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return Column(
                children: [
                  const Spacer(flex: 1),
                  const Text('Вам доступен весь платный контент',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  FloatingActionButton.extended(
                      label: const Text('Сбросить'),
                      onPressed: () {
                        userModel.premiumKey.key = null;
                        widget.userModelUpdate(widget.userModel);
                      }),
                  const Spacer(flex: 1),
                ],
              );
            }
            return Column(
              children: [
                const Spacer(flex: 1),
                const AutoSizeText(
                    'Пожалуйста, введите ключ для доступа к платному контенту',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                TextField(
                  controller: keyEditingController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Введите премиум-ключ сюда'),
                ),
                FloatingActionButton.extended(
                    label: const Text('Проверить'),
                    onPressed: () {
                      setState(() {
                        alreadyChecked = true;
                        userModel.premiumKey.key = keyEditingController.text;
                      });
                    }),
                Text(
                  alreadyChecked ? 'Ключ не прошел проверку' : '',
                  style: const TextStyle(color: Colors.red),
                ),
                const Spacer(flex: 1),
              ],
            );
          }),
    );
  }

  Future<bool> getKeyValidationStatus() async {
    if (userModel.premiumKey.key != null &&
        userModel.premiumKey.isValidKeySaved) {
      return true;
    }

    return await userModel.premiumKey.isKeyValid();
  }
}
