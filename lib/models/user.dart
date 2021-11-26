import 'dart:convert';

import 'package:cyber_ded_flutter/models/lesson.dart';
import 'package:cyber_ded_flutter/models/premium_key.dart';
import 'package:cyber_ded_flutter/models/review.dart';
import 'package:cyber_ded_flutter/models/statistics.dart';
import 'package:cyber_ded_flutter/utils/user_model_builder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

const modelName = 'cyber_ded';

const actualVersion = '1.6';

@JsonSerializable()
class User extends ChangeNotifier {
  List<Lesson> lessons;
  List<Review> reviews;
  PremiumKey premiumKey;
  Statistics statistics;
  String version;

  User(this.lessons, this.reviews, this.premiumKey, this.statistics,
      {this.version = actualVersion});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  Future<void> savePersistent() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(modelName, jsonEncode(toJson()));
  }

  static Future<User> loadFromPersistent() async {
    var prefs = await SharedPreferences.getInstance();

    var jsonModel = prefs.getString(modelName);
    if (jsonModel == null || !checkVersion(jsonModel)) {
      await _initializePersistentModel();
    }
    jsonModel = prefs.getString(modelName);
    var loadedUserModel = User.fromJson(jsonDecode(jsonModel!));
    return loadedUserModel;
  }

  static Future<void> _initializePersistentModel() async {
    var initialModel = await UserModelInitializer.create();
    await initialModel.initializeLessons();
    await initialModel.initializeReviews();
    await initialModel.initializePremiumKey();

    var user = await initialModel.get();
    await user.savePersistent();
  }

  void lessonCompleted(int id) {
    lessons.firstWhere((lesson) => lesson.id == id).complete();
    notifyListeners();
  }

  void reviewCompleted(int id, bool success) {
    reviews.firstWhere((review) => review.id == id).complete(success);
    statistics.reviewStatistics.add(success);
    notifyListeners();
  }

  static bool checkVersion(String jsonModel) {
    return jsonDecode(jsonModel)['version'] == actualVersion;
  }
}
