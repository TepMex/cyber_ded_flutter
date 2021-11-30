import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'models/lesson.dart';
import 'models/user.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonsScreen> {
  Lesson? _currentLesson;

  @override
  Widget build(BuildContext context) {
    if (_currentLesson == null) {
      return lessonsGrid();
    }

    return FutureBuilder(
        future: loadLessonMdContent(_currentLesson!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return LessonWidget(
              mdContent: (snapshot.data!) as String,
              onComplete: onLessonComplete,
            );
          }
          return const CircularProgressIndicator();
        });
  }

  Consumer<User> lessonsGrid() {
    return Consumer<User>(
      builder: (context, userModel, child) {
        return GridView.count(
            crossAxisCount: kIsWeb ? 2 : 1,
            childAspectRatio: kIsWeb
                ? MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height)
                : MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height) *
                    2,
            children: userModel.lessons.map((lesson) {
              return GestureDetector(
                onTap: () {
                  if (lesson.status != LessonStatus.locked &&
                      lesson.status != LessonStatus.payLocked) {
                    setState(() {
                      _currentLesson = lesson;
                    });
                  }
                },
                child: Center(
                  child: Column(
                    children: [
                      Stack(alignment: AlignmentDirectional.center, children: [
                        Transform.rotate(
                          angle: 30 * math.pi / 360,
                          child: AutoSizeText(
                            lesson.status == LessonStatus.payLocked
                                ? 'платный контент'
                                : '',
                            presetFontSizes: const [30, 24, 16, 8],
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Image.asset(
                          lesson.imagePath,
                          bundle: rootBundle,
                          opacity: lesson.status == LessonStatus.payLocked
                              ? const AlwaysStoppedAnimation<double>(0.5)
                              : null,
                          width: 512,
                          height: 320,
                        ),
                      ]),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                getIconByLessonStatus(lesson),
                                AutoSizeText(
                                  Uri.decodeFull(lesson.title),
                                  presetFontSizes:
                                      kIsWeb ? [32, 24, 16] : [16, 8],
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  maxLines: 4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Expanded(
                          child: Divider(
                        height: 30,
                        thickness: 5,
                      )),
                    ],
                  ),
                ),
              );
            }).toList());
      },
    );
  }

  Future<String> loadLessonMdContent(Lesson currentLesson) async {
    var result = await rootBundle.loadString(currentLesson.contentLink);
    return result;
  }

  void onLessonComplete() {
    Provider.of<User>(context, listen: false)
        .lessonCompleted(_currentLesson!.id);
    setState(() {
      _currentLesson = null;
    });
  }

  Icon getIconByLessonStatus(Lesson lesson) {
    switch (lesson.status) {
      case LessonStatus.payLocked:
        return const Icon(
          Icons.monetization_on,
          color: Colors.red,
        );
      case LessonStatus.locked:
        return const Icon(
          Icons.lock,
          color: Colors.red,
        );
      case LessonStatus.open:
        return const Icon(
          Icons.circle,
          color: Colors.yellow,
        );
      case LessonStatus.completed:
        return const Icon(
          Icons.check,
          color: Colors.green,
        );
    }
  }
}

class LessonWidget extends StatelessWidget {
  final String mdContent;
  final Function onComplete;

  const LessonWidget({
    Key? key,
    required this.mdContent,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(flex: 1),
        Expanded(
          flex: kIsWeb ? 2 : 20,
          child: Column(
            children: [
              SizedBox(
                height:
                    MediaQuery.of(context).size.height - (kIsWeb ? 150 : 200),
                child: Markdown(
                  styleSheet: MarkdownStyleSheet(
                    textScaleFactor: kIsWeb ? 2 : 1.25,
                  ),
                  data: mdContent,
                ),
              ),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      onComplete();
                    },
                    child: const Text('Я прочитал')),
              ),
            ],
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
