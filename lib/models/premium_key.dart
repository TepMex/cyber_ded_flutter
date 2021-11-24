import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'premium_key.g.dart';

@JsonSerializable()
class PremiumKey extends ChangeNotifier {
  String? key;

  @JsonKey(name: 'isKeyValid')
  bool isValidKeySaved;

  PremiumKey(this.key, this.isValidKeySaved);

  factory PremiumKey.fromJson(Map<String, dynamic> json) =>
      _$PremiumKeyFromJson(json);

  Map<String, dynamic> toJson() => _$PremiumKeyToJson(this);

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
