import 'dart:convert';

import 'package:cyber_ded_flutter/models/lesson.dart';
import 'package:cyber_ded_flutter/models/premium_key.dart';
import 'package:cyber_ded_flutter/models/review.dart';

class User {
  List<Lesson> lessons;
  List<Review> reviews;
  PremiumKey premiumKey;

  User(this.lessons, this.reviews, this.premiumKey);

  User.fromJson(Map<String, dynamic> json)
      : lessons = (jsonDecode(json['lessons']) as List<dynamic>)
            .map((e) => Lesson.fromJson(e))
            .toList(),
        reviews = (jsonDecode(json['reviews']) as List<dynamic>)
            .map((e) => Review.fromJson(e))
            .toList(),
        premiumKey = PremiumKey.fromJson(jsonDecode(json['premiumKey']));

  Map<String, dynamic> toJson() => {
        'lessons': jsonEncode(lessons),
        'reviews': jsonEncode(reviews),
        'premiumKey': jsonEncode(premiumKey),
      };

  void savePersistent() {
    throw UnimplementedError('Сохраняем всю модель в персистент');
  }

  void loadFromPersistent() {
    throw UnimplementedError('Грузим из персистента');
  }

  void lessonCompleted(int id) {
    lessons.firstWhere((lesson) => lesson.id == id).complete();
  }

  void reviewCompleted(int id, bool success) {
    reviews.firstWhere((review) => review.id == id).complete(success);
  }
}
