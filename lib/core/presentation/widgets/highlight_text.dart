import 'package:flutter/material.dart';

class HighlightText extends StatelessWidget {
  const HighlightText(
    this.data, {
    required this.highlight,
    this.contextClip = false,
    this.maxLines = 2,
    this.overflow = TextOverflow.ellipsis,
    super.key,
  });

  final String data;
  final String highlight;
  final bool contextClip;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    if (highlight.isEmpty) return Text(data, maxLines: maxLines, overflow: overflow);

    final bg = Theme.of(context).colorScheme.secondaryContainer;
    final lowerSrc = data.toLowerCase();
    final lowerQry = highlight.toLowerCase();

    final matchLength = highlight.length;

    if (!contextClip) {
      final spans = <TextSpan>[];
      var start = 0;

      while (true) {
        final idx = lowerSrc.indexOf(lowerQry, start);
        if (idx == -1) break;

        if (idx > start) {
          spans.add(TextSpan(text: data.substring(start, idx)));
        }

        spans.add(TextSpan(text: data.substring(idx, idx + matchLength), style: TextStyle(backgroundColor: bg)));

        start = idx + matchLength;
      }

      if (start < data.length) {
        spans.add(TextSpan(text: data.substring(start)));
      }

      return Text.rich(TextSpan(children: spans));
    } else {
      const contextChars = 20;
      const maxFragments = 3;

      final spans = <TextSpan>[];
      var start = 0;
      var matchCount = 0;

      while (matchCount < maxFragments) {
        final idx = lowerSrc.indexOf(lowerQry, start);
        if (idx == -1) break;

        final contextStart = (idx - contextChars).clamp(0, data.length);
        final contextEnd = (idx + matchLength + contextChars).clamp(0, data.length);

        if (contextStart > start) {
          spans.add(const TextSpan(text: '…'));
        }

        final before = data.substring(contextStart, idx);
        final match = data.substring(idx, idx + matchLength);
        final after = data.substring(idx + matchLength, contextEnd);

        if (before.isNotEmpty) {
          spans.add(TextSpan(text: before));
        }
        spans.add(TextSpan(text: match, style: TextStyle(backgroundColor: bg)));
        if (after.isNotEmpty) {
          spans.add(TextSpan(text: after));
        }

        start = contextEnd;
        matchCount++;
      }

      if (start < data.length) {
        spans.add(const TextSpan(text: '…'));
      }

      return Text.rich(TextSpan(children: spans), maxLines: maxLines, overflow: overflow);
    }
  }
}
