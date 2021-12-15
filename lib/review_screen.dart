import 'package:cyber_ded_flutter/game_widget.dart';
import 'package:cyber_ded_flutter/models/lesson.dart';
import 'package:cyber_ded_flutter/models/review_game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/review.dart';
import 'models/user.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool _isGameRunning = false;
  bool _isGameLoading = false;
  Review? _currentReview;
  ReviewGame? _currentGame;
  List<Review> _reviewList = [];

  @override
  Widget build(BuildContext context) {
    if (_isGameRunning) {
      if (_currentGame != null && _currentReview != null && !_isGameLoading) {
        return gameWidget(_currentGame!);
      }
      return const CircularProgressIndicator();
    }
    return initialWidget();
  }

  Widget initialWidget() {
    return Center(
      child: Column(
        children: [
          const Spacer(flex: 1),
          actualReviews().isNotEmpty
              ? FloatingActionButton.extended(
                  label: const Text('Начать повторения'),
                  onPressed: () {
                    _initGameSession();
                  },
                )
              : const SizedBox.shrink(),
          Consumer<User>(builder: (context, userModel, child) {
            var reviewCount = actualReviews().length;
            if (reviewCount == 0) {
              if (userModel.lessons
                  .where((lesson) => lesson.status == LessonStatus.completed)
                  .isEmpty) {
                return const Text('Вы ещё не прошли ни одного урока');
              }
              var nextReviews = userModel.reviews
                  .where((review) => review.nextReviewDate != null)
                  .map((review) => review.nextReviewDate)
                  .toList();

              nextReviews.sort();
              if (nextReviews.isNotEmpty) {
                var next = nextReviews.first;
                var diff = next!.difference(DateTime.now());
                return Text(
                    'Повторение через ${diff.inDays} дн. ${diff.inHours - diff.inDays * 24} ч.');
              }
            }
            return Text('Доступно $reviewCount');
          }),
          const Spacer(flex: 1),
        ],
      ),
    );
  }

  Iterable<Review> actualReviews() {
    return Provider.of<User>(context, listen: false).reviews.where((review) =>
        review.status != SRSStatus.locked &&
        review.nextReviewDate != null &&
        review.nextReviewDate!.isBefore(DateTime.now()));
  }

  Widget gameWidget(ReviewGame game) {
    return GameWidget(
        onCompleted: (result) async {
          setState(() {
            _isGameLoading = true;
          });
          await Future.delayed(const Duration(milliseconds: 100));
          var user = Provider.of<User>(context, listen: false);
          user.reviewCompleted(_currentReview!.id, result);
          _nextGame();
        },
        game: game);
  }

  void _initGameSession() {
    setState(() {
      _reviewList = actualReviews().toList();
      _isGameRunning = true;
      _isGameLoading = true;
    });
    _nextGame();
  }

  Future _nextGame() async {
    if (_reviewList.isEmpty) {
      _showResults();
      setState(() {
        _currentGame = null;
        _currentReview = null;
        _isGameRunning = false;
      });
      return;
    }
    var reviewList = _reviewList;
    reviewList.shuffle();
    var nextReview = reviewList.elementAt(0);
    reviewList.removeAt(0);
    var nextGame = await nextReview.loadGame();

    setState(() {
      _reviewList = reviewList;
      _currentReview = nextReview;
      _currentGame = nextGame;
      _isGameLoading = false;
    });
  }

  void _showResults() {}
}
