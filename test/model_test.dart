import 'dart:convert';
import 'dart:math';

import 'package:cyber_ded_flutter/models/lesson.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Lesson fromJson deserialization', () {
    String jsonLesson = '''{
      "id": 1,
      "contentLink": "content/lessons/001.md",
      "isPremiumContent": false,
      "status": "open",
      "completeDate": "2021-12-01 05:30:01"
    }''';

    Lesson actual = Lesson.fromJson(jsonDecode(jsonLesson));

    expect(actual.id, 1);
    expect(actual.contentLink, 'content/lessons/001.md');
    expect(actual.isPremiumContent, false);
    expect(actual.status, LessonStatus.open);
    expect(actual.completeDate, DateTime.parse('2021-12-01 05:30:01'));
  });

  test('Lesson toJson serialization', () {
    Lesson l = Lesson(1, 'content/lessons/001.md', true, LessonStatus.locked,
        DateTime.parse('2021-12-01 05:30:01'));

    String jsonStr = jsonEncode(l.toJson());

    expect(jsonStr,
        '''{"id":1,"contentLink":"content/lessons/001.md","isPremiumContent":true,"status":"locked","completeDate":"2021-12-01T05:30:01.000"}''');
  });
}
