// 折叠文本控件
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CollapseText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle? textStyle;

  const CollapseText({
    super.key,
    required this.text,
    required this.maxLines,
    this.textStyle,
  });

  @override
  CollapseTextState createState() => CollapseTextState();
}

class CollapseTextState extends State<CollapseText> {
  bool isExpanded = false;
  late TextStyle? effectiveStyle;

  @override
  Widget build(BuildContext context) {
    final bodyStyle = Theme.of(context).textTheme.bodyMedium;
    effectiveStyle = widget.textStyle != null
        ? bodyStyle?.merge(widget.textStyle)
        : bodyStyle;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final maxWidth = constraints.maxWidth;
        final textSpan = TextSpan(
          text: widget.text,
          style: effectiveStyle,
        );

        final textPainter = TextPainter(
          text: textSpan,
          maxLines: isExpanded ? null : widget.maxLines,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(maxWidth: maxWidth);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isExpanded
                ? _buildExpandedText()
                : _buildCollapsedText(textPainter, maxWidth),
          ],
        );
      },
    );
  }

  Widget _buildCollapsedText(TextPainter textPainter, double maxWidth) {
    final expandSpan = TextSpan(
      text: " 展开",
      style: const TextStyle(color: Colors.blue),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
    );

    final linkTextSpan = TextSpan(
      text: '...',
      style: effectiveStyle,
      children: [expandSpan],
    );

    final linkPainter = TextPainter(
      text: linkTextSpan,
      textDirection: TextDirection.ltr,
    );
    linkPainter.layout(maxWidth: maxWidth);

    final position = textPainter.getPositionForOffset(
        Offset(maxWidth - linkPainter.width, textPainter.height));
    final endOffset =
        textPainter.getOffsetBefore(position.offset) ?? position.offset;
    final truncatedText = widget.text.substring(0, endOffset);

    return RichText(
      text: TextSpan(
        text: truncatedText,
        style: effectiveStyle,
        children: [linkTextSpan],
      ),
      maxLines: widget.maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildExpandedText() {
    final collapseSpan = TextSpan(
      text: " 收起",
      style: const TextStyle(color: Colors.blue),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
    );

    return RichText(
      text: TextSpan(
        text: widget.text,
        style: effectiveStyle,
        children: [collapseSpan],
      ),
    );
  }
}
