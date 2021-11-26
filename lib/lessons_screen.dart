import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (context, userModel, child) {
        return GridView.count(
            crossAxisCount: 2,
            children: userModel.lessons.map((lesson) {
              return Center(
                child: Text(
                  Uri.decodeFull(lesson.title),
                  style: Theme.of(context).textTheme.headline5,
                ),
              );
            }).toList());
      },
    );
  }
}

class LessonWidget extends StatelessWidget {
  final String mdContent;

  const LessonWidget({
    Key? key,
    required this.mdContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(flex: 1),
        Expanded(
          flex: kIsWeb ? 2 : 20,
          child: Markdown(
            styleSheet: MarkdownStyleSheet(
              textScaleFactor: kIsWeb ? 2 : 1.25,
            ),
            data: mdContent,
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
