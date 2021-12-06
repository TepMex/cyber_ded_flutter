import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cyber_ded_flutter/models/review_game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GameWidget extends StatefulWidget {
  final Function onCompleted;
  final ReviewGame game;
  const GameWidget({Key? key, required this.onCompleted, required this.game})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  ReviewGamePassage? _currentPassage;

  @override
  void initState() {
    super.initState();
    _currentPassage = widget.game.getStartPassage();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('game disposed');
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPassage == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Row(
      children: [
        const Spacer(flex: 1),
        Expanded(
          flex: kIsWeb ? 2 : 12,
          child: Column(children: [
            const Spacer(flex: 1),
            gameTitle(),
            passageText(),
            Expanded(
              flex: 3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _currentPassage!.links.isNotEmpty
                      ? passageLinks()
                      : nextReviewButton(),
                ),
              ),
            ),
            const Spacer(flex: 1),
          ]),
        ),
        const Spacer(flex: 1),
      ],
    );
  }

  Widget gameTitle() {
    var isLastPassage =
        _currentPassage!.links.isEmpty && _currentPassage!.result != null;
    Widget titleIcon = const SizedBox.shrink();
    var color = Colors.black;
    if (isLastPassage) {
      color = _currentPassage!.result! ? Colors.green : Colors.red;
      titleIcon = _currentPassage!.result!
          ? Icon(
              Icons.check,
              color: color,
            )
          : Icon(
              Icons.close,
              color: color,
            );
    }
    return Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            titleIcon,
            AutoSizeText(
              widget.game.name,
              presetFontSizes: const [30, 24, 16],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ));
  }

  Widget passageText() {
    return Expanded(
        flex: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _currentPassage!.textContent,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ));
  }

  List<Widget> passageLinks() {
    return _currentPassage!.links.map((link) => passageLink(link)).toList();
  }

  Widget passageLink(ReviewGamePassageLink link) {
    return GestureDetector(
        onTap: () {
          linkClicked(link.refPid);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text.rich(TextSpan(
              text: link.linkText,
              style: const TextStyle(
                  fontSize: 16, decoration: TextDecoration.underline))),
        ));
  }

  void linkClicked(String refPid) {
    ReviewGamePassage nextPassage = widget.game.getPassageById(refPid);
    setState(() {
      _currentPassage = nextPassage;
    });
  }

  List<Widget> nextReviewButton() {
    return [
      FloatingActionButton.large(
        child: const Text(
          'Следующее ревью',
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          var result = _currentPassage!.result;
          widget.onCompleted(result);
        },
      )
    ];
  }
}
