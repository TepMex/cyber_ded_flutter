import 'package:cyber_ded_flutter/models/review.dart';

const Map<SRSStatus, Duration> srsStatusDuration = {
  SRSStatus.locked: Duration.zero,
  SRSStatus.unlocked: Duration.zero,
  SRSStatus.apprentice: Duration(days: 1),
  SRSStatus.guru: Duration(days: 3),
  SRSStatus.enlightened: Duration(days: 14),
  SRSStatus.burned: Duration(days: 30),
};

SRSStatus nextStatus(SRSStatus currentStatus) {
  switch (currentStatus) {
    case SRSStatus.locked:
      return SRSStatus.unlocked;
    case SRSStatus.unlocked:
      return SRSStatus.apprentice;
    case SRSStatus.apprentice:
      return SRSStatus.guru;
    case SRSStatus.guru:
      return SRSStatus.enlightened;
    case SRSStatus.enlightened:
      return SRSStatus.burned;
    case SRSStatus.burned:
      return SRSStatus.burned;
  }
}

SRSStatus previousStatus(SRSStatus currentStatus) {
  switch (currentStatus) {
    case SRSStatus.locked:
      return SRSStatus.unlocked;
    case SRSStatus.unlocked:
      return SRSStatus.apprentice;
    case SRSStatus.apprentice:
      return SRSStatus.apprentice;
    case SRSStatus.guru:
      return SRSStatus.apprentice;
    case SRSStatus.enlightened:
      return SRSStatus.apprentice;
    case SRSStatus.burned:
      return SRSStatus.burned;
  }
}
