import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class LessonsScreen extends StatelessWidget {
  final String mdContent;
  const LessonsScreen({Key? key, required this.mdContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(flex: 1),
        Expanded(
          flex: 2,
          child: Markdown(
            styleSheet: MarkdownStyleSheet(
              textScaleFactor: 2,
            ),
            data: mdContent,
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
