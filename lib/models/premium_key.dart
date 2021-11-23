class PremiumKey {
  String? key;
  bool isValidKeySaved;

  PremiumKey(this.key, this.isValidKeySaved);

  PremiumKey.fromJson(Map<String, dynamic> json)
      : key = json['key'],
        isValidKeySaved = json['isKeyValid'] ?? false;

  Map<String, dynamic> toJson() => {
        'key': key,
        'isKeyValid': isValidKeySaved,
      };

  Future<bool> isKeyValid() async {
    isValidKeySaved = await _isKeyValid();
    return isValidKeySaved;
  }

  Future<bool> _isKeyValid() async {
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
