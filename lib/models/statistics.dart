import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'statistics.g.dart';

@JsonSerializable()
class Statistics {
  List<bool> reviewStatistics;

  Statistics(this.reviewStatistics);

  factory Statistics.fromJson(Map<String, dynamic> json) =>
      _$StatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsToJson(this);

  void logReviewEvent(bool newStatus) {
    reviewStatistics.add(newStatus);
  }
}
