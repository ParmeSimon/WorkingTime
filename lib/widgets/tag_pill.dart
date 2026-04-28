import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TagPill extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  const TagPill({
    super.key,
    required this.text,
    this.color = WTColors.accent,
    this.textColor = WTColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: WTText.label(11).copyWith(color: textColor),
      ),
    );
  }
}
