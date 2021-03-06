import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

enum LessonStatus { payLocked, locked, open, completed }

extension LessonStatusSerializer on LessonStatus {
  String get name => describeEnum(this);

  static LessonStatus parse(statusName) {
    return LessonStatus.values.firstWhere((e) => e.name == statusName);
  }
}

@JsonSerializable()
class Lesson extends ChangeNotifier {
  final int id;
  final String contentLink;
  bool isPremiumContent;
  LessonStatus status;
  DateTime? completeDate;
  String title;
  String imagePath;

  Lesson(this.id, this.contentLink, this.isPremiumContent, this.status,
      this.completeDate, this.title, this.imagePath);

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  Map<String, dynamic> toJson() => _$LessonToJson(this);

  void complete() {
    status = LessonStatus.completed;
    completeDate = DateTime.now();
  }

  void unlock(bool isValidKeySaved) {
    if (isValidKeySaved &&
        (status == LessonStatus.locked || status == LessonStatus.payLocked)) {
      status = LessonStatus.open;
    } else if (status == LessonStatus.locked) {
      status = LessonStatus.open;
    }
  }
}
