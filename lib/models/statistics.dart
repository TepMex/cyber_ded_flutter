import 'dart:convert';

import 'package:cyber_ded_flutter/models/review.dart';

class Statistics {
  List<SRSStatus> reviewStatistics;

  Statistics(this.reviewStatistics);

  Statistics.fromJson(Map<String, dynamic> json)
      : reviewStatistics =
            (jsonDecode(json['reviewStatistics']) as List<dynamic>)
                .map((e) => SRSStatusSerializer.parse(e))
                .toList();

  Map<String, dynamic> toJson() => {
        'reviewStatistics': jsonEncode(reviewStatistics),
      };

  void logReviewEvent(SRSStatus newStatus) {
    reviewStatistics.add(newStatus);
  }
}
