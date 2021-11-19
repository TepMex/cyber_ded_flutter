import 'package:cyber_ded_flutter/models/review.dart';
import 'package:cyber_ded_flutter/models/premium_key.dart';
import 'package:cyber_ded_flutter/models/lesson.dart';
import 'package:cyber_ded_flutter/models/user.dart';

class UserModelInitializer {
  UserModelInitializer(this._currentUser);

  static UserModelInitializer create() {
    var currentUser = User([], [], PremiumKey(''));
    return UserModelInitializer(currentUser);
  }

  final User _currentUser;

  User get() {
    return _currentUser;
  }

  UserModelInitializer initializeLessons() {
    _currentUser.lessons.add(
        Lesson(1, 'content/lessons/001.md', false, LessonStatus.locked, null));
    return this;
  }

  UserModelInitializer initializeReviews() {
    _currentUser.reviews
        .add(Review(1, 1, 'content/reviews/001.json', SRSStatus.locked, null));
    return this;
  }

  UserModelInitializer initializePremiumKey() {
    _currentUser.premiumKey = PremiumKey(null);
    return this;
  }
}
