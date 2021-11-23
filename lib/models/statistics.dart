import 'dart:convert';

class Statistics {
  List<bool> reviewStatistics;

  Statistics(this.reviewStatistics);

  Statistics.fromJson(Map<String, dynamic> json)
      : reviewStatistics =
            (jsonDecode(json['reviewStatistics']) as List<dynamic>)
                .map((e) => bool.fromEnvironment(e))
                .toList();

  Map<String, dynamic> toJson() => {
        'reviewStatistics': jsonEncode(reviewStatistics),
      };

  void logReviewEvent(bool newStatus) {
    reviewStatistics.add(newStatus);
  }
}
