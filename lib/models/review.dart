import 'package:flutter/foundation.dart';

enum SRSStatus { locked, unlocked, apprentice, guru, enlightened, burned }

extension SRSStatusSerializer on SRSStatus {
  String get name => describeEnum(this);

  static SRSStatus parse(statusName) {
    return SRSStatus.values.firstWhere((e) => e.name == statusName);
  }
}

class Review {
  final int id;
  final int lessonId;
  final String contentLink;
  SRSStatus status;
  DateTime? nextReviewDate;

  Review(this.id, this.lessonId, this.contentLink, this.status,
      this.nextReviewDate);

  Review.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        lessonId = json['lessonId'],
        contentLink = json['contentLink'],
        status = SRSStatusSerializer.parse(json['status']),
        nextReviewDate = json['nextReviewDate'] == null
            ? null
            : DateTime.tryParse(json['nextReviewDate']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'lessonId': lessonId,
        'contentLink': contentLink,
        'status': status.name,
        'nextReviewDate': nextReviewDate?.toIso8601String() ?? nextReviewDate
      };

  void complete(bool success) {
    throw UnimplementedError('В зависимости от успеха, меняем status');
  }
}
