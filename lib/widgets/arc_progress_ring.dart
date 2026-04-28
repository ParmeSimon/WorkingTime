import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ArcProgressRing extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color foreground;
  final Color background;

  const ArcProgressRing({
    super.key,
    required this.progress,
    required this.size,
    this.strokeWidth = 6,
    this.foreground = WTColors.accent,
    this.background = WTColors.border,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RingPainter(
          progress: progress.clamp(0.0, 1.0),
          strokeWidth: strokeWidth,
          foreground: foreground,
          background: background,
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color foreground;
  final Color background;

  _RingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.foreground,
    required this.background,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = background
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    // Progress arc
    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2,
        2 * pi * progress,
        false,
        Paint()
          ..color = foreground
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress ||
      old.foreground != foreground ||
      old.background != background;
}
