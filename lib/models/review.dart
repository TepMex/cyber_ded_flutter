import 'package:cyber_ded_flutter/utils/srs.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

enum SRSStatus { locked, unlocked, apprentice, guru, enlightened, burned }

extension SRSStatusSerializer on SRSStatus {
  String get name => describeEnum(this);

  static SRSStatus parse(statusName) {
    return SRSStatus.values.firstWhere((e) => e.name == statusName);
  }
}

@JsonSerializable()
class Review {
  final int id;
  final int lessonId;
  final String contentLink;
  SRSStatus status;
  DateTime? nextReviewDate;

  Review(this.id, this.lessonId, this.contentLink, this.status,
      this.nextReviewDate);

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  void complete(bool success) {
    if (success) {
      status = nextStatus(status);
    } else {
      status = previousStatus(status);
    }
    nextReviewDate =
        (nextReviewDate ?? DateTime.now()).add(srsStatusDuration[status]!);
  }
}
