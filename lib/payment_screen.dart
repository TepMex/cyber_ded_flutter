import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/user.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool alreadyChecked = false;
  var keyEditingController = TextEditingController();

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
                        keyEditingController.clear();
                        setState(() {
                          alreadyChecked = false;
                        });
                        var userModel =
                            Provider.of<User>(context, listen: false);
                        userModel.premiumKey.key = null;
                        userModel.premiumKey.isValidKeySaved = false;
                      }),
                  const Spacer(flex: 1),
                ],
              );
            } else if (snapshot.connectionState != ConnectionState.done) {
              return const CircularProgressIndicator();
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.extended(
                        label: const Text('Проверить'),
                        onPressed: () {
                          setState(() {
                            alreadyChecked = true;
                            Provider.of<User>(context, listen: false)
                                .premiumKey
                                .key = keyEditingController.text;
                          });
                        }),
                    FloatingActionButton.extended(
                        label: const Text('Купить'),
                        backgroundColor: Colors.pink,
                        icon: const Icon(Icons.payment),
                        onPressed: () {
                          launch(
                              'https://cyberded.exaccess.com/digiseller/articles/116699');
                        }),
                  ],
                ),
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
    if (Provider.of<User>(context, listen: false).premiumKey.key != null &&
        Provider.of<User>(context, listen: false).premiumKey.isValidKeySaved) {
      return true;
    }

    return await Provider.of<User>(context, listen: false)
        .premiumKey
        .isKeyValid();
  }
}
