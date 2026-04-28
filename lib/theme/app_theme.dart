import 'package:flutter/material.dart';

// ── Palette ────────────────────────────────────────────────────────────────

class WTColors {
  WTColors._();

  static const background = Color(0xFFF5F4F0);
  static const primary    = Color(0xFF0D0D0D);
  static const accent     = Color(0xFFC8FF00); // neon lime
  static const secondary  = Color(0xFF6B6B6B);
  static const surface    = Color(0xFFFFFFFF);
  static const border     = Color(0xFFE2E2E2);
  static const red        = Color(0xFFFF3B30);
}

// ── Text styles ────────────────────────────────────────────────────────────

class WTText {
  WTText._();

  static TextStyle display(double size) => TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w900,
        color: WTColors.primary,
        letterSpacing: -1,
        height: 1.0,
      );

  static TextStyle heading(double size) => TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: WTColors.primary,
        letterSpacing: -0.5,
      );

  static TextStyle body(double size) => TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w400,
        color: WTColors.primary,
      );

  static TextStyle mono(double size) => TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w600,
        fontFamily: 'monospace',
        color: WTColors.primary,
        letterSpacing: -0.5,
      );

  static TextStyle label(double size) => TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w600,
        color: WTColors.primary,
        letterSpacing: 0.2,
      );

  static TextStyle caps(double size) => TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w600,
        color: WTColors.secondary,
        letterSpacing: 2.0,
      );
}

// ── Theme ─────────────────────────────────────────────────────────────────

ThemeData buildTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: WTColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: WTColors.accent,
      brightness: Brightness.light,
      surface: WTColors.surface,
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    fontFamily: 'SF Pro Display',
  );
}
