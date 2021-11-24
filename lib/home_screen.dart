import 'package:auto_size_text/auto_size_text.dart';
import 'package:cyber_ded_flutter/models/lesson.dart';
import 'package:cyber_ded_flutter/models/review.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

const List<double>? presetFontSizesNumbers = [60, 48, 30, 16];
const List<double>? presetFontSizesText = [30, 24, 16];
const List<double>? presetFontSizesSRSStatus = [18, 16];

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(
            flex: 5,
          ),
          Consumer<User>(
            builder: (context, userModel, childId) {
              return AutoSizeText(
                  userModel.lessons
                      .where(
                          (lesson) => lesson.status == LessonStatus.completed)
                      .length
                      .toString(),
                  presetFontSizes: presetFontSizesNumbers,
                  style: const TextStyle(fontWeight: FontWeight.bold));
            },
          ),
          const AutoSizeText('Уроков пройдено',
              presetFontSizes: presetFontSizesText,
              style: TextStyle(fontWeight: FontWeight.normal)),
          const Spacer(
            flex: 5,
          ),
          Consumer<User>(
            builder: (context, user, childId) {
              return AutoSizeText(getReviewAccuracy(user),
                  presetFontSizes: presetFontSizesNumbers,
                  style: const TextStyle(fontWeight: FontWeight.bold));
            },
          ),
          const AutoSizeText('Точность повторений',
              maxLines: 1,
              presetFontSizes: presetFontSizesText,
              style: TextStyle(fontWeight: FontWeight.normal)),
          const Spacer(
            flex: 5,
          ),
          const AutoSizeText('Повторения',
              maxLines: 1,
              presetFontSizes: presetFontSizesText,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.underline)),
          const Spacer(
            flex: 1,
          ),
          Row(
            children: [
              const Spacer(
                flex: 5,
              ),
              Column(
                children: [
                  Consumer<User>(
                    builder: (context, userModel, child) {
                      return AutoSizeText(
                          userModel.reviews
                              .where((review) =>
                                  review.status == SRSStatus.apprentice)
                              .length
                              .toString(),
                          maxLines: 1,
                          presetFontSizes: presetFontSizesNumbers,
                          style: const TextStyle(fontWeight: FontWeight.bold));
                    },
                  ),
                  const AutoSizeText('ученик',
                      maxLines: 1,
                      presetFontSizes: presetFontSizesSRSStatus,
                      style: TextStyle(fontWeight: FontWeight.normal)),
                ],
              ),
              const Spacer(
                flex: 5,
              ),
              Column(
                children: [
                  Consumer<User>(
                    builder: (context, user, childId) {
                      return AutoSizeText(
                          user.reviews
                              .where(
                                  (review) => review.status == SRSStatus.guru)
                              .length
                              .toString(),
                          maxLines: 1,
                          presetFontSizes: presetFontSizesNumbers,
                          style: const TextStyle(fontWeight: FontWeight.bold));
                    },
                  ),
                  const AutoSizeText('гуру',
                      maxLines: 1,
                      presetFontSizes: presetFontSizesSRSStatus,
                      style: TextStyle(fontWeight: FontWeight.normal)),
                ],
              ),
              const Spacer(
                flex: 5,
              ),
              Column(
                children: [
                  Consumer<User>(
                    builder: (context, userModel, child) {
                      return AutoSizeText(
                          userModel.reviews
                              .where((review) =>
                                  review.status == SRSStatus.enlightened)
                              .length
                              .toString(),
                          maxLines: 1,
                          presetFontSizes: presetFontSizesNumbers,
                          style: const TextStyle(fontWeight: FontWeight.bold));
                    },
                  ),
                  const AutoSizeText('мастер',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      presetFontSizes: presetFontSizesSRSStatus,
                      style: TextStyle(fontWeight: FontWeight.normal)),
                ],
              ),
              const Spacer(
                flex: 5,
              ),
              Column(
                children: [
                  Consumer<User>(
                    builder: (context, userModel, child) {
                      return AutoSizeText(
                          userModel.reviews
                              .where(
                                  (review) => review.status == SRSStatus.burned)
                              .length
                              .toString(),
                          maxLines: 1,
                          presetFontSizes: presetFontSizesNumbers,
                          style: const TextStyle(fontWeight: FontWeight.bold));
                    },
                  ),
                  const AutoSizeText('готово',
                      maxLines: 1,
                      presetFontSizes: presetFontSizesSRSStatus,
                      style: TextStyle(fontWeight: FontWeight.normal)),
                ],
              ),
              const Spacer(
                flex: 5,
              ),
            ],
          ),
          const Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }

  String getReviewAccuracy(User user) {
    var completed = user.statistics.reviewStatistics
        .where((element) => element != false)
        .length;

    var all = user.statistics.reviewStatistics.length;
    var accuracy = completed / all * 100;

    if (!accuracy.isFinite) {
      accuracy = 0;
    }

    var result = accuracy.toStringAsFixed(0) + '%';

    return result;
  }
}
