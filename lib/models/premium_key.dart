class PremiumKey {
  String? key;

  PremiumKey(this.key);

  PremiumKey.fromJson(Map<String, dynamic> json) : key = json['key'];

  Map<String, dynamic> toJson() => {
        'key': key,
      };

  bool isKeyValid() {
    if (key == null || key?.length != 20) {
      return false;
    }
    var validationRegex = RegExp(r'^[0-9A-Za-z]+$');
    if (!validationRegex.hasMatch(key!)) {
      return false;
    }
    // Надо сделать запрос к серверу и проверить валидность
    return true;
  }
}
