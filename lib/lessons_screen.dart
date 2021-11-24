import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
