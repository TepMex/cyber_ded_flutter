import 'dart:convert';

import 'package:cyber_ded_flutter/models/lesson.dart';
import 'package:cyber_ded_flutter/models/premium_key.dart';
import 'package:cyber_ded_flutter/models/review.dart';
import 'package:cyber_ded_flutter/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Lesson fromJson deserialization', () {
    var jsonLesson = '''{
      "id": 1,
      "contentLink": "content/lessons/001.md",
      "isPremiumContent": false,
      "status": "open",
      "completeDate": "2021-12-01 05:30:01"
    }''';

    var actual = Lesson.fromJson(jsonDecode(jsonLesson));

    expect(actual.id, 1);
    expect(actual.contentLink, 'content/lessons/001.md');
    expect(actual.isPremiumContent, false);
    expect(actual.status, LessonStatus.open);
    expect(actual.completeDate, DateTime.parse('2021-12-01 05:30:01'));
  });

  test('Lesson toJson serialization', () {
    var l = Lesson(1, 'content/lessons/001.md', true, LessonStatus.locked,
        DateTime.parse('2021-12-01 05:30:01'));

    var jsonStr = jsonEncode(l.toJson());

    expect(jsonStr,
        '''{"id":1,"contentLink":"content/lessons/001.md","isPremiumContent":true,"status":"locked","completeDate":"2021-12-01T05:30:01.000"}''');
  });
  test('Review fromJson deserialization', () {
    var jsonReview = '''{
      "id": 1,
      "lessonId": 2,
      "contentLink": "content/review/001.json",
      "status": "guru",
      "nextReviewDate": "2021-12-01 05:30:01"
    }''';

    var actual = Review.fromJson(jsonDecode(jsonReview));

    expect(actual.id, 1);
    expect(actual.lessonId, 2);
    expect(actual.contentLink, 'content/review/001.json');
    expect(actual.status, SRSStatus.guru);
    expect(actual.nextReviewDate, DateTime.parse('2021-12-01 05:30:01'));
  });

  test('Review toJson serialization', () {
    var r = Review(3, 4, 'content/review/003.json', SRSStatus.apprentice,
        DateTime.parse('2021-12-01 05:30:01'));

    var jsonStr = jsonEncode(r.toJson());

    expect(jsonStr,
        '''{"id":3,"lessonId":4,"contentLink":"content/review/003.json","status":"apprentice","nextReviewDate":"2021-12-01T05:30:01.000"}''');
  });

  test('User fromJson', () {
    var jsonStr =
        """{"lessons":"[{\\"id\\":1,\\"contentLink\\":\\"content/lessons/001.md\\",\\"isPremiumContent\\":true,\\"status\\":\\"locked\\",\\"completeDate\\":\\"2021-12-01T05:32:01.000\\"},{\\"id\\":2,\\"contentLink\\":\\"content/lessons/002.md\\",\\"isPremiumContent\\":true,\\"status\\":\\"completed\\",\\"completeDate\\":\\"2021-12-01T05:31:01.000\\"}]","reviews":"[{\\"id\\":3,\\"lessonId\\":4,\\"contentLink\\":\\"content/review/003.json\\",\\"status\\":\\"apprentice\\",\\"nextReviewDate\\":\\"2021-12-21T05:30:01.000\\"},{\\"id\\":4,\\"lessonId\\":4,\\"contentLink\\":\\"content/review/004.json\\",\\"status\\":\\"guru\\",\\"nextReviewDate\\":\\"2021-12-11T05:30:01.000\\"}]","premiumKey":"{\\"key\\":\\"test key\\"}"}""";
    var u = User.fromJson(jsonDecode(jsonStr));

    expect(u.lessons.length, 2);
  });

  test('User toJson serialization', () {
    var r1 = Review(3, 4, 'content/review/003.json', SRSStatus.apprentice,
        DateTime.parse('2021-12-21 05:30:01'));
    var r2 = Review(4, 4, 'content/review/004.json', SRSStatus.guru,
        DateTime.parse('2021-12-11 05:30:01'));
    var l1 = Lesson(1, 'content/lessons/001.md', true, LessonStatus.locked,
        DateTime.parse('2021-12-01 05:32:01'));
    var l2 = Lesson(2, 'content/lessons/002.md', true, LessonStatus.completed,
        DateTime.parse('2021-12-01 05:31:01'));
    var u = User(List<Lesson>.from([l1, l2]), List<Review>.from([r1, r2]),
        PremiumKey("test key"));

    var jsonStr = jsonEncode(u);
    expect(jsonStr,
        """{"lessons":"[{\\"id\\":1,\\"contentLink\\":\\"content/lessons/001.md\\",\\"isPremiumContent\\":true,\\"status\\":\\"locked\\",\\"completeDate\\":\\"2021-12-01T05:32:01.000\\"},{\\"id\\":2,\\"contentLink\\":\\"content/lessons/002.md\\",\\"isPremiumContent\\":true,\\"status\\":\\"completed\\",\\"completeDate\\":\\"2021-12-01T05:31:01.000\\"}]","reviews":"[{\\"id\\":3,\\"lessonId\\":4,\\"contentLink\\":\\"content/review/003.json\\",\\"status\\":\\"apprentice\\",\\"nextReviewDate\\":\\"2021-12-21T05:30:01.000\\"},{\\"id\\":4,\\"lessonId\\":4,\\"contentLink\\":\\"content/review/004.json\\",\\"status\\":\\"guru\\",\\"nextReviewDate\\":\\"2021-12-11T05:30:01.000\\"}]","premiumKey":"{\\"key\\":\\"test key\\"}"}""");
  });

  test('Premium key validation', () {
    var key1 = PremiumKey("rqPA6iB71QM3uaumRVTn");
    var key2 = PremiumKey("aafasfdafasd");
    var key3 = PremiumKey("rqPA6i!71QM3uaumRV_\$");
    var key4 = PremiumKey("rqPA 6i B71 uaumRVTn");

    expect(key1.isKeyValid(), true);
    expect(key2.isKeyValid(), false);
    expect(key3.isKeyValid(), false);
    expect(key4.isKeyValid(), false);
  });
}
