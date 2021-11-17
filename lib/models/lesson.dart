import 'package:flutter/foundation.dart';

enum LessonStatus { payLocked, locked, open, completed }

extension LessonStatusSerializer on LessonStatus {
  String get name => describeEnum(this);

  static LessonStatus parse(statusName) {
    return LessonStatus.values.firstWhere((e) => e.name == statusName);
  }
}

class Lesson {
  final int id;
  final String contentLink;
  bool isPremiumContent;
  LessonStatus status;
  DateTime? completeDate;

  Lesson(this.id, this.contentLink, this.isPremiumContent, this.status,
      this.completeDate);

  Lesson.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        contentLink = json['contentLink'],
        isPremiumContent = json['isPremiumContent'],
        status = LessonStatusSerializer.parse(json['status']),
        completeDate = DateTime.parse(json['completeDate']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'contentLink': contentLink,
        'isPremiumContent': isPremiumContent,
        'status': status.name,
        'completeDate': completeDate?.toIso8601String() ?? completeDate
      };

  void complete() {
    status = LessonStatus.completed;
    completeDate = DateTime.now();
  }
}
