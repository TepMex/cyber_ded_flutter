import 'dart:convert';

import 'package:cyber_ded_flutter/models/lesson.dart';
import 'package:cyber_ded_flutter/models/premium_key.dart';
import 'package:cyber_ded_flutter/models/review.dart';
import 'package:cyber_ded_flutter/models/statistics.dart';
import 'package:cyber_ded_flutter/utils/user_model_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

const modelName = 'cyber_ded';

const actualVersion = '1.1';

class User {
  List<Lesson> lessons;
  List<Review> reviews;
  PremiumKey premiumKey;
  Statistics stats;
  String version;

  User(this.lessons, this.reviews, this.premiumKey, this.stats,
      {this.version = actualVersion});

  User.fromJson(Map<String, dynamic> json)
      : lessons = (jsonDecode(json['lessons']) as List<dynamic>)
            .map((e) => Lesson.fromJson(e))
            .toList(),
        reviews = (jsonDecode(json['reviews']) as List<dynamic>)
            .map((e) => Review.fromJson(e))
            .toList(),
        premiumKey = PremiumKey.fromJson(jsonDecode(json['premiumKey'])),
        stats = Statistics.fromJson(jsonDecode(json['statistics'])),
        version = json['version'] ?? 'very old';

  Map<String, dynamic> toJson() => {
        'lessons': jsonEncode(lessons),
        'reviews': jsonEncode(reviews),
        'premiumKey': jsonEncode(premiumKey),
        'statistics': jsonEncode(stats),
        'version': jsonEncode(actualVersion),
      };

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
    var initialModel = UserModelInitializer.create()
        .initializeLessons()
        .initializeReviews()
        .initializePremiumKey()
        .get();
    await initialModel.savePersistent();
  }

  void lessonCompleted(int id) {
    lessons.firstWhere((lesson) => lesson.id == id).complete();
  }

  void reviewCompleted(int id, bool success) {
    reviews.firstWhere((review) => review.id == id).complete(success);
  }

  static bool checkVersion(String jsonModel) {
    return jsonDecode(jsonModel)['version'] == actualVersion;
  }
}
