import 'dart:convert';
import 'dart:math';
import 'package:collection/collection.dart';

import 'package:cyber_ded_flutter/models/review.dart';
import 'package:cyber_ded_flutter/models/premium_key.dart';
import 'package:cyber_ded_flutter/models/lesson.dart';
import 'package:cyber_ded_flutter/models/statistics.dart';
import 'package:cyber_ded_flutter/models/user.dart';
import 'package:flutter/services.dart';

const premiumSuffix = '_p';

class UserModelInitializer {
  UserModelInitializer(this._currentUser);

  static Future<UserModelInitializer> create() async {
    var currentUser = User([], [], PremiumKey('', false), Statistics([]));
    return UserModelInitializer(currentUser);
  }

  final User _currentUser;

  Future<User> get() async {
    return _currentUser;
  }

  Future<UserModelInitializer> initializeLessons() async {
    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final files = json.decode(manifestJson) as Map;
    final lessonFiles = files.keys
        .where((key) => key.toString().startsWith('content/lessons'))
        .map((key) => key.toString())
        .toList();

    var lessons = lessonFiles.mapIndexed((idx, fileName) => Lesson(
        idx + 1,
        fileName,
        fileName.contains(premiumSuffix),
        fileName.contains(premiumSuffix)
            ? LessonStatus.payLocked
            : LessonStatus.locked,
        null));
    _currentUser.lessons.addAll(lessons);
    return this;
  }

  Future<UserModelInitializer> initializeReviews() async {
    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final files = json.decode(manifestJson) as Map;
    final reviewFiles = files.keys
        .where((key) => key.toString().startsWith('content/reviews'))
        .map((key) => key.toString())
        .toList();
    var extractLessonIdRegex = RegExp(r'_l([0-9]+).');
    int lessonId;
    var reviews = reviewFiles.mapIndexed((idx, fileName) {
      var lessonIdMatch = extractLessonIdRegex.firstMatch(fileName);
      if (lessonIdMatch != null && lessonIdMatch.group(1) != null) {
        lessonId = int.parse(lessonIdMatch.group(1)!);
      } else {
        lessonId = -1;
      }
      var rnd = Random.secure().nextDouble() > 0.5;
      return Review(
          idx + 1,
          lessonId,
          fileName,
          rnd ? SRSStatus.locked : SRSStatus.unlocked,
          rnd ? null : DateTime.now().add(const Duration(days: -1)));
    });
    _currentUser.reviews.addAll(reviews);
    return this;
  }

  Future<UserModelInitializer> initializePremiumKey() async {
    _currentUser.premiumKey = PremiumKey(null, false);
    return this;
  }
}
